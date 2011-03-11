//
//  ENEchonest.m
//  libechonest
//
//  Created by Art Gillespie on 3/8/11. art@tpasquare.com
//

#import "ENEchonest.h"
#import "ENAPIRequest.h"

#import "NSMutableDictionary+QueryString.h"

@interface ENEchonest()

@property (nonatomic, retain) NSString *apiKey;

@end

@implementation ENEchonest
@synthesize apiKey;

- (id)initWithApiKey:(NSString *)apiKey_ {
    self = [super init];
    if (self) {
        self.apiKey = apiKey_;
        [ENAPIRequest setAPIKey:self.apiKey];
    }
    return self;
}

- (void)audioWithName:(NSString *)name count:(int)count start:(int)start {
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:name forKey:@"name"];
    [params setObject:@"json" forKey:@"format"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"results"];
    [params setObject:[NSNumber numberWithInt:start] forKey:@"start"];
    [params setObject:self.apiKey forKey:@"api_key"];

    ENAPIRequest *request = [ENAPIRequest artistAudioWithName:name results:count start:start];
    [request startSynchronous];
    NSLog(@"response: %d", request.responseStatusCode);
    NSLog(@"responseString: %@", request.responseString);
}

- (void)dealloc
{
    [apiKey release];
    [super dealloc];
}

@end
