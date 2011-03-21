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
 */
+ (ENAPIRequest *)artistAudioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start;

/**
 * artist/audio
 *
 * http://developer.echonest.com/docs/v4/artist.html#audio
 */
+ (ENAPIRequest *)artistAudioWithID:(NSString *)identifier count:(NSInteger)count start:(NSInteger)start;

/**
 * artist/biographies
 *
 * http://developer.echonest.com/docs/v4/artist.html#biographies
 * 
 * Pass in an array of ENLicense strings to filter on licenses, or nil to return all licenses.
 */
+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses;

/**
 * artist/biographies
 *
 * http://developer.echonest.com/docs/v4/artist.html#biographies
 * 
 * Pass in an array of ENLicense strings to filter on licenses, or nil to return all licenses.
 */
+ (ENAPIRequest *)artistBiographiesWithID:(NSString *)identifier count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses;

/**
 * artist/blogs
 *
 * http://developer.echonest.com/docs/v4/artist.html#blogs
 */
+ (ENAPIRequest *)artistBlogsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)relevance;


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
