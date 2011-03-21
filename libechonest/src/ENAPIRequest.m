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

+ (ENAPIRequest *)artistAudioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];
}

+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    if (nil != licenses) {
        [params setObject:licenses forKey:@"license"];        
    }
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/biographies" withParams:params];
}

+ (ENAPIRequest *)artistBlogsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)relevance {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    [params setValue:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setValue:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setValue:[NSNumber numberWithBool:relevance] forKey:@"high_relevance"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/blogs" withParams:params];
}

+ (ENAPIRequest *)artistFamiliarityWithName:(NSString *)name {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/familiarity" withParams:params];
}

+ (ENAPIRequest *)artistHotttnesssWithName:(NSString *)name {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/hotttnesss" withParams:params];    
}

+ (ENAPIRequest *)artistImagesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    if (nil != licenses) {
        [params setObject:licenses forKey:@"license"];        
    }
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/images" withParams:params];    
}

+ (ENAPIRequest *)artistNewsWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start highRelevance:(BOOL)highRelevance {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setValue:name forKey:@"name"];
    [params setValue:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setValue:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setValue:[NSNumber numberWithBool:highRelevance] forKey:@"high_relevance"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/news" withParams:params];
}

+ (ENAPIRequest *)artistProfileWithName:(NSString *)name buckets:(NSArray *)buckets {
    NSMutableDictionary *params = ENBasicParamDictionary();
    NSAssert(nil != name, @"names array parameter cannot be nil");
    [params setValue:name forKey:@"name"];
    if (nil != buckets && 0 < buckets.count) {
        [params setValue:buckets forKey:@"bucket"];
    }
    return [ENAPIRequest apiGetMethodRequest:@"artist/profile" withParams:params];
}

+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search count:(NSInteger)count {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:search forKey:@"q"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/suggest" withParams:params];
}

- (id)JSONValue {
    return [self.responseString JSONValue];
}
@end
