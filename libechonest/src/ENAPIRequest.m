//
//  ENAPIRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//

#import "ENAPIRequest.h"

#import "ENAPI_utils.h"
#import "ENAPI.h"

NSMutableDictionary *ENBasicParamDictionary() {
    CHECK_API_KEY
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setValue:[ENAPI apiKey] forKey:@"api_key"];
    [params setValue:@"json" forKey:@"format"];
    return params;
}

@implementation ENAPIRequest

+ (ENAPIRequest *)apiGetMethodRequest:(NSString *)method withParams:(NSMutableDictionary *)params {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", 
             ECHONEST_API_URL, 
             method, 
             [params queryString]];
    NSURL *url = [NSURL URLWithString:urlString];
    return [super requestWithURL:url];
}

#pragma mark - artist/audio

+ (ENAPIRequest *)artistAudioWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start {
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];    
}

+ (ENAPIRequest *)artistAudioWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params.dict];    
}

+ (ENAPIRequest *)artistAudioWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params.dict];    
}

#pragma mark - artist/biographies

+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/biographies" withParams:params.dict];
}

+ (ENAPIRequest *)artistBiographiesWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/biographies" withParams:params.dict];
}

#pragma mark - artist/blogs

+ (ENAPIRequest *)artistBlogsWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/blogs" withParams:params.dict];    
}

+ (ENAPIRequest *)artistBlogsWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/blogs" withParams:params.dict];
}

#pragma mark - artist/familiarity

+ (ENAPIRequest *)artistFamiliarityWithName:(NSString *)name {
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/familiarity" withParams:params.dict];
}

+ (ENAPIRequest *)artistFamiliarityWithID:(NSString *)enid {
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/familiarity" withParams:params.dict];
}

#pragma mark - artist/hotttnesss

+ (ENAPIRequest *)artistHotttnesssWithName:(NSString *)name {
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/hotttnesss" withParams:params.dict];    
}

+ (ENAPIRequest *)artistHotttnesssWithID:(NSString *)enid {
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/hotttnesss" withParams:params.dict];
}

#pragma mark - artist/images

+ (ENAPIRequest *)artistImagesWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/images" withParams:params.dict];
}

+ (ENAPIRequest *)artistImagesWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/images" withParams:params.dict];
}

#pragma  mark - artist/news

+ (ENAPIRequest *)artistNewsWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/news" withParams:params.dict];
}

+ (ENAPIRequest *)artistNewsWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/news" withParams:params.dict];
}

#pragma mark - artist/profile

+ (ENAPIRequest *)artistProfileWithName:(NSString *)name params:(ENParamDictionary *)params {
    NSAssert(nil != name, @"name parameter cannot be nil");
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/profile" withParams:params.dict];
}

+ (ENAPIRequest *)artistProfileWithID:(NSString *)enid params:(ENParamDictionary *)params; {
    NSAssert(nil != enid, @"enid parameter cannot be nil");
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/profile" withParams:params.dict];
}

#pragma mark - artist/reviews

+ (ENAPIRequest *)artistReviewsWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/reviews" withParams:params.dict];
}

+ (ENAPIRequest *)artistReviewsWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/reviews" withParams:params.dict];
}

#pragma - artist/search

+ (ENAPIRequest *)artistSearchWithParams:(ENParamDictionary *)params {
    return [ENAPIRequest apiGetMethodRequest:@"artist/search" withParams:params.dict];
}

#pragma mark - artist/songs

+ (ENAPIRequest *)artistSongsWithName:(NSString *)name params:(ENParamDictionary *)params {
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/songs" withParams:params.dict];
}

+ (ENAPIRequest *)artistSongsWithID:(NSString *)enid params:(ENParamDictionary *)params {
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/songs" withParams:params.dict];
}

#pragma mark - artist/suggest

+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search count:(NSInteger)count {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:search forKey:@"q"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/suggest" withParams:params];
}

- (id)JSONValue {
    return [self.responseString JSONValue];
}
@end
