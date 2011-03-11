//
//  NSDictionary+QueryString.m
//  libechonest
//
//  Created by Art Gillespie on 3/8/11. art@tapsquare.com
//

#import "NSMutableDictionary+QueryString.h"

static NSString *ENGetStringRepresentationForObject(NSObject *obj) {
    return [NSString stringWithFormat:@"%@", obj];
}

static NSString *ENEscapeStringForURL (NSString *str) {
    //
    // rfc 3986
    // @see http://code.google.com/p/google-toolbox-for-mac/source/browse/trunk/Foundation/GTMNSString%2BURLArguments.m
    //
    NSString *returnString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
                                                                                 (CFStringRef)str, 
                                                                                 NULL, 
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]", 
                                                                                 kCFStringEncodingUTF8);
    return [returnString autorelease];
}

@implementation NSMutableDictionary (QueryString)

- (NSString *)toQueryString {
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSString *key in [self allKeys]) {
        NSObject *value = [self objectForKey:key];
        [params addObject:[NSString stringWithFormat:@"%@=%@", ENEscapeStringForURL(key), 
                           ENEscapeStringForURL(ENGetStringRepresentationForObject(value))]];
    }
    return [params componentsJoinedByString:@"&"];
}

- (NSString *)getMessage { return @"Hello, Category!"; };

@end
