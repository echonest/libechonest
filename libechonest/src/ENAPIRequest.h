//
//  ENAPIRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//


#import <Foundation/Foundation.h>
#import "ENParamDictionary.h"

@class ENAPIRequest;
@protocol ENAPIRequestDelegate <NSObject>
@optional

- (void)requestFinished:(ENAPIRequest *)request;
- (void)requestFailed:(ENAPIRequest *)request;

@end

@interface ENAPIRequest : NSObject {

}

/**
 * Endpoint is an Echonest API endpoint, e.g., "artist/audio"
 */
+ (ENAPIRequest *)requestWithEndpoint:(NSString *)endpoint;
/**
 * This is a special request for full analysis data. Pass in the
 * `analysis_url` from an audio summary.
 */
+ (ENAPIRequest *)requestWithAnalysisURL:(NSString *)url;


- (ENAPIRequest *)initWithEndpoint:(NSString *)endpoint;
- (ENAPIRequest *)initWithAnalysisURL:(NSString *)url;

- (void)startSynchronous;
- (void)startAsynchronous;
- (void)setValue:(id)value forParameter:(NSString *)param;
- (void)setIntegerValue:(NSInteger)value forParameter:(NSString *)param;
- (void)setFloatValue:(float)value forParameter:(NSString *)param;
- (void)setBoolValue:(BOOL)value forParameter:(NSString *)param;

/**
 * Call this after calling startSynchronous/startAsynchronous to cancel the
 * request.
 */
- (void)cancel;

@property (assign) id delegate;
@property (readonly) NSDictionary *response;
@property (readonly) NSString *responseString;
@property (readonly) NSInteger responseStatusCode;
@property (readonly) NSError *error;
@property (readonly) BOOL complete;
@property (readonly) NSUInteger echonestStatusCode;
@property (readonly) NSString *echonestStatusMessage;
@property (readonly) NSString *endpoint;
@property (readonly) NSURL *requestURL;
/* set this property to store app-specific information (request type, etc.) with the request */
@property (retain) NSDictionary *userInfo;

@end
