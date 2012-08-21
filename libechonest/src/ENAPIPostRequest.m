//
//  ENAPIPostRequest.m
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

#import "ENAPIPostRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIProgressDelegate.h"
#import "ENAPI.h"
#import "ENAPI_utils.h"
#import "ENAPIPostRequest.h"
#import "NSObject+SBJSON.h"

@interface ENAPIPostRequest() 
@property (strong) ASIFormDataRequest *request;
@property (strong) NSDictionary *_responseDict;
@property (nonatomic, assign) unsigned long long uploadFileSize;
@property (nonatomic, assign) unsigned long long uploadBytesSent;
@end

@implementation ENAPIPostRequest
@synthesize delegate, request, _responseDict, userInfo, uploadFileSize, uploadBytesSent;

- (id)initWithURL:(NSURL *)url {
    
    self = [super init];
    if (self) {
        self.request = [ASIFormDataRequest requestWithURL:url];
        self.request.postFormat = ASIMultipartFormDataPostFormat;
        [self.request setPostValue:[ENAPI apiKey] forKey:@"api_key"];
        self.request.delegate = self;
        self.request.uploadProgressDelegate = self;
        self.request.timeOutSeconds = 180;
    }
    return self;
}

- (void)setPostValue:(NSObject *)value forKey:(NSString *)key {
    [self.request setPostValue:value forKey:key];
}

- (void)setFile:(NSString *)path forKey:(NSString *)key {
    [self.request setFile:path forKey:key];
}

- (void)startSynchronous {
     // let's make sure we're still around when the network call returns
    [self.request startSynchronous];
}

- (void)startAsynchronous {
     // let's make sure we're still around when the network call returns
    [self.request startAsynchronous];
}

+ (ENAPIPostRequest *)requestWithURL:(NSURL *)url {
    return [[ENAPIPostRequest alloc] initWithURL:url];
    
}

+ (ENAPIPostRequest *)trackUploadRequestWithFile:(NSString *)filePath {
    CHECK_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"%@track/upload", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ENAPIPostRequest *postRequest = [ENAPIPostRequest requestWithURL:url];
    [postRequest setFile:filePath forKey:@"track"];
    // get the upload file's size so we can report progress somewhat accurately
    NSDictionary *fileAtts = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    postRequest.uploadFileSize = [[fileAtts objectForKey:NSFileSize] unsignedLongLongValue];
    NSString *ext = [[filePath pathExtension] lowercaseString];
    [postRequest setPostValue:ext forKey:@"filetype"];
    return postRequest;
}

+ (ENAPIPostRequest *)trackAnalyzeRequestWithFile:(NSString *)filePath {
    CHECK_API_KEY
    // we need the md5 of the file
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSString *md5 = [fileData enapi_MD5];
    return [ENAPIPostRequest trackAnalyzeRequestWithMD5:md5];
}

+ (ENAPIPostRequest *)trackAnalyzeRequestWithId:(NSString *)trackid {
    CHECK_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"%@track/analyze", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
        
    ENAPIPostRequest *postRequest = [ENAPIPostRequest requestWithURL:url];
    [postRequest setPostValue:trackid forKey:@"id"];
    return postRequest;    
}

+ (ENAPIPostRequest *)trackAnalyzeRequestWithMD5:(NSString *)md5 {
    CHECK_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"%@track/analyze", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ENAPIPostRequest *postRequest = [ENAPIPostRequest requestWithURL:url];
    [postRequest setPostValue:md5 forKey:@"md5"];
    return postRequest;    
}

+ (ENAPIPostRequest *)catalogCreateWithName:(NSString *)name type:(NSString *)type {
    NSString *urlString = [NSString stringWithFormat:@"%@catalog/create", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ENAPIPostRequest *postRequest = [ENAPIPostRequest requestWithURL:url];
    [postRequest setPostValue:name forKey:@"name"];
    [postRequest setPostValue:type forKey:@"type"];
    return postRequest;    
}

+ (ENAPIPostRequest *)catalogDeleteWithID:(NSString *)ID {
    NSString *urlString = [NSString stringWithFormat:@"%@catalog/delete", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ENAPIPostRequest *postRequest = [ENAPIPostRequest requestWithURL:url];
    [postRequest setPostValue:ID forKey:@"id"];
    return postRequest;        
}

+ (ENAPIPostRequest *)catalogUpdateWithID:(NSString *)ID data:(NSString *)json {
    NSString *urlString = [NSString stringWithFormat:@"%@catalog/update", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ENAPIPostRequest *postRequest = [ENAPIPostRequest requestWithURL:url];
    [postRequest setPostValue:ID forKey:@"id"];
    [postRequest setPostValue:json forKey:@"data"];
    [postRequest setPostValue:@"json" forKey:@"json"];
    return postRequest;            
}

#pragma mark - ASIProgressDelegate

- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes {
    self.uploadBytesSent += bytes;
    if ([self.delegate respondsToSelector:@selector(postRequest:didSendBytes:)]) {
        [(id<ENAPIPostRequestDelegate>)self.delegate postRequest:self didSendBytes:bytes];
    }
    if ([self.delegate respondsToSelector:@selector(postRequest:uploadProgress:)]) {
        [(id<ENAPIPostRequestDelegate>)self.delegate postRequest:self uploadProgress:(float)self.uploadBytesSent/(float)self.uploadFileSize];
    }
}

#pragma mark - ASIRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    if ([self.delegate respondsToSelector:@selector(postRequestFinished:)]) {
        [(id<ENAPIPostRequestDelegate>)self.delegate postRequestFinished:self];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    if ([self.delegate respondsToSelector:@selector(postRequestFailed:)]) {
        [(id<ENAPIPostRequestDelegate>)self.delegate postRequestFailed:self];
    }
}


#pragma mark - Properties

- (NSDictionary *)response {
    if (nil == _responseDict) {
        NSDictionary *dict = [self.request.responseString JSONValue];
        _responseDict = dict;
    }
    return _responseDict;
}

- (NSUInteger)responseStatusCode {
    return self.request.responseStatusCode;
}

- (NSError *)error {
    return self.request.error;
}

- (NSUInteger)echonestStatusCode {
    return [[self.response valueForKeyPath:@"response.status.code"] intValue];
}

- (NSString *)echonestStatusMessage {
    return [self.response valueForKeyPath:@"response.status.message"];
}

- (void) dealloc {
    delegate = nil;
}
@end
