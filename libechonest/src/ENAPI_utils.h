//
//  ENAPI_utils.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import "NSMutableDictionary+QueryString.h"
#import "NSData+MD5.h"
#import "NSObject+JSON.h"
#import "ENAPI.h"

#define CHECK_API_KEY if (nil == [ENAPI apiKey]) { @throw [NSException exceptionWithName:@"APIKeyNotSetException" reason:@"Set the API key before calling this method" userInfo:nil]; }

//TODO: Put this someplace central to make maintenance easier
static NSString *ECHONEST_API_URL = @"http://developer.echonest.com/api/v4/";
