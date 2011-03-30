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

- (void)requestFinished:(ENAPIRequest *)request;
- (void)requestFailed:(ENAPIRequest *)request;

@end

@interface ENAPIRequest : NSObject {

}

/**
 * Endpoint is an Echonest API endpoint, e.g., "artist/audio"
 */
+ (ENAPIRequest *)requestWithEndpoint:(NSString *)endpoint;
- (ENAPIRequest *)initWithEndpoint:(NSString *)endpoint;
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

@property (assign) id<ENAPIRequestDelegate> delegate;
@property (readonly) NSDictionary *response;
@property (readonly) NSInteger responseStatusCode;
@property (readonly) NSError *error;
@property (readonly) BOOL complete;
@property (readonly) NSUInteger echonestStatusCode;
@property (readonly) NSString *echonestStatusMessage;

@end
