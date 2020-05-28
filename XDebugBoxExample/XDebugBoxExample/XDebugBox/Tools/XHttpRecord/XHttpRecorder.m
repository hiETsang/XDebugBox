//
//  XHttpRecorder.m
//  XDebugBoxExample
//
//  Created by canoe on 2017/7/8.
//  Copyright © 2019 canoe. All rights reserved.
//

#import "XHttpRecorder.h"


@implementation XHttpModel

#pragma mark - parse
+ (NSString *)prettyJSONStringFromData:(NSData *)data
{
    NSString *prettyString = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if ([NSJSONSerialization isValidJSONObject:jsonObject]) {
        prettyString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding];
        prettyString = [prettyString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    } else {
        prettyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return prettyString;
}

+ (NSString *)stringFromRequestDuration:(NSTimeInterval)duration
{
    NSString *string = @"0s";
    if (duration > 0.0) {
        if (duration < 1.0) {
            string = [NSString stringWithFormat:@"%dms", (int)(duration * 1000)];
        } else if (duration < 10.0) {
            string = [NSString stringWithFormat:@"%.2fs", duration];
        } else {
            string = [NSString stringWithFormat:@"%.1fs", duration];
        }
    }
    return string;
}

@end

NSString *const kXHttpRecorderNewTransactionNotification = @"kXHttpRecorderNewTransactionNotification";
NSString *const kXHttpRecorderTransactionUpdatedNotification = @"kXHttpRecorderTransactionUpdatedNotification";
NSString *const kXHttpRecorderUserInfoTransactionKey = @"transaction";
NSString *const kXHttpRecorderTransactionsClearedNotification = @"kXHttpRecorderTransactionsClearedNotification";

@interface XHttpRecorder ()
@property (nonatomic,strong) NSMutableArray *httpArray;
@property (nonatomic, strong) NSMutableDictionary<NSString *, XHttpModel *> *networkTransactionsForRequestIdentifiers;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation XHttpRecorder


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpArray = [NSMutableArray array];
        self.networkTransactionsForRequestIdentifiers = [NSMutableDictionary dictionary];
        // Serial queue used because we use mutable objects that are not thread safe
        self.queue = dispatch_queue_create("com.x.XHttpRecorder", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (instancetype)defaultRecorder
{
    static XHttpRecorder *defaultRecorder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultRecorder = [[[self class] alloc] init];
    });
    return defaultRecorder;
}

- (void)clear {
    @synchronized(self.httpArray) {
        [self.httpArray removeAllObjects];
    }
    
    @synchronized(self.networkTransactionsForRequestIdentifiers){
        [self.networkTransactionsForRequestIdentifiers removeAllObjects];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kXHttpRecorderTransactionsClearedNotification object:self];
}


#pragma mark - Network Events

- (void)recordRequestWillBeSentWithRequestID:(NSString *)requestID request:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    
    NSDate *startDate = [NSDate date];
    
    if (redirectResponse) {
        [self recordResponseReceivedWithRequestID:requestID response:redirectResponse];
        [self recordLoadingFinishedWithRequestID:requestID responseBody:nil];
    }
    
    dispatch_async(self.queue, ^{
        XHttpModel *model = [[XHttpModel alloc] init];
        model.requestId = requestID;
        model.url = request.URL;
        model.method = request.HTTPMethod;
        if (request.HTTPBody) {
            NSData* data = request.HTTPBody;
            model.requestBody = [XHttpModel prettyJSONStringFromData:data];
        }
        model.startTime = startDate;
        
        [self.httpArray insertObject:model atIndex:0];
        [self.networkTransactionsForRequestIdentifiers setObject:model forKey:requestID];
        
        //限制最大的记录数 100条
        if (self.httpArray.count > 100) {
            XHttpModel *lastModel = self.httpArray.lastObject;
            [self.networkTransactionsForRequestIdentifiers removeObjectForKey:lastModel.requestId];
            [self.httpArray removeLastObject];
        }
        
        [self postNewTransactionNotificationWithTransaction:model];
    });
}

- (void)recordResponseReceivedWithRequestID:(NSString *)requestID response:(NSURLResponse *)response
{
    NSDate *responseDate = [NSDate date];
    
    dispatch_async(self.queue, ^{
        XHttpModel *model = self.networkTransactionsForRequestIdentifiers[requestID];
        if (!model) {
            return;
        }
        model.mineType = response.MIMEType;
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        model.statusCode = [NSString stringWithFormat:@"%d",(int)httpResponse.statusCode];
        model.latency = -[model.startTime timeIntervalSinceDate:responseDate];
        model.isImage = [response.MIMEType rangeOfString:@"image"].location != NSNotFound;
        
        [self postUpdateNotificationForTransaction:model];
    });
}

- (void)recordDataReceivedWithRequestID:(NSString *)requestID dataLength:(int64_t)dataLength
{
    dispatch_async(self.queue, ^{
        XHttpModel *model = self.networkTransactionsForRequestIdentifiers[requestID];
        if (!model) {
            return;
        }
        model.receivedDataLength += dataLength;
        
        [self postUpdateNotificationForTransaction:model];
    });
}

- (void)recordLoadingFinishedWithRequestID:(NSString *)requestID responseBody:(NSData *)responseBody
{
    NSDate *finishedDate = [NSDate date];
    
    dispatch_async(self.queue, ^{
        XHttpModel *model = self.networkTransactionsForRequestIdentifiers[requestID];
        if (!model) {
            return;
        }
        model.totalDuration = -[model.startTime timeIntervalSinceDate:finishedDate];
        model.responseData = responseBody;
        
        [self postUpdateNotificationForTransaction:model];
    });
}

- (void)recordLoadingFailedWithRequestID:(NSString *)requestID error:(NSError *)error
{
    dispatch_async(self.queue, ^{
        XHttpModel *model = self.networkTransactionsForRequestIdentifiers[requestID];
        if (!model) {
            return;
        }
        model.totalDuration = -[model.startTime timeIntervalSinceNow];
        model.error = error;
        
        [self postUpdateNotificationForTransaction:model];
    });
}

- (void)recordMechanism:(NSString *)mechanism forRequestID:(NSString *)requestID
{
    dispatch_async(self.queue, ^{
        XHttpModel *model = self.networkTransactionsForRequestIdentifiers[requestID];
        if (!model) {
            return;
        }
        model.requestMechanism = mechanism;
        
        [self postUpdateNotificationForTransaction:model];
    });
}

#pragma mark Notification Posting

- (void)postNewTransactionNotificationWithTransaction:(XHttpModel *)transaction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary<NSString *, id> *userInfo = @{ kXHttpRecorderUserInfoTransactionKey : transaction };
        [[NSNotificationCenter defaultCenter] postNotificationName:kXHttpRecorderNewTransactionNotification object:self userInfo:userInfo];
    });
}

- (void)postUpdateNotificationForTransaction:(XHttpModel *)transaction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary<NSString *, id> *userInfo = @{ kXHttpRecorderUserInfoTransactionKey : transaction };
        [[NSNotificationCenter defaultCenter] postNotificationName:kXHttpRecorderTransactionUpdatedNotification object:self userInfo:userInfo];
    });
}


@end
