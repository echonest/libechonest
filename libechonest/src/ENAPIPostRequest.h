//
//  ENAPIPostRequest.h
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

@class ENAPIPostRequest;
@protocol ENAPIPostRequestDelegate <NSObject>
@optional

- (void)postRequestFinished:(ENAPIPostRequest *)request;
- (void)postRequestFailed:(ENAPIPostRequest *)request;
- (void)postRequest:(ENAPIPostRequest *)request didSendBytes:(long long)nBytes;
- (void)postRequest:(ENAPIPostRequest *)request uploadProgress:(float)progress;

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

@property (unsafe_unretained) NSObject *delegate;
@property (unsafe_unretained, readonly) NSDictionary *response;
@property (readonly) NSUInteger responseStatusCode;
@property (readonly) NSUInteger echonestStatusCode;
@property (unsafe_unretained, readonly) NSString *echonestStatusMessage;
@property (unsafe_unretained, readonly) NSError *error;
/* set this property to store app-specific information (request type, etc.) with the request */
@property (strong) NSDictionary *userInfo;

@end
