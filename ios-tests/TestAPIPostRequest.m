//
//  TestAPIPostRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import "TestAPIPostRequest.h"
#import "ENAPI.h"
#import "ENAPI_utils.h"
#import "ENAPIPostRequest.h"

static NSString *TEST_API_KEY = @"2J12S2GOSDBV2KC6V";

@implementation TestAPIPostRequest

- (void)setUp {
    [ENAPI initWithApiKey:TEST_API_KEY];
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.echonest.libechonest.tests"];
    testMp3Path = [[[bundle URLForResource:@"test" withExtension:@"mp3"] path] retain];
}

- (void)tearDown {
    [testMp3Path release];
}

- (void)testTrackUpload {    
    /*
     * TODO: [alg] This test takes a long time, so we comment it out. Be sure to run it
     * now and then.
     */
    
    /*
    ENAPIPostRequest *request = [ENAPIPostRequest trackUploadRequestWithFile:testMp3Path];
    STAssertNotNil(request, @"request shouldn't be nil");
    [request startSynchronous];
    if (request.error)
        STFail(@"Request error not nil: %@", request.error);
    NSDictionary *results = [request results];
    NSDictionary *response = [results valueForKey:@"response"];
    NSDictionary *track = [response valueForKey:@"track"];
    STAssertTrue([[track valueForKey:@"artist"] isEqualToString:@"Tycho"], @"Expected artist == tycho : %@", [track valueForKey:@"artist"]);
    */
}

- (void)testTrackAnalyzeWithFile{

    /**
     * TODO: [alg] This test takes a long time so we comment it out. Be sure to run it
     * occasionally.
     */
    /*
    ENAPIPostRequest *request = [ENAPIPostRequest trackAnalyzeRequestWithFile:testMp3Path];
    STAssertNotNil(request, @"request shouldn't be nil");
    [request startSynchronous];
    if (request.error)
        STFail(@"Request error not nil: %@", request.error);
    NSDictionary *results = [request results];
    NSDictionary *response = [results valueForKey:@"response"];
    NSDictionary *track = [response valueForKey:@"track"];
    NSLog(@"track: %@", track);
    STAssertTrue([[track valueForKey:@"artist"] isEqualToString:@"Tycho"], @"Expected artist == tycho : %@", [track valueForKey:@"artist"]);
     */
}

- (void)testTrackAnalyzeWithTrackId {
    ENAPIPostRequest *request = [ENAPIPostRequest trackAnalyzeRequestWithId:@"TRYRXSE12EBCE628F1"];
    STAssertNotNil(request, @"request shouldn't be nil");
    [request startSynchronous];
    if (request.error)
        STFail(@"Request error not nil: %@", request.error);
    NSDictionary *results = [request results];
    NSDictionary *response = [results valueForKey:@"response"];
    NSDictionary *track = [response valueForKey:@"track"];
    NSLog(@"track: %@", track);
    STAssertTrue([[track valueForKey:@"artist"] isEqualToString:@"Tycho"], @"Expected artist == tycho : %@", [track valueForKey:@"artist"]);    
}

@end
