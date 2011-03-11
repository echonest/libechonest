//
//  ENAPIRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//

#import "ENAPIRequest.h"
#import "NSMutableDictionary+QueryString.h"

#define CHECK_API_KEY if (nil == EN_API_KEY) { @throw [NSException exceptionWithName:@"APIKeyNotSetException" reason:@"Set the API key before calling this method" userInfo:nil]; }

//TODO: Put this someplace central to make maintenance easier
static NSString *ECHONEST_API_URL = @"http://developer.echonest.com/api/v4/";
static NSString *EN_API_KEY = nil;

@implementation ENAPIRequest

+ (void)setAPIKey:(NSString *)apiKey {
    [EN_API_KEY release];
    EN_API_KEY = [apiKey retain];
}
+ (NSString *)getAPIKey {
    return EN_API_KEY;
}

+ (ENAPIRequest *) apiGetMethodRequest:(NSString *)method withParams:(NSMutableDictionary *)params {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", 
             ECHONEST_API_URL, 
             method, 
             [params toQueryString]];
    NSURL *url = [NSURL URLWithString:urlString];
    return [super requestWithURL:url];
}

+ (ENAPIRequest *) artistAudioWithName:(NSString *)name results:(NSInteger)count start:(NSInteger)start {
    CHECK_API_KEY;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:name forKey:@"name"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setObject:EN_API_KEY forKey:@"api_key"];
    
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
    [params setObject:EN_API_KEY forKey:@"api_key"];
    
    ENAPIRequest *request = [ENAPIRequest apiGetMethodRequest:@"artist/audio" withParams:params];
    return request;
}
@end
