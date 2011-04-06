//
//  ENAPIPostRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//


#import <Foundation/Foundation.h>

@class ENAPIPostRequest;
@protocol ENAPIPostRequestDelegate <NSObject>
@optional

- (void)postRequestFinished:(ENAPIPostRequest *)request;
- (void)postRequestFailed:(ENAPIPostRequest *)request;
- (void)postRequest:(ENAPIPostRequest *)request uploadProgress:(long long)progress;

@end

/**
 * Implements a multipart/form-data POST request
 */

@interface ENAPIPostRequest : NSObject  {
    
}

+ (ENAPIPostRequest *)trackUploadRequestWithFile:(NSString *)filePath;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithFile:(NSString *)filePath;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithId:(NSString *)trackid;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithMD5:(NSString *)md5;

/**
 * Catalog requests.
 * http://developer.echonest.com/docs/v4/catalog.html#overview
 */

/**
 * http://developer.echonest.com/docs/v4/catalog.html#create
 */
+ (ENAPIPostRequest *)catalogCreateWithName:(NSString *)name type:(NSString *)type;

/**
 * http://developer.echonest.com/docs/v4/catalog.html#delete
 */
+ (ENAPIPostRequest *)catalogDeleteWithID:(NSString *)ID;

/**
 * http://developer.echonest.com/docs/v4/catalog.html#update
 */
+ (ENAPIPostRequest *)catalogUpdateWithID:(NSString *)ID data:(NSString *)json;

- (void)setPostValue:(NSObject *)value forKey:(NSString *)key;
- (void)setFile:(NSString *)path forKey:(NSString *)key;
- (void)startSynchronous;
- (void)startAsynchronous;

@property (assign) NSObject *delegate;
@property (readonly) NSDictionary *response;
@property (readonly) NSUInteger responseStatusCode;
@property (readonly) NSUInteger echonestStatusCode;
@property (readonly) NSString *echonestStatusMessage;
@property (readonly) NSError *error;

@end
