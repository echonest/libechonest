//
//  ENAPI.m
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

#import "ENAPI.h"

NSString * const ENLicenseEchoSource = @"echo-source";
NSString * const ENLicenseAllRightsReserved = @"all-rights-reserved";
NSString * const ENLicenseCreativeCommonsBy_SA = @"cc-by-sa";
NSString * const ENLicenseCreativeCommonsBy_NC = @"cc-by-nc";
NSString * const ENLicenseCreativeCommonsBy_NC_ND = @"cc-by-nc-nd";
NSString * const ENLicenseCreativeCommonsBy_NC_SA = @"cc-by-nc-sa";
NSString * const ENLicenseCreativeCommonsBy_ND = @"cc-by-nd";
NSString * const ENLicenseCreativeCommonsBy = @"cc-by";
NSString * const ENLicensePublicDomain = @"public-domain";
NSString * const ENLicenseUnknown = @"unknown";

NSString * const ENSortFamiliarityAscending = @"familiarity-asc";
NSString * const ENSortFamiliarityDescending = @"familiarity-desc";
NSString * const ENSortHotttnesssAscending = @"hotttnesss-asc";
NSString * const ENSortHotttnesssDescending = @"hotttnesss-desc";
NSString * const ENSortWeight = @"weight";
NSString * const ENSortFrequency = @"frequency";

static NSString *EN_API_KEY = nil;
static NSString *EN_CONSUMER_KEY = nil;
static NSString *EN_SHARED_SECRET = nil;
static NSMutableArray *EN_SECURED_ENDPOINTS = nil;

@implementation ENAPI

+ (void)initWithApiKey:(NSString *)apiKey {
    EN_API_KEY = apiKey;
}

+ (void)initWithApiKey:(NSString *)apiKey ConsumerKey:(NSString *)consumerKey
       AndSharedSecret:(NSString *)secret {
    [ENAPI initWithApiKey:apiKey];
    [ENAPI addSecuredEndpoint:@"sandbox/access"];
    [ENAPI setConsumerKey:consumerKey];
    [ENAPI setSharedSecret:secret];
}

+ (NSString *)apiKey {
    return EN_API_KEY;
}

+ (NSString *)consumerKey {
    return EN_CONSUMER_KEY;
}

+ (void)setConsumerKey:(NSString *)key {
    if (EN_CONSUMER_KEY != key) {
        EN_CONSUMER_KEY = key;
    }
}

+ (NSString *)sharedSecret {
    return EN_SHARED_SECRET;
}

+ (void)setSharedSecret:(NSString *)secret {
    if (EN_SHARED_SECRET != secret) {
        // API is not using OAuth tokens in the signing process,
        // but the & suffix is still required for the secret.
        if ([secret hasSuffix:@"&"]) {
            EN_SHARED_SECRET = secret;
        } else {
            EN_SHARED_SECRET = [[NSString alloc] initWithFormat:@"%@&", secret];
        }
    }
}

+ (BOOL)isSecuredEndpoint:(NSString *)endpoint {
    return [EN_SECURED_ENDPOINTS containsObject:endpoint];
}

+ (void)addSecuredEndpoint:(NSString *)endpoint {
    if (nil == EN_SECURED_ENDPOINTS) {
        EN_SECURED_ENDPOINTS = [[NSMutableArray alloc] init];
    }
    [EN_SECURED_ENDPOINTS addObject:endpoint];
}

+ (NSArray *)securedEndpoints {
    return [EN_SECURED_ENDPOINTS copy];
}

@end
