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

+ (ENAPIRequest *)artistAudioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start {
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

+ (ENAPIRequest *)artistAudioWithID:(NSString *)identifier count:(NSInteger)count start:(NSInteger)start {
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

+ (ENAPIRequest *)artistBiographiesWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start licenses:(NSArray *)licenses {
    CHECK_API_KEY;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    //TODO: [alg] make the basic setup of the params dictionary a function (json, api_key, etc.)
    [params setObject:@"json" forKey:@"format"];
    [params setObject:[ENAPI apiKey] forKey:@"api_key"];
    [params setObject:name forKey:@"name"];
    //TODO: BAH! just ran into the limitation where a dictionary can only have one instance of a key
    // what if we have multiple? (e.g., in the case of licenses here?)
    // maybe store the array and make `requestString` smart about that?
#error UNIMPLEMENTED TODO TODO TODO
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
