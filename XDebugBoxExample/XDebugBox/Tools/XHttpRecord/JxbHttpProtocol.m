//
//  JxbHttpProtocol.m
//  JxbHttpProtocol
//
//  Created by Peter Jin @ https://github.com/JxbSir on 15/11/12.
//  Copyright (c) 2015年 Mail:i@Jxb.name. All rights reserved.
//

#import "JxbHttpProtocol.h"
#import <UIKit/UIKit.h>
#import "XHttpRecordController.h"
#import "JxbHttpDatasource.h"
#import "NSURLRequest+Identify.h"

#define myProtocolKey   @"JxbHttpProtocol"


@interface JxbHttpProtocol()<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) NSTimeInterval  startTime;
@end

@implementation JxbHttpProtocol


#pragma mark - protocol
+ (void)load {
    
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (![request.URL.scheme isEqualToString:@"http"] &&
        ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    
    if ([NSURLProtocol propertyForKey:myProtocolKey inRequest:request] ) {
        return NO;
    }
    //是否需要过滤抓取
//    if ([[JxbDebugTool shareInstance] arrOnlyHosts].count > 0) {
//        NSString* url = [request.URL.absoluteString lowercaseString];
//        for (NSString* _url in [JxbDebugTool shareInstance].arrOnlyHosts) {
//            if ([url rangeOfString:[_url lowercaseString]].location != NSNotFound)
//                return YES;
//        }
//        return NO;
//    }
    
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:myProtocolKey inRequest:mutableReqeust];
    return [mutableReqeust copy];
}

- (void)startLoading {
    self.data = [NSMutableData data];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    self.connection = [[NSURLConnection alloc] initWithRequest:[[self class] canonicalRequestForRequest:self.request] delegate:self startImmediately:YES];
#pragma clang diagnostic pop
    self.startTime = [[NSDate date] timeIntervalSince1970];
}

- (void)stopLoading {
    [self.connection cancel];
    
    if ([[[JxbHttpDatasource shareInstance] arrRequest] containsObject:self.request.requestId])
        return;
    
    JxbHttpModel* model = [[JxbHttpModel alloc] init];
    model.url = self.request.URL;
    model.method = self.request.HTTPMethod;
    model.mineType = self.response.MIMEType;
    if (self.request.HTTPBody) {
        NSData* data = self.request.HTTPBody;
        //是否需要加密数据
//        if ([[JxbDebugTool shareInstance] isHttpRequestEncrypt]) {
//            if ([[JxbDebugTool shareInstance] delegate] && [[JxbDebugTool shareInstance].delegate respondsToSelector:@selector(decryptJson:)]) {
//                data = [[JxbDebugTool shareInstance].delegate decryptJson:self.request.HTTPBody];
//            }
//        }
        model.requestBody = [JxbHttpDatasource prettyJSONStringFromData:data];
    }
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)self.response;
    model.statusCode = [NSString stringWithFormat:@"%d",(int)httpResponse.statusCode];
    model.responseData = self.data;
    model.isImage = [self.response.MIMEType rangeOfString:@"image"].location != NSNotFound;
    model.totalDuration = [NSString stringWithFormat:@"%fs",[[NSDate date] timeIntervalSince1970] - self.startTime];
    model.startTime = [NSString stringWithFormat:@"%fs",self.startTime];
    
    [[JxbHttpDatasource shareInstance] addHttpRequset:model];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyKeyReloadHttp object:nil];
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[self client] URLProtocol:self didFailWithError:error];
    self.error = error;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [[self client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [[self client] URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self client] URLProtocol:self didLoadData:data];
    [self.data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
}
@end
