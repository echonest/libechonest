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
    
    ENAPIRequest *request = [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];
    return request;
}

+ (ENAPIRequest *)artistAudioWithID:(NSString *)identifier count:(NSInteger)count start:(NSInteger)start {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:identifier forKey:@"id"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    
    ENAPIRequest *request = [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];
    return request;
}

+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    NSMutableDictionary *params = ENBasicParamDictionary();
    [params setObject:name forKey:@"name"];
    [params setObject:licenses forKey:@"license"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    return [ENAPIRequest apiGetMethodRequest:@"artist/biographies" withParams:params];
}

+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search count:(NSInteger)count {
    CHECK_API_KEY;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:[ENAPI apiKey] forKey:@"api_key"];
    [params setObject:search forKey:@"q"];
    ENAPIRequest *request = [ENAPIRequest apiGetMethodRequest:@"artist/suggest" withParams:params];
    return request;    
}

- (id)JSONValue {
    return [self.responseString JSONValue];
}
@end
