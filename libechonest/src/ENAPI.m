//
//  ENAPI.m
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import "ENAPI.h"

static NSString *EN_API_KEY = nil;

@implementation ENAPI

+ (void)initWithApiKey:(NSString *)apiKey {
    EN_API_KEY = [apiKey retain];
}

+ (NSString *)apiKey {
    return EN_API_KEY;
}

@end
