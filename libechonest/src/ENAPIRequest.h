//
//  ENAPIRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/10/11.
//  Copyright 2011 tapsquare, llc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "asi-http-request/ASIHTTPRequest.h"

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
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for 
 * the name parameter here.
 */
+ (ENAPIRequest *)artistAudioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start;


/**
 * artist/biographies
 *
 * http://developer.echonest.com/docs/v4/artist.html#biographies
 * 
 * Pass in an array of ENLicense strings to filter on licenses, or nil to return all licenses.
 *
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for 
 * the name parameter here.
 */
+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses;


/**
 * artist/blogs
 *
 * http://developer.echonest.com/docs/v4/artist.html#blogs
 *
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for 
 * the name parameter here.
 */
+ (ENAPIRequest *)artistBlogsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)relevance;


/**
 * artist/suggest (beta)
 *
 * http://developer.echonest.com/docs/v4/artist.html#suggest-beta
 */
+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search count:(NSInteger)count;

/**
 * artist/familiarity
 *
 * http://developer.echonest.com/docs/v4/artist.html#familiarity
 *
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for 
 * the name parameter here.
 */
+ (ENAPIRequest *)artistFamiliarityWithName:(NSString *)name;

/**
 * artist/hotttnesss
 *
 * http://developer.echonest.com/docs/v4/artist.html#hotttnesss
 *
 *
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for 
 * the name parameter here.
 */
+ (ENAPIRequest *)artistHotttnesssWithName:(NSString *)name;

/**
 * artist/images
 *
 * http://developer.echonest.com/docs/v4/artist.html#images
 *
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for
 * the name parameter here.
 */
+ (ENAPIRequest *)artistImagesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses;

/**
 * artist/news
 *
 * http://developer.echonest.com/docs/v4/artist.html#news
 *
 * Note you can pass either a name (e.g., "Radiohead") or an id (e.g., "ARH6W4X1187B99274F") for
 * the name parameter here.
 */
+ (ENAPIRequest *)artistNewsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance;

/**
 * artist/profile
 *
 * http://developer.echonest.com/docs/v4/artist.html#profile
 */
+ (ENAPIRequest *)artistProfileWithName:(NSString *)name buckets:(NSArray *)buckets;

/**
 * Once the request has returned successfully, call this to get an NSDictionary
 * or NSArray representation of the returned JSON.
 */
- (id)JSONValue;

@end
