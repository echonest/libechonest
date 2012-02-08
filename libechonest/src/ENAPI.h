//
//  ENAPI.h
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
#import "ENAPI_utils.h"
#import "ENAPIRequest.h"
#import "ENAPIPostRequest.h"
#import "NSData+MD5.h"
#import "NSMutableDictionary+QueryString.h"
#import "ENParamDictionary.h"

// License string constants

extern NSString * const ENLicenseEchoSource;
extern NSString * const ENLicenseAllRightsReserved;
extern NSString * const ENLicenseCreativeCommonsBy_SA;
extern NSString * const ENLicenseCreativeCommonsBy_NC;
extern NSString * const ENLicenseCreativeCommonsBy_NC_ND;
extern NSString * const ENLicenseCreativeCommonsBy_NC_SA;
extern NSString * const ENLicenseCreativeCommonsBy_ND;
extern NSString * const ENLicenseCreativeCommonsBy;
extern NSString * const ENLicensePublicDomain;
extern NSString * const ENLicenseUnknown;

// Sort string constants

extern NSString * const ENSortFamiliarityAscending;
extern NSString * const ENSortFamiliarityDescending;
extern NSString * const ENSortHotttnesssAscending;
extern NSString * const ENSortHotttnesssDescending;
extern NSString * const ENSortWeight;
extern NSString * const ENSortFrequency;

@interface ENAPI : NSObject {

}

+ (void)initWithApiKey:(NSString *)apiKey;
/**
 * Consumer key and shared secret are required if calling OAuth secured endpoints.  Example: "sandbox/access"
 */
+ (void)initWithApiKey:(NSString *)apiKey ConsumerKey:(NSString *)consumerKey AndSharedSecret:(NSString *)secret;
+ (NSString *)apiKey;
+ (NSString *)consumerKey;
+ (void)setConsumerKey:(NSString *)key;
+ (NSString *)sharedSecret;
+ (void)setSharedSecret:(NSString *)secret;
+ (NSArray *)securedEndpoints;
+ (void)addSecuredEndpoint:(NSString *)endpoint;
+ (BOOL)isSecuredEndpoint:(NSString *)endpoint;
@end
