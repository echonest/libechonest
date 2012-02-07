//
//  ENAPI_utils.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import "NSMutableDictionary+QueryString.h"
#import "NSData+MD5.h"
#import "ENAPI.h"

#define CHECK_API_KEY if (nil == [ENAPI apiKey]) { @throw [NSException exceptionWithName:@"APIKeyNotSetException" reason:@"Set the API key before calling this method" userInfo:nil]; }

#define CHECK_OAUTH_KEYS if (nil == [ENAPI consumerKey] && nil == [ENAPI sharedSecret]) { @throw [NSException exceptionWithName:@"OAuthKeysNotSetException" reason:@"Set the consumer key & shared secret before calling this method" userInfo:nil]; }

static NSString __attribute__((unused)) * const ECHONEST_API_URL = @"http://developer.echonest.com/api/v4/";
