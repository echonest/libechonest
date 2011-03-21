//
//  ENArtistSearchRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/21/11. art@tapsquare.com
//

#import "ENArtistSearchRequest.h"
#import "ENAPI.h"
#import "ENAPI_utils.h"
#import "NSMutableDictionary+QueryString.h"

const NSString *ENSortFamiliarityAscending = @"familiarity-asc";
const NSString *ENSortFamiliarityDescending = @"familiarity-desc";
const NSString *ENSortHotttnesssAscending = @"hotttnesss-asc";
const NSString *ENSortHotttnesssDescending = @"hotttness-desc";


@implementation ENArtistSearchRequest
@synthesize bucket, limit, name, description, fuzzyMatch, minFamiliarity, maxFamiliarity, minHotttnesss, maxHotttnesss, sortOrder, count;

- (id)initWithName:(NSString *)name_ {
    self = [super initWithURL:nil];
    if (self) {
        self.name = name_;
        self.bucket = [NSMutableArray arrayWithCapacity:3];
        self.description = [NSMutableArray arrayWithCapacity:3];
        self.count = 15;
    }
    return self;
}

- (void)dealloc {
    [name release];
    [bucket release];
    [description release];
    [sortOrder release];
    [super dealloc];
}

- (void)prepare {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:6];
    [params setValue:[ENAPI apiKey] forKey:@"api_key"];
    [params setValue:@"json" forKey:@"format"];
    if (self.limit) {
        // technically, we need to search for an idspace here, but the API will give us 
        // an error back, which is probably the best way to deal with the error anyway
        NSAssert(nil != self.bucket && self.bucket.count > 0, @"limit == true but no buckets");
        [params setValue:[NSNumber numberWithBool:self.limit] forKey:@"limit"];
    }
    if (nil != self.bucket && self.bucket.count > 0) {
        [params setValue:self.bucket forKey:@"bucket"];
    }
    if (nil != self.name) {
        [params setValue:self.name forKey:@"name"];
    }
    if (nil != self.description && self.description.count > 0) {
        [params setValue:self.description forKey:@"description"];
    }
    if (self.fuzzyMatch) {
        [params setValue:[NSNumber numberWithBool:self.fuzzyMatch] forKey:@"fuzzy_match"];
    }

    // it'd be nice to keep a flag for each of these and only send them to the server
    // when they've been explicitly set
    /*
    [params setValue:[NSNumber numberWithFloat:self.minFamiliarity] forKey:@"min_familiarity"];
    [params setValue:[NSNumber numberWithFloat:self.maxFamiliarity] forKey:@"max_familiarity"];
    [params setValue:[NSNumber numberWithFloat:self.minHotttnesss] forKey:@"min_hotttnesss"];
    [params setValue:[NSNumber numberWithFloat:self.maxHotttnesss] forKey:@"max_hotttnesss"];
    */
    
    if (self.sortOrder) {
        [params setValue:self.sortOrder forKey:@"sort"];
    }
    
    // now set up the url
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", 
                           ECHONEST_API_URL, 
                           @"artist/search", 
                           [params queryString]];
    self.url = [NSURL URLWithString:urlString];
    self.requestMethod = @"GET";

}

@end
