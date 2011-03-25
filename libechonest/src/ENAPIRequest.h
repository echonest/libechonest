//
//  ENAPIRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//


#import <Foundation/Foundation.h>
#import "asi-http-request/ASIHTTPRequest.h"
#import "ENParamDictionary.h"

@interface ENAPIRequest : ASIHTTPRequest {

}

/**
 * Generic Echo Nest GET request. This will call the endpoint specified by
 * \method with the query string parameters in \params.
 */
+ (ENAPIRequest *)apiGetMethodRequest:(NSString *)method withParams:(NSMutableDictionary *)params;

/**
 * artist/audio
 *
 * http://developer.echonest.com/docs/v4/artist.html#audio
 *
 */
+ (ENAPIRequest *)artistAudioWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistAudioWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/biographies
 *
 * http://developer.echonest.com/docs/v4/artist.html#biographies
 * 
 * Pass in an array of ENLicense strings to filter on licenses, or nil to return all licenses.
 *
 */
+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistBiographiesWithID:(NSString *)enid params:(ENParamDictionary *)params;


/**
 * artist/blogs
 *
 * http://developer.echonest.com/docs/v4/artist.html#blogs
 *
 */
+ (ENAPIRequest *)artistBlogsWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistBlogsWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/familiarity
 *
 * http://developer.echonest.com/docs/v4/artist.html#familiarity
 *
 */
+ (ENAPIRequest *)artistFamiliarityWithName:(NSString *)name;
+ (ENAPIRequest *)artistFamiliarityWithID:(NSString *)enid;

/**
 * artist/hotttnesss
 *
 * http://developer.echonest.com/docs/v4/artist.html#hotttnesss
 *
 */
+ (ENAPIRequest *)artistHotttnesssWithName:(NSString *)name;
+ (ENAPIRequest *)artistHotttnesssWithID:(NSString *)enid;

/**
 * artist/images
 *
 * http://developer.echonest.com/docs/v4/artist.html#images
 *
 */
+ (ENAPIRequest *)artistImagesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses;
+ (ENAPIRequest *)artistImagesWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses;

/**
 * artist/news
 *
 * http://developer.echonest.com/docs/v4/artist.html#news
 *
 */
+ (ENAPIRequest *)artistNewsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance;
+ (ENAPIRequest *)artistNewsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance;

/**
 * artist/profile
 *
 * http://developer.echonest.com/docs/v4/artist.html#profile
 */
+ (ENAPIRequest *)artistProfileWithName:(NSString *)name buckets:(NSArray *)buckets;
+ (ENAPIRequest *)artistProfileWithID:(NSString *)enid buckets:(NSArray *)buckets;

/**
 * artist/reviews
 *
 * http://developer.echonest.com/docs/v4/artist.html#reviews
 */
+ (ENAPIRequest *)artistReviewsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start;
+ (ENAPIRequest *)artistReviewsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start;

/**
 * artist/songs
 *
 * http://developer.echonest.com/docs/v4/artist.html#songs
 */
+ (ENAPIRequest *)artistSongsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start;
+ (ENAPIRequest *)artistSongsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start;

/**
 * artist/suggest (beta)
 *
 * http://developer.echonest.com/docs/v4/artist.html#suggest-beta
 */
+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search count:(NSInteger)count;

/**
 * Once the request has returned successfully, call this to get an NSDictionary
 * or NSArray representation of the returned JSON.
 */
- (id)JSONValue;

@end
