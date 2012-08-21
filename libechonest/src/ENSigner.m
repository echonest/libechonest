//
//  ENSigner.m
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

#import "ENSigner.h"
#import "Base64Transcoder.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>

@implementation ENSigner

+ (NSString *)signText:(NSString *)text WithKeyAndEncode:(NSString *)secret {
    
    const char *cKey  = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cText = [text cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHmacResult[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cText, strlen(cText), cHmacResult);
    
    char base64Result[32];
    size_t base64ResultLen = 32;
    Base64EncodeData(cHmacResult, CC_SHA1_DIGEST_LENGTH, base64Result, &base64ResultLen);
    
    NSData *encodedData = [NSData dataWithBytes:base64Result length:base64ResultLen];
    
    return [[NSString alloc] initWithData:encodedData 
                                  encoding:NSASCIIStringEncoding];
}

@end
