//
//  ENParamDictionary.h
//  libechonest
//
//  Created by Art Gillespie on 3/25/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>


@interface ENParamDictionary : NSObject {
    
}

+ (ENParamDictionary *)paramDictionary;
- (id)init;
- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;

@property (readonly) NSMutableDictionary *dict;
@property (readonly) NSInteger count;

/* parameter properties */


// string parameters
@property (retain) NSString *name;
@property (retain) NSString *sort;
@property (retain) NSString *title;
@property (retain) NSString *artist;
@property (retain) NSString *combined;
@property (retain) NSString *artist_id;

// int parameters
@property (assign) NSInteger results;
@property (assign) NSInteger start;
@property (assign) NSInteger minResults;

// float parameters
@property (assign) float minFamiliarity;
@property (assign) float maxFamiliarity;
@property (assign) float minHotttnesss;
@property (assign) float maxHotttnesss;
@property (assign) float minTempo;
@property (assign) float maxTempo;
@property (assign) float minDuration;
@property (assign) float maxDuration;
@property (assign) float minLoudness;
@property (assign) float maxLoudness;

// multiple parameters
@property (retain) NSArray *licenses;
@property (retain) NSArray *buckets;
@property (retain) NSArray *descriptions;
@property (retain) NSArray *seedCatalogs;
@property (retain) NSArray *names; // for some requests (e.g. artist/similar) we support multiple names
@property (retain) NSArray *IDs;   // for same requests (e.g. artist/similar) we support multiple ids

// BOOL parameters
@property (assign) BOOL highRelevance;
@property (assign) BOOL limit;
@property (assign) BOOL fuzzyMatch;
@property (assign) BOOL reverse;

@end
