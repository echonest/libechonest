//
//  NSMutableDictionary+QueryString.h
//  libechonest
//
//  Created by Art Gillespie on 3/8/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>


@interface NSMutableDictionary (QueryString)

/**
 * Returns the dictionary's key/value pairs as an escaped query string
 */
- (NSString *)enapi_queryString;

@end
