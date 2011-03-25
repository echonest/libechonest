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
    STAssertThrows([ENAPIRequest artistAudioWithName:@"Radiohead" params:[ENParamDictionary paramDictionary]], @"No API Key set - Method should throw");
}

- (void)testArtistAudio {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 2;
    ENAPIRequest *request = [ENAPIRequest artistAudioWithName:@"Radiohead" params:params];
    STAssertNotNil(request, @"artistAudioWithName returned nil");
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *audio = [response valueForKeyPath:@"response.audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistAudioWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 2;
    ENAPIRequest *request = [ENAPIRequest artistAudioWithID:@"ARH6W4X1187B99274F" params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 1;
    params.licenses = licenses;
    ENAPIRequest *request = [ENAPIRequest artistBiographiesWithName:@"LCD Soundsystem" params:params];
    STAssertNotNil(request, @"artistBiographiesWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error should be nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *biographies = [response valueForKeyPath:@"response.biographies"];
    STAssertEquals(biographies.count, (NSUInteger)1, @"expected 1 results");
}

- (void)testArtistBiographiesNilLicenses {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 5;
    ENAPIRequest *request = [ENAPIRequest artistBiographiesWithName:@"LCD Soundsystem" params:params];
    STAssertNotNil(request, @"artistBiographiesWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error should be nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *biographies = [response valueForKeyPath:@"response.biographies"];
    STAssertEquals(biographies.count, (NSUInteger)5, @"expected 5 results");    
}

- (void)testArtistBlogs {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 2;
    params.highRelevance = YES;
    ENAPIRequest *request = [ENAPIRequest artistBlogsWithName:@"Daft Punk" params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 2;
    params.highRelevance = YES;
    ENAPIRequest *request = [ENAPIRequest artistBlogsWithName:@"ARF8HTQ1187B9AE693" params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 10;
    ENAPIRequest *request = [ENAPIRequest artistImagesWithName:searchArtist params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 30;
    ENAPIRequest *request = [ENAPIRequest artistNewsWithName:searchArtist params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    ENAPIRequest *request = [ENAPIRequest artistProfileWithName:searchArtist params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.buckets = [NSArray arrayWithObjects:@"blogs", @"images", nil];
    ENAPIRequest *request = [ENAPIRequest artistProfileWithName:searchArtist params:params];
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
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 15;
    ENAPIRequest *request = [ENAPIRequest artistReviewsWithName:searchArtist params:params];
    STAssertNotNil(request, @"artistReviewsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *reviews = [response valueForKeyPath:@"response.reviews"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 reviews");
}

- (void)testArtistSongsWithName {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Blockhead";
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 15;
    ENAPIRequest *request = [ENAPIRequest artistSongsWithName:searchArtist params:params];
    STAssertNotNil(request, @"artistSongsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *reviews = [response valueForKeyPath:@"response.songs"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 songs");
}

- (void)testArtistSongsWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"ARF8HTQ1187B9AE693";
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    params.results = 15;
    ENAPIRequest *request = [ENAPIRequest artistSongsWithID:searchArtist params:params];
    STAssertNotNil(request, @"artistSongsWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *reviews = [response valueForKeyPath:@"response.songs"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 songs");
}

- (void)testArtistSearch {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENParamDictionary *params = [ENParamDictionary paramDictionary];
    //params.name = @"Blockhead";
    params.descriptions = [NSArray arrayWithObjects:@"mood:chill", @"style:electronic", nil];
    params.minFamiliarity = 0.5f;
    params.minHotttnesss = 0.5f;
    params.fuzzyMatch = YES;
    ENAPIRequest *request = [ENAPIRequest artistSearchWithParams:params];
    STAssertNotNil(request, @"artistSearchWithParams returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *response = [request JSONValue];
    NSArray *artists = [response valueForKeyPath:@"response.artists"];
    STAssertTrue(artists.count > 0, @"Expected artist.count > 0");
}

@end
