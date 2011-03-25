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
@property (retain) NSString * name;
@property (retain) NSString *sort;

// int parameters
@property (assign) NSInteger results;
@property (assign) NSInteger start;

// float parameters
@property (assign) float minFamiliarity;
@property (assign) float maxFamiliarity;
@property (assign) float minHotttnesss;
@property (assign) float maxHotttnesss;

// multiple parameters
@property (retain) NSArray *licenses;
@property (retain) NSArray *buckets;
@property (retain) NSArray *descriptions;

// BOOL parameters
@property (assign) BOOL highRelevance;
@property (assign) BOOL limit;
@property (assign) BOOL fuzzyMatch;

@end
