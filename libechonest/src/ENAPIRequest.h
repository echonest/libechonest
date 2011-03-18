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
+ (ENAPIRequest *) apiGetMethodRequest:(NSString *)method withParams:(NSMutableDictionary *)params;

/**
 * http://developer.echonest.com/docs/v4/artist.html#audio
 */
+ (ENAPIRequest *)artistAudioWithName:(NSString *)name results:(NSInteger)count start:(NSInteger)start;

/**
 * http://developer.echonest.com/docs/v4/artist.html#audio
 */
+ (ENAPIRequest *)artistAudioWithID:(NSString *)identifier results:(NSInteger)count start:(NSInteger)start;

/**
 * 
 */
+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search;

/**
 * Once the request has returned successfully, call this to get an NSDictionary
 * or NSArray representation of the returned JSON.
 */
- (id)JSONValue;

@end
