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
+ (ENAPIRequest *)artistImagesWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistImagesWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/news
 *
 * http://developer.echonest.com/docs/v4/artist.html#news
 *
 */
+ (ENAPIRequest *)artistNewsWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistNewsWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/profile
 *
 * http://developer.echonest.com/docs/v4/artist.html#profile
 */
+ (ENAPIRequest *)artistProfileWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistProfileWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/reviews
 *
 * http://developer.echonest.com/docs/v4/artist.html#reviews
 */
+ (ENAPIRequest *)artistReviewsWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistReviewsWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/search
 *
 * http://developer.echonest.com/docs/v4/artist.html#search
 */
+ (ENAPIRequest *)artistSearchWithParams:(ENParamDictionary *)params;

/**
 * artist/similar
 *
 * http://developer.echonest.com/docs/v4/artist.html#similar
 */
+ (ENAPIRequest *)artistSimilarWithParams:(ENParamDictionary *)params;

/**
 * artist/songs
 *
 * http://developer.echonest.com/docs/v4/artist.html#songs
 */
+ (ENAPIRequest *)artistSongsWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistSongsWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/suggest (beta)
 *
 * http://developer.echonest.com/docs/v4/artist.html#suggest-beta
 */
+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search params:(ENParamDictionary *)params;

/**
 * artist/terms
 *
 * http://developer.echonest.com/docs/v4/artist.html#terms
 */
+ (ENAPIRequest *)artistTermsWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistTermsWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/top_hottt
 *
 * http://developer.echonest.com/docs/v4/artist.html#top-hottt
 */
+ (ENAPIRequest *)artistTopHottWithParams:(ENParamDictionary *)params;

/**
 * artist/top_terms
 *
 * http://developer.echonest.com/docs/v4/artist.html#top-terms
 */
+ (ENAPIRequest *)artistTopTermsWithParams:(ENParamDictionary *)params;

/**
 * artist/urls
 *
 * http://developer.echonest.com/docs/v4/artist.html#urls
 */
+ (ENAPIRequest *)artistURLsWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistURLsWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * artist/video
 *
 * http://developer.echonest.com/docs/v4/artist.html#video
 */
+ (ENAPIRequest *)artistVideoWithName:(NSString *)name params:(ENParamDictionary *)params;
+ (ENAPIRequest *)artistVideoWithID:(NSString *)enid params:(ENParamDictionary *)params;

/**
 * Once the request has returned successfully, call this to get an NSDictionary
 * or NSArray representation of the returned JSON.
 */
- (id)JSONValue;

@end
