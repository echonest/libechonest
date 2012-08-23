//
//  ENAPIRequest.h
//  libechonest
//
//  Copyright (c) 2011, tapsquare, llc. (http://www.tapsquare.com, art@tapsquare.com)
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//   * Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
//   * Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in the
//     documentation and/or other materials provided with the distribution.
//   * Neither the name of the tapsquare, llc nor the names of its contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL TAPSQUARE, LLC. BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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

@property (unsafe_unretained) id delegate;
@property (unsafe_unretained, readonly) NSDictionary *response;
@property (unsafe_unretained, readonly) NSString *responseString;
@property (readonly) NSInteger responseStatusCode;
@property (unsafe_unretained, readonly) NSError *error;
@property (readonly) BOOL complete;
@property (readonly) NSUInteger echonestStatusCode;
@property (unsafe_unretained, readonly) NSString *echonestStatusMessage;
@property (readonly) NSString *endpoint;
@property (unsafe_unretained, readonly) NSURL *requestURL;
@property (strong,readonly) NSMutableDictionary *params;
/* set this property to store app-specific information (request type, etc.) with the request */
@property (strong) NSDictionary *userInfo;

@end
