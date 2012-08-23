//
//  NSDictionary+QueryString.m
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

#import "NSMutableDictionary+QueryString.h"

static NSString *ENGetStringRepresentationForObject(NSObject *obj) {
    if ([obj isKindOfClass:[NSNumber class]]) {
        // NSNumber returns `1` and `0` for BOOL string representation
        // instead of `true` and `false`
        NSNumber *number = (NSNumber *)obj;
        if (0 == strcmp([number objCType], @encode(BOOL))) {
            return ([number boolValue])?@"true":@"false";
        }
    }
    return [NSString stringWithFormat:@"%@", obj];
}

NSString *ENEscapeStringForURL (NSString *str) {
    //
    // rfc 3986
    // @see http://code.google.com/p/google-toolbox-for-mac/source/browse/trunk/Foundation/GTMNSString%2BURLArguments.m
    //
    NSString *returnString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                                 (__bridge CFStringRef)str, 
                                                                                 NULL, 
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]", 
                                                                                 kCFStringEncodingUTF8));
    return returnString;
}

@implementation NSMutableDictionary (QueryString)

- (NSString *)enapi_queryString {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSString *key in [self allKeys]) {
        NSObject *value = [self objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            // we use arrays for multiple values of the same key, e.g., licenses
            for (NSString *multValue in ((NSArray *)value)) {
                [params addObject:[NSString stringWithFormat:@"%@=%@", ENEscapeStringForURL(key), 
                                   ENEscapeStringForURL(ENGetStringRepresentationForObject(multValue))]];                            
            }
            
        } else {
            [params addObject:[NSString stringWithFormat:@"%@=%@", ENEscapeStringForURL(key), 
                               ENEscapeStringForURL(ENGetStringRepresentationForObject(value))]];            
        }
    }
    [params sortUsingSelector:@selector(caseInsensitiveCompare:)];
    return [params componentsJoinedByString:@"&"];
}

@end
