//
//  ENAPIRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/10/11.
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import <Foundation/Foundation.h>
//TODO: no, no, no, no
#import "asi-http-request/ASIHTTPRequest.h"

@interface ENAPIRequest : ASIHTTPRequest {
    
}

/**
 * Be sure to call this with your API key before calling any of the 
 * methods that create an Echo Nest request.
 * 
 * You only need to call it once.
 * @param apiKey Your API key!
 */
+ (void)setAPIKey:(NSString *)apiKey;

/**
 * Get the currently-set API key.
 * @return The currently-set API key or nil if no key is set.
 */
+ (NSString *)getAPIKey;

/**
 * Generic Echo Nest GET request. This will call the endpoint specified
 * by \method with the query string parameters in \params.
 */
+ (ENAPIRequest *) apiGetMethodRequest:(NSString *)method withParams:(NSMutableDictionary *)params;

/**
 * http://developer.echonest.com/docs/v4/artist.html#audio
 */
+ (ENAPIRequest *)artistAudioWithName:(NSString *)name results:(NSInteger)count start:(NSInteger)start;

/**
 http://developer.echonest.com/docs/v4/artist.html#audio
 */
+ (ENAPIRequest *)artistAudioWithID:(NSString *)identifier results:(NSInteger)count start:(NSInteger)start;

- (id)JSONValue;

@end
