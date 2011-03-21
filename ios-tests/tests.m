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
    STAssertThrows([ENAPIRequest artistAudioWithName:@"Radiohead" count:2 start:0], @"No API Key set - Method should throw");
}

- (void)testArtistAudio {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistAudioWithName:@"Radiohead" count:2 start:0];
    STAssertNotNil(request, @"artistAudioWithName returned nil");
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *audio = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistAudioWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistAudioWithName:@"ARH6W4X1187B99274F" count:2 start:0];
    STAssertNotNil(request, @"artistAudioWithName returned nil");
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *audio = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistBiographies {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSArray *licenses = [NSArray arrayWithObjects:ENLicenseEchoSource, ENLicenseCreativeCommonsBy_SA, nil];
    ENAPIRequest *request = [ENAPIRequest artistBiographiesWithName:@"LCD Soundsystem" count:2 start:0 licenses:licenses];
    STAssertNotNil(request, @"artistBiographiesWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error should be nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *biographies = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"biographies"];
    STAssertEquals(biographies.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistBiographiesNilLicenses {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistBiographiesWithName:@"LCD Soundsystem" count:2 start:0 licenses:nil];
    STAssertNotNil(request, @"artistBiographiesWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error should be nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *biographies = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"biographies"];
    STAssertEquals(biographies.count, (NSUInteger)2, @"expected 2 results");    
}

- (void)testArtistBlogs {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistBlogsWithName:@"Daft Punk" count:2 start:0 highRelevance:YES];
    STAssertNotNil(request, @"artistBlogsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *blogs = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"blogs"];
    STAssertEquals(blogs.count, (NSUInteger)2, @"Expected 2 blog entries, got: %d", blogs.count);
}

- (void)testArtistBlogsWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistBlogsWithName:@"ARF8HTQ1187B9AE693" count:2 start:0 highRelevance:YES];
    STAssertNotNil(request, @"artistBlogsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *blogs = [(NSDictionary *)[response valueForKey:@"response"] valueForKey:@"blogs"];
    STAssertEquals(blogs.count, (NSUInteger)2, @"Expected 2 blog entries, got: %d", blogs.count);
}

- (void)testArtistFamiliarity {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Justin Bieber";
    ENAPIRequest *request = [ENAPIRequest artistFamiliarityWithName:searchArtist];
    STAssertNotNil(request, @"artistFamiliarityWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSDictionary *artist = [[response valueForKey:@"response"] valueForKey:@"artist"];
    NSLog(@"artist: %@", artist);
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"%@ != %@", [artist valueForKey:@"name"], searchArtist);
}

@end
