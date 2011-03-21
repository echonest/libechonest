//
//  ENArtistSearchRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/21/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>
#import "ENAPIRequest.h"

/**
 * This class implements the artist/search API endpoint.
 *
 * http://developer.echonest.com/docs/v4/artist.html#search
 * 
 * The API's optional parameters are implemented as properties on this class.
 * Example:
 *
 *     ENArtistSearchRequest *request = [[ENArtistSearchRequest alloc] init];
 *     request.name = @"Say Hi";
 *     [request.bucket addObject:@"blogs"];
 *     [request.bucket addObject:@"terms"];
 *     request.limit = YES;
 *     [request.description addObject:@"mood:playful"];
 *     request.fuzzy_match = NO;
 *     request.min_hotttnesss = 0.5f;
 *     [request prepare];
 *     [request startAsynchronous];
 *     ...
 */

extern const NSString *ENSortFamiliarityAscending;
extern const NSString *ENSortFamiliarityDescending;
extern const NSString *ENSortHotttnesssAscending;
extern const NSString *ENSortHotttnesssDescending;

@interface ENArtistSearchRequest : ENAPIRequest {
    
}

- (id)initWithName:(NSString *)name;
- (void)prepare;

@property (retain) NSMutableArray *bucket;
@property (assign) BOOL limit;
@property (retain) NSString *name;
@property (retain) NSMutableArray *description;
@property (assign) BOOL fuzzyMatch;
@property (assign) float minFamiliarity;
@property (assign) float maxFamiliarity;
@property (assign) float minHotttnesss;
@property (assign) float maxHotttnesss;
@property (retain) NSString *sortOrder;
@property (assign) NSInteger count;

@end
