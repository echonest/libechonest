//
//  ios_tests.m
//  ios-tests
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//

#import "tests.h"
#import "ENAPIRequest.h"
#import "ENAPI.h"
#import "ENAPI_utils.h"

static NSString *TEST_API_KEY = @"2J12S2GOSDBV2KC6V";

@implementation ios_tests

- (void)setUp {
    [super setUp];

    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.

    [super tearDown];
}

- (void)testNoAPIKey {
    // this is kinda lame -- what we really want to test here is what happens if the
    // api key is *never* set.
    [ENAPI initWithApiKey:nil];
    STAssertThrows([ENAPIRequest artistAudioWithName:@"Radiohead" results:2 start:0], @"No API Key set - Method should throw");
}

- (void)testArtistAudio
{
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistAudioWithName:@"Radiohead" results:2 start:0];
    STAssertNotNil(request, @"artistAudioWithName returned nil");
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *audio = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

@end
