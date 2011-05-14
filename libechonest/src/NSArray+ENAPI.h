//
//  NSArray+ENAPI.h
//  libechonest
//
//  Created by Art Gillespie on 3/29/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>

@interface NSArray (NSArray_ENAPI)

/**
 * This method will return the collection's items as a JSON string suitable
 * for catalog/update
 *
 * @param action - Action code, one of "delete," "update," "play," or "skip."
 * if this parameter is nil, no action key is added to each item's dictionary.
 */
- (NSString *)enapi_catalogUpdateBlockWithAction:(NSString *)action;

@end