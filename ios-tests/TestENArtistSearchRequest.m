//
//  TestENArtistSearchRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/21/11. art@tapsquare.com
//

#import "TestENArtistSearchRequest.h"
#import "ENAPI.h"
#import "ENArtistSearchRequest.h"
#import "tests.h"

@implementation TestENArtistSearchRequest

- (void)testArtistSearchRequest {
    [ENAPI initWithApiKey:TEST_API_KEY];
    ENArtistSearchRequest *request = [[[ENArtistSearchRequest alloc] initWithName:nil] autorelease];
    request.name = @"Jetpacks";
    [request.description addObject:@"mood:chill"];
    request.fuzzyMatch = YES;
    [request prepare];
    [request startSynchronous];
    NSDictionary *response = [request JSONValue];
    int status_code = [[response valueForKeyPath:@"response.status.code"] intValue];
    STAssertEquals(0, status_code, @"non-zero status code: %d", status_code);
    NSLog(@"response: %@", response);
}

@end
