//
//  XHttpRecorder.h
//  XDebugBoxExample
//
//  Created by canoe on 2018/7/8.
//  Copyright © 2018 canoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHttpModel : NSObject

@property (nonatomic,copy)NSString  *requestId;
@property (nonatomic,copy)NSURL     *url;
@property (nonatomic,copy)NSString  *method;
@property (nonatomic,copy)NSString  *requestBody;
@property (nonatomic,copy)NSString  *statusCode;
@property (nonatomic,copy)NSData    *responseData;
@property (nonatomic,assign)BOOL    isImage;
@property (nonatomic,copy)NSString  *mineType;
@property (nonatomic,strong)NSDate  *startTime;
@property (nonatomic,assign)NSTimeInterval  totalDuration;
@property(nonatomic, assign)NSTimeInterval latency;  //延迟
@property (nonatomic, assign) int64_t receivedDataLength;   //返回数据长度
@property (nonatomic, copy) NSString *requestMechanism;
@property (nonatomic, strong) NSError *error;

/**
 *  解析
 */
+ (NSString *)prettyJSONStringFromData:(NSData *)data;

+ (NSString *)stringFromRequestDuration:(NSTimeInterval)duration;

@end

extern NSString *const kXHttpRecorderNewTransactionNotification;
extern NSString *const kXHttpRecorderTransactionUpdatedNotification;
extern NSString *const kXHttpRecorderUserInfoTransactionKey;
extern NSString *const kXHttpRecorderTransactionsClearedNotification;

@interface XHttpRecorder : NSObject

+ (instancetype)defaultRecorder;

- (void)clear;

@property (nonatomic,strong,readonly) NSMutableArray<XHttpModel *> *httpArray;

// Recording network activity

/// Call when app is about to send HTTP request.
- (void)recordRequestWillBeSentWithRequestID:(NSString *)requestID request:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse;

/// Call when HTTP response is available.
- (void)recordResponseReceivedWithRequestID:(NSString *)requestID response:(NSURLResponse *)response;

/// Call when data chunk is received over the network.
- (void)recordDataReceivedWithRequestID:(NSString *)requestID dataLength:(int64_t)dataLength;

/// Call when HTTP request has finished loading.
- (void)recordLoadingFinishedWithRequestID:(NSString *)requestID responseBody:(NSData *)responseBody;

/// Call when HTTP request has failed to load.
- (void)recordLoadingFailedWithRequestID:(NSString *)requestID error:(NSError *)error;

/// Call to set the request mechanism anytime after recordRequestWillBeSent... has been called.
/// This string can be set to anything useful about the API used to make the request.
- (void)recordMechanism:(NSString *)mechanism forRequestID:(NSString *)requestID;

@end
