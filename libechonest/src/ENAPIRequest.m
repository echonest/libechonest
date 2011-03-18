//
//  ENAPIRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//

#import "ENAPIRequest.h"

#import "ENAPI_utils.h"
#import "ENAPI.h"

@implementation ENAPIRequest

+ (ENAPIRequest *)apiGetMethodRequest:(NSString *)method withParams:(NSMutableDictionary *)params {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", 
             ECHONEST_API_URL, 
             method, 
             [params queryString]];
    NSURL *url = [NSURL URLWithString:urlString];
    return [super requestWithURL:url];
}

+ (ENAPIRequest *)artistAudioWithName:(NSString *)name results:(NSInteger)count start:(NSInteger)start {
    CHECK_API_KEY;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:name forKey:@"name"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setObject:[ENAPI apiKey] forKey:@"api_key"];
    
    ENAPIRequest *request = [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];
    return request;
}

+ (ENAPIRequest *)artistAudioWithID:(NSString *)identifier results:(NSInteger)count start:(NSInteger)start {
    CHECK_API_KEY;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:identifier forKey:@"id"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setObject:[ENAPI apiKey] forKey:@"api_key"];
    
    ENAPIRequest *request = [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];
    return request;
}

+ (ENAPIRequest *)artistSuggestWithString:(NSString *)search {
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
