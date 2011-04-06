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
    STAssertThrows([ENAPIRequest requestWithEndpoint:@"artist/audio"], @"No API Key set - Method should throw");
}

- (void)testArtistAudio {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/audio"];
    STAssertNotNil(request, @"artistAudioWithName returned nil");
    [request setValue:@"Radiohead" forParameter:@"name"];
    [request setIntegerValue:2 forParameter:@"results"];
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *audio = [request.response valueForKeyPath:@"response.audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistAudioWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/audio"];
    [request setValue:@"ARH6W4X1187B99274F" forParameter:@"id"];
    [request setIntegerValue:2 forParameter:@"results"];
    [request startSynchronous];
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *audio = [request.response valueForKeyPath:@"response.audio"];
    STAssertEquals(audio.count, (NSUInteger)2, @"expected 2 results");
}

- (void)testArtistBiographies {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSArray *licenses = [NSArray arrayWithObjects:ENLicenseEchoSource, ENLicenseCreativeCommonsBy_SA, nil];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/biographies"];
    [request setValue:@"Radiohead" forParameter:@"name"];
    [request setValue:licenses forParameter:@"license"];
    [request setIntegerValue:1 forParameter:@"results"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error should be nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *biographies = [request.response valueForKeyPath:@"response.biographies"];
    STAssertEquals(biographies.count, (NSUInteger)1, @"expected 1 results");
}

- (void)testArtistBiographiesNilLicenses {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/biographies"];
    [request setValue:@"Radiohead" forParameter:@"name"];
    [request setIntegerValue:5 forParameter:@"results"];
    STAssertNotNil(request, @"artistBiographiesWithName returned nil");
    [request startSynchronous];
    STAssertNil(request.error, @"request.error should be nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *biographies = [request.response valueForKeyPath:@"response.biographies"];
    STAssertEquals(biographies.count, (NSUInteger)5, @"expected 5 results");    
}

- (void)testArtistBlogs {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/blogs"];
    [request setValue:@"Daft Punk" forParameter:@"name"];
    [request setBoolValue:YES forParameter:@"high_relevance"];
    [request setIntegerValue:2 forParameter:@"results"];
    
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *blogs = [request.response valueForKeyPath:@"response.blogs"];
    STAssertEquals(blogs.count, (NSUInteger)2, @"Expected 2 blog entries, got: %d", blogs.count);
}

- (void)testArtistBlogsWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/blogs"];
    [request setValue:@"ARF8HTQ1187B9AE693" forParameter:@"id"];
    [request setIntegerValue:2 forParameter:@"results"];
    [request setBoolValue:YES forParameter:@"high_relevance"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *blogs = [request.response valueForKeyPath:@"response.blogs"];
    STAssertEquals(blogs.count, (NSUInteger)2, @"Expected 2 blog entries, got: %d", blogs.count);
}

- (void)testArtistFamiliarity {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Justin Bieber";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/familiarity"];
    [request setValue:searchArtist forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *artist = [request.response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"%@ != %@", [artist valueForKey:@"name"], searchArtist);
}

- (void)testArtistHotttnesss {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Radiohead";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/hotttnesss"];
    [request setValue:searchArtist forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    STAssertTrue([[request.response valueForKeyPath:@"response.status.code"] intValue] == 0,
                   @"Expected response.code == 0, got %d, %@", 
                 [[request.response valueForKeyPath:@"response.status.code"] intValue],
                 [request.response valueForKeyPath:@"response.status.message"]);
    NSDictionary *artist = [request.response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"%@ != %@", [artist valueForKey:@"name"], searchArtist);    
}

- (void)testArtistImages {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Amanda Palmer";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/images"];
    [request setValue:searchArtist forParameter:@"name"];
    [request setIntegerValue:10 forParameter:@"results"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *images = [request.response valueForKeyPath:@"response.images"];
    STAssertEquals(images.count, (NSUInteger)10, @"%d != %d", images.count, 10);
}

- (void)testArtistNews {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"The New Pornographers";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/news"];
    [request setIntegerValue:30 forParameter:@"results"];
    [request setValue:searchArtist forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *news = [request.response valueForKeyPath:@"response.news"];
    STAssertEquals(news.count, (NSUInteger)30, @"%d != %d", news.count, 30);
}

- (void)testArtistProfile {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"RJD2";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/profile"];
    [request setValue:searchArtist forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *artist = [request.response valueForKeyPath:@"response.artist"];
    STAssertTrue([[artist valueForKey:@"name"] isEqualToString:searchArtist], @"Unexpected artist name");
    STAssertTrue([[artist valueForKey:@"id"] isEqualToString:@"ARQG4O41187B98A03B"], @"Unexpected artist id");
}

- (void)testArtistProfileWithBuckets {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"RJD2";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/profile"];
    [request setValue:[NSArray arrayWithObjects:@"blogs", @"images", nil] forParameter:@"bucket"];
    [request setValue:searchArtist forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *artist = [request.response valueForKeyPath:@"response.artist"];
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
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/reviews"];
    [request setIntegerValue:15 forParameter:@"results"];
    [request setValue:searchArtist forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *reviews = [request.response valueForKeyPath:@"response.reviews"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 reviews");
}

- (void)testArtistSongsWithName {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"Blockhead";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/songs"];
    [request setValue:searchArtist forParameter:@"name"];
    [request setIntegerValue:15 forParameter:@"results"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *reviews = [request.response valueForKeyPath:@"response.songs"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 songs");
}

- (void)testArtistSongsWithID {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSString *searchArtist = @"ARF8HTQ1187B9AE693";
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/songs"];
    [request setValue:searchArtist forParameter:@"id"];
    [request setIntegerValue:15 forParameter:@"results"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *reviews = [request.response valueForKeyPath:@"response.songs"];
    STAssertEquals(reviews.count, (NSUInteger)15, @"expected 15 songs");
}

- (void)testArtistSearch {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/search"];
    [request setValue:[NSArray arrayWithObjects:@"mood:chill", @"style:electronic", nil] forParameter:@"description"];
    [request setFloatValue:0.5f forParameter:@"min_familiarity"];
    [request setFloatValue:0.5f forParameter:@"min_hotttnesss"];
    [request setBoolValue:YES forParameter:@"fuzzy_match"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *artists = [request.response valueForKeyPath:@"response.artists"];
    STAssertTrue(artists.count > 0, @"Expected artist.count > 0");
}

- (void)testArtistSimilar {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/similar"];
    [request setValue:[NSArray arrayWithObjects:@"Radiohead", @"Portishead", nil] forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *artists = [request.response valueForKeyPath:@"response.artists"];
    STAssertTrue(artists.count == 15, @"Expected 15 similar artists");
}

- (void)testArtistTerms {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/terms"];
    [request setValue:@"RJD2" forParameter:@"name"];
    [request setValue:ENSortWeight forParameter:@"sort"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *terms = [request.response valueForKeyPath:@"response.terms"];
    STAssertTrue(terms.count > 0, @"Expected at least 1 term");
}

- (void)testArtistTopHottt {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/top_hottt"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *artists = [request.response valueForKeyPath:@"response.artists"];
    STAssertTrue(artists.count == 15, @"Expected 15 artists");
}

- (void)testArtistTopTerms {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/top_terms"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *terms = [request.response valueForKeyPath:@"response.terms"];
    STAssertTrue(terms.count == 15, @"Expected 15 terms");    
}

- (void)testArtistURLs {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/urls"];
    [request setValue:@"Depeche Mode" forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSString *itunesURL = [request.response valueForKeyPath:@"response.urls.itunes_url"];
    STAssertTrue([itunesURL isEqualToString:@"http://itunes.com/DepecheMode"], @"Expected iTunes URL, got: %@", itunesURL);
}

- (void)testArtistVideo {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"artist/video"];
    [request setValue:@"Lady Gaga" forParameter:@"name"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *videos = [request.response valueForKeyPath:@"response.video"];
    STAssertTrue(videos.count == 15, @"Expected 15 videos");
}

- (void)testSongSearch {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"song/search"];
    [request setValue:@"Down with Hot Chip" forParameter:@"combined"];
    [request setIntegerValue:8 forParameter:@"results"];
    [request setFloatValue:0.9f forParameter:@"max_danceability"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *songs = [request.response valueForKeyPath:@"response.songs"];
    STAssertTrue(songs.count == 8, @"Expected 8 songs");
}

- (void)testSongSearchBPM {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"song/search"];
    [request setIntegerValue:25 forParameter:@"results"];
    [request setFloatValue:96.f forParameter:@"max_tempo"];
    [request setFloatValue:94.f forParameter:@"min_tempo"];
    [request setFloatValue:0.5f forParameter:@"artist_min_familiarity"];
    [request setValue:[NSArray arrayWithObjects:@"style:hip-hop", @"mood:aggressive", nil] forParameter:@"description"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *songs = [request.response valueForKeyPath:@"response.songs"];
    STAssertTrue(songs.count == 25, @"Expected 50 songs");    
}

- (void)testSongProfile {
    // first find 25 songs
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"song/search"];
    [request setIntegerValue:25 forParameter:@"results"];
    [request setFloatValue:96.f forParameter:@"max_tempo"];
    [request setFloatValue:94.f forParameter:@"min_tempo"];
    //[request setFloatValue:0.5f forParameter:@"artist_min_familiarity"];
    [request setValue:[NSArray arrayWithObjects:@"style:indie", @"mood:pensive", nil] forParameter:@"description"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *songs = [request.response valueForKeyPath:@"response.songs"];
    STAssertTrue(songs.count == 25, @"Expected 25 songs");
    NSMutableArray *ids = [NSMutableArray arrayWithCapacity:25];
    for (NSDictionary *song in songs) {
        [ids addObject:[song valueForKey:@"id"]];
    }
    
    request = [ENAPIRequest requestWithEndpoint:@"song/profile"];
    [request setValue:ids forParameter:@"id"];
    [request setValue:@"audio_summary" forParameter:@"bucket"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    songs = [request.response valueForKeyPath:@"response.songs"];
    STAssertTrue(songs.count == 25, @"Expected 25 profile results");
}

- (void)testTrackProfile {
    [ENAPI initWithApiKey:TEST_API_KEY];
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.echonest.libechonest.tests"];
    NSString *testMp3Path = [[bundle URLForResource:@"test" withExtension:@"mp3"] path];
    NSData *data = [NSData dataWithContentsOfFile:testMp3Path];
    NSString *md5 = [data MD5];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"track/profile"];
    [request setValue:md5 forParameter:@"md5"];
    [request setValue:@"audio_summary" forParameter:@"bucket"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSDictionary *track = [request.response valueForKeyPath:@"response.track"];
    STAssertTrue([[track valueForKey:@"artist"] isEqualToString:@"Tycho"], @"Expected matching artist");
    
}

- (void)testStaticPlaylist {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"playlist/static"];
    [request setValue:@"artist-description" forParameter:@"type"];
    [request setValue:@"mood:chill" forParameter:@"description"];
    [request setFloatValue:95.f forParameter:@"max_tempo"];
    [request setFloatValue:90.f forParameter:@"min_tempo"];
    [request setFloatValue:0.7f forParameter:@"artist_min_hotttnesss"];
    [request setIntegerValue:0 forParameter:@"key"];  // C
    [request setIntegerValue:0 forParameter:@"mode"]; // minor
    [request setValue:@"audio_summary" forParameter:@"bucket"];
    [request startSynchronous];
    STAssertNil(request.error, @"request.error != nil: %@", request.error);
    STAssertEquals(request.responseStatusCode, 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSArray *songs = [request.response valueForKeyPath:@"response.songs"];
    STAssertTrue(songs.count == 15, @"Expected 15 songs in playlist");
}

- (void)test404 {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENAPIRequest *request = [ENAPIRequest requestWithEndpoint:@"foo/bar"];
    [request startSynchronous];
    STAssertTrue(request.responseStatusCode == 404, @"Expected 404");
}

- (void)testCatalogCreateDelete {
    [ENAPI initWithApiKey:TEST_API_KEY];
    
    // first, lets catalog/list our existing catalogs and delete them (in case we have stragglers from earlier
    // runs.
    
    ENAPIRequest *list_request = [ENAPIRequest requestWithEndpoint:@"catalog/list"];
    [list_request startSynchronous];
    NSArray *catalogs = [list_request.response valueForKeyPath:@"response.catalogs"];
    for (NSDictionary *catalog in catalogs) {
        NSString *catID = [catalog valueForKey:@"id"];
        ENAPIPostRequest *request = [ENAPIPostRequest catalogDeleteWithID:catID];
        [request startSynchronous];
        STAssertTrue(request.responseStatusCode == 200, @"Expected 200 response, got: %d", request.responseStatusCode);        
    }
    
    // okay, we should have a clean slate now...
    
    ENAPIPostRequest *request = [ENAPIPostRequest catalogCreateWithName:@"TEST CATALOG" type:@"song"];
    [request startSynchronous];
    STAssertTrue(request.responseStatusCode == 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    NSString *newID = [request.response valueForKeyPath:@"response.id"];
    int responseCode = [[request.response valueForKeyPath:@"response.code"] intValue];
    STAssertTrue(0 == responseCode, @"Expected 0 responseCode, got: %d", responseCode);
    
    request = [ENAPIPostRequest catalogDeleteWithID:newID];
    [request startSynchronous];
    STAssertTrue(request.responseStatusCode == 200, @"Expected 200 response, got: %d", request.responseStatusCode);
    responseCode = [[request.response valueForKeyPath:@"response.code"] intValue];
    STAssertTrue(0 == responseCode, @"Expected 0 responseCode, got: %d", responseCode);
}

@end
