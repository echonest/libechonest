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

+ (ENAPIRequest *)artistBiographiesWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    if (nil != licenses) {
        [params setObject:licenses forKey:@"license"];        
    }
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/biographies" withParams:params];    
}

+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    return [ENAPIRequest artistBiographiesWithParams:params count:count start:start licenses:licenses];
}

+ (ENAPIRequest *)artistBiographiesWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:enid forKey:@"id"];
    return [ENAPIRequest artistBiographiesWithParams:params count:count start:start licenses:licenses];
}

#pragma mark - artist/blogs

+ (ENAPIRequest *)artistBlogsWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)relevance {
    [params setValue:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setValue:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setValue:[NSNumber numberWithBool:relevance] forKey:@"high_relevance"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/blogs" withParams:params];    
}

+ (ENAPIRequest *)artistBlogsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)relevance {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest artistBlogsWithParams:params count:count start:start highRelevance:relevance];
}

+ (ENAPIRequest *)artistBlogsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)relevance {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest artistBlogsWithParams:params count:count start:start highRelevance:relevance];    
}

#pragma mark - artist/familiarity

+ (ENAPIRequest *)artistFamiliarityWithName:(NSString *)name {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/familiarity" withParams:params];
}

+ (ENAPIRequest *)artistFamiliarityWithID:(NSString *)enid {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/familiarity" withParams:params];    
}

#pragma mark - artist/hotttnesss

+ (ENAPIRequest *)artistHotttnesssWithName:(NSString *)name {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/hotttnesss" withParams:params];    
}

+ (ENAPIRequest *)artistHotttnesssWithID:(NSString *)enid {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:enid forKey:@"id"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/hotttnesss" withParams:params];    
}

#pragma mark - artist/images

+ (ENAPIRequest *)artistImagesWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    
    if (nil != licenses) {
        [params setObject:licenses forKey:@"license"];        
    }
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/images" withParams:params];        
}

+ (ENAPIRequest *)artistImagesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    return [ENAPIRequest artistImagesWithParams:params count:count start:start licenses:licenses];
}

+ (ENAPIRequest *)artistImagesWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:enid forKey:@"id"];
    return [ENAPIRequest artistImagesWithParams:params count:count start:start licenses:licenses];
}

#pragma  mark - artist/news

+ (ENAPIRequest *)artistNewsWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance {
    [params setValue:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setValue:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setValue:[NSNumber numberWithBool:highRelevance] forKey:@"high_relevance"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/news" withParams:params];
}

+ (ENAPIRequest *)artistNewsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest artistNewsWithParams:params count:count start:start highRelevance:highRelevance];
}

+ (ENAPIRequest *)artistNewsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest artistNewsWithParams:params count:count start:start highRelevance:highRelevance];
}

#pragma mark - artist/profile

+ (ENAPIRequest *)artistProfileWithParams:(NSMutableDictionary *)params buckets:(NSArray *)buckets {
    if (nil != buckets && 0 < buckets.count) {
        [params setValue:buckets forKey:@"bucket"];
    }
    return [ENAPIRequest apiGetMethodRequest:@"artist/profile" withParams:params];
}

+ (ENAPIRequest *)artistProfileWithName:(NSString *)name buckets:(NSArray *)buckets {
    NSMutableDictionary *params = ENBasicParamDictionary();
    NSAssert(nil != name, @"names parameter cannot be nil");
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest artistProfileWithParams:params buckets:buckets];
}

+ (ENAPIRequest *)artistProfileWithID:(NSString *)enid buckets:(NSArray *)buckets {
    NSMutableDictionary *params = ENBasicParamDictionary();
    NSAssert(nil != enid, @"enid parameter cannot be nil");
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest artistProfileWithParams:params buckets:buckets];
}

#pragma mark - artist/reviews

+ (ENAPIRequest *)artistReviewsWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start {
    [params setValue:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setValue:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/reviews" withParams:params];    
}

+ (ENAPIRequest *)artistReviewsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    return [self artistReviewsWithParams: params count: count start: start];
}

+ (ENAPIRequest *)artistReviewsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:enid forKey:@"id"];
    return [self artistReviewsWithParams: params count: count start: start];    
}

+ (ENAPIRequest *)artistSongsWithParams:(NSMutableDictionary *)params count:(NSInteger)count start:(NSInteger)start {
    [params setValue:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setValue:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/songs" withParams:params];
}

+ (ENAPIRequest *)artistSongsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest artistSongsWithParams:params count:count start:start];
}

+ (ENAPIRequest *)artistSongsWithID:(NSString *)enid count:(NSInteger)count start:(NSInteger)start {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:enid forKey:@"id"];
    return [ENAPIRequest artistSongsWithParams:params count:count start:start];    
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
