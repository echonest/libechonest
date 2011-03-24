//
//  ios_tests.m
//  ios-tests
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//

#import "tests.h"
#import "ENAPI.h"

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
    NSArray *audio = [response valueForKeyPath:@"response.audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistAudioWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest artistAudioWithName:@"ARH6W4X1187B99274F" count:2 start:0];
    STAssertNotNil(request, @"artistAudioWithName returned nil");
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *audio = [response valueForKeyPath:@"response.audio"];
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
    NSArray *biographies = [response valueForKeyPath:@"response.biographies"];
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
    NSArray *biographies = [response valueForKeyPath:@"response.biographies"];
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
    NSArray *blogs = [response valueForKeyPath:@"response.blogs"];
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
    NSArray *blogs = [response valueForKeyPath:@"response.blogs"];
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
    NSDictionary *artist = [response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"%@ != %@", [artist valueForKey:@"name"], searchArtist);
}

- (void)testArtistHotttnesss {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Hot Chip";
    ENAPIRequest *request = [ENAPIRequest artistHotttnesssWithName:searchArtist];
    STAssertNotNil(request, @"artistHottnesssWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSDictionary *artist = [response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"%@ != %@", [artist valueForKey:@"name"], searchArtist);    
}

- (void)testArtistImages {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Amanda Palmer";
    ENAPIRequest *request = [ENAPIRequest artistImagesWithName:searchArtist count:10 start:0 licenses:nil];
    STAssertNotNil(request, @"artistImagesWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *images = [response valueForKeyPath:@"response.images"];
    STAssertEquals(images.count, (NSUInteger)10, @"%d != %d", images.count, 10);
}

- (void)testArtistNews {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"The New Pornographers";
    ENAPIRequest *request = [ENAPIRequest artistNewsWithName:searchArtist count:30 start:0 highRelevance:NO];
    STAssertNotNil(request, @"artistNewsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *news = [response valueForKeyPath:@"response.news"];
    STAssertEquals(news.count, (NSUInteger)30, @"%d != %d", news.count, 30);
}

- (void)testArtistProfile {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"RJD2";
    ENAPIRequest *request = [ENAPIRequest artistProfileWithName:searchArtist buckets:nil];
    STAssertNotNil(request, @"artistProfileWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSDictionary *artist = [response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"Unexpected artist name");
    STAssertTrue([[artist valueForKey:@"id"] isEqualToString:@"ARQG4O41187B98A03B"], @"Unexpected artist id");
}

- (void)testArtistProfileWithBuckets {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"RJD2";
    NSArray *buckets = [NSArray arrayWithObjects:@"blogs", @"images", nil];
    ENAPIRequest *request = [ENAPIRequest artistProfileWithName:searchArtist buckets:buckets];
    STAssertNotNil(request, @"artistProfileWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSDictionary *artist = [response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"Unexpected artist name");
    STAssertTrue([[artist valueForKey:@"id"] isEqualToString:@"ARQG4O41187B98A03B"], @"Unexpected artist id");
    NSArray *blogs = [artist valueForKey:@"blogs"];
    STAssertNotNil(blogs, @"we should've gotten some blogs");
    NSArray *images = [artist valueForKey:@"images"];
    STAssertNotNil(images, @"we should've gotten some images");
}

- (void)testArtistReviews {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Blockhead";
    ENAPIRequest *request = [ENAPIRequest artistReviewsWithName:searchArtist count:15 start:0];
    STAssertNotNil(request, @"artistReviewsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *reviews = [response valueForKeyPath:@"response.reviews"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 reviews");
}

- (void)testArtistSearch {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Blockhead";
    ENAPIRequest *request = [ENAPIRequest artistReviewsWithName:searchArtist count:15 start:0];
    STAssertNotNil(request, @"artistReviewsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *reviews = [response valueForKeyPath:@"response.reviews"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 reviews");    
}

@end
