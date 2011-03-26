//
//  ENParamDictionary.m
//  libechonest
//
//  Created by Art Gillespie on 3/25/11. art@tapsquare.com
//

#import "ENParamDictionary.h"
#import "ENAPI.h"

// private interface
@interface ENParamDictionary()

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key;
- (NSInteger)integerValueForKey:(NSString *)key;
- (void)setBoolValue:(BOOL)value forKey:(NSString *)key;
- (BOOL)boolValueForKey:(NSString *)key;
- (void)setFloatValue:(float)value forKey:(NSString *)key;
- (float)floatValueForKey:(NSString *)key;

@end

@implementation ENParamDictionary
@synthesize dict;

+ (ENParamDictionary *)paramDictionary {
    return [[[ENParamDictionary alloc] init] autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        dict = [NSMutableDictionary dictionaryWithCapacity:5];
        [dict retain];
        CHECK_API_KEY
        [self.dict setValue:[ENAPI apiKey] forKey:@"api_key"];
        [self.dict setValue:@"json" forKey:@"format"];
    }
    return self;
}

- (void)dealloc {
    [dict release];
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [self.dict setValue:value forKey:key];
}
- (id)valueForKey:(NSString *)key {
    return [self.dict valueForKey:key];
}

#pragma mark - Properties

- (NSInteger)count {
    return self.dict.count;
}

#pragma mark - Parameter Properties

#pragma mark - String Parameter Properties

- (void)setName:(NSString *)name {
    // check the current value, if we already have an array, add the name to it.
    if (nil == name)
        return;
    NSObject *current = [self.dict valueForKey:@"name"];
    if (current && [current isKindOfClass:[NSArray class]]) {
        NSMutableArray *tmp = [NSMutableArray arrayWithArray:(NSArray *)current];
        [tmp addObject:name];
        NSArray *array = [NSArray arrayWithArray:tmp];
        [self setValue:array forKey:@"name"];
        return;
    }
    [self setValue:name forKey:@"name"];
}

- (NSString *)name {
    NSObject *v = [self valueForKey:@"name"];
    NSAssert([v isKindOfClass:[NSString class]], @"Expected NSString - probably mixing names with name");
    return (NSString *)v;
}

- (void)setSort:(NSString *)sort {
    [self setValue:sort forKey:@"sort"];
}

- (NSString *)sort {
    return [self valueForKey:@"sort"];
}

- (void)setTitle:(NSString *)title {
    [self setValue:title forKey:@"title"];
}

- (NSString *)title {
    return [self valueForKey:@"title"];
}

- (void)setArtist:(NSString *)artist {
    [self setValue:artist forKey:@"artist"];
}

- (NSString *)artist {
    return [self valueForKey:@"artist"];
}

- (void)setCombined:(NSString *)combined {
    [self setValue:combined forKey:@"combined"];
}

- (NSString *)combined {
    return [self valueForKey:@"combined"];
}

- (void)setArtist_id:(NSString *)artist_id {
    [self setValue:artist_id forKey:@"artist_id"];
}

- (NSString *)artist_id {
    return [self valueForKey:@"artist_id"];
}

#pragma mark - Integer Parameter Properties

- (void)setResults:(NSInteger)results {
    [self setIntegerValue:results forKey:@"results"];
}

- (NSInteger)results {
    return [self integerValueForKey:@"results"];
}

- (void)setStart:(NSInteger)start {
    [self setIntegerValue:start forKey:@"start"];
}

- (NSInteger)start {
    return [self integerValueForKey:@"start"];
}

- (void)setMinResults:(NSInteger)minResults {
    [self setIntegerValue:minResults forKey:@"minResults"];
}

- (NSInteger)minResults {
    return [self integerValueForKey:@"minResults"];
}

#pragma mark - Float Parameter Properties

- (void)setMinFamiliarity:(float)minFamiliarity {
    [self setFloatValue:minFamiliarity forKey:@"min_familiarity"];
}

- (float)minFamiliarity {
    return [self floatValueForKey:@"min_familiarity"];
}

- (void)setMaxFamiliarity:(float)maxFamiliarity {
    [self setFloatValue:maxFamiliarity forKey:@"max_familiarity"];
}

- (float)maxFamiliarity {
    return [self floatValueForKey:@"max_familiarity"];
}

- (void)setMinHotttnesss:(float)minHotttnesss {
    [self setFloatValue:minHotttnesss forKey:@"min_hotttnesss"];
}

- (float)minHotttnesss {
    return [self floatValueForKey:@"min_hotttnesss"];
}

- (void)setMaxHotttnesss:(float)maxHotttnesss {
    [self setFloatValue:maxHotttnesss forKey:@"max_hotttnesss"];
}

- (float)maxHotttnesss {
    return [self floatValueForKey:@"max_hotttnesss"];
}

- (void)setMinTempo:(float)minTempo {
    [self setFloatValue:minTempo forKey:@"min_tempo"];
}

- (float)minTempo {
    return [self floatValueForKey:@"min_tempo"];
}

- (void)setMaxTempo:(float)maxTempo {
    [self setFloatValue:maxTempo forKey:@"max_tempo"];
}

- (float)maxTempo {
    return [self floatValueForKey:@"max_tempo"];
}

- (void)setMinDuration:(float)minDuration {
    [self setFloatValue:minDuration forKey:@"min_duration"];
}

- (float)minDuration {
    return [self floatValueForKey:@"min_duration"];
}

- (void)setMaxDuration:(float)maxDuration {
    [self setFloatValue:maxDuration forKey:@"max_duration"];
}

- (float)maxDuration {
    return [self floatValueForKey:@"max_duration"];
}

- (void)setMinLoudness:(float)minLoudness {
    [self setFloatValue:minLoudness forKey:@"min_loudness"];
}

- (float)minLoudness {
    return [self floatValueForKey:@"min_loudness"];
}

- (void)setMaxLoudness:(float)maxLoudness {
    [self setFloatValue:maxLoudness forKey:@"max_loudness"];
}

- (float)maxLoudness {
    return [self floatValueForKey:@"max_loudness"];
}

#pragma mark - Multiple Parameter Properties

- (void)setLicenses:(NSArray *)licenses {
    if (nil == licenses) {
        [self.dict removeObjectForKey:@"license"];
        return;
    }
    [self.dict setValue:licenses forKey:@"license"];
}

- (NSArray *)licenses {
    return [self.dict valueForKey:@"license"];
}

- (void)setBuckets:(NSArray *)buckets {
    if (nil == buckets) {
        [self.dict removeObjectForKey:@"bucket"];
        return;
    }
    [self.dict setValue:buckets forKey:@"bucket"];
}

- (NSArray *)buckets {
    return [self.dict valueForKey:@"bucket"];
}

- (void)setDescriptions:(NSArray *)descriptions {
    if (nil == descriptions) {
        [self.dict removeObjectForKey:@"description"];
        return;
    }
    [self.dict setValue:descriptions forKey:@"description"];
}

- (NSArray *)descriptions {
    return [self.dict valueForKey:@"description"];
}

- (void)setSeedCatalogs:(NSArray *)seedCatalogs {
    if (nil == seedCatalogs) {
        [self.dict removeObjectForKey:@"seed_catalog"];
        return;
    }
    [self.dict setValue:seedCatalogs forKey:@"seed_catalog"];
}

- (NSArray *)seedCatalogs {
    return [self.dict valueForKey:@"seed_catalog"];
}

- (void)setNames:(NSArray *)names {
    if (nil == names) {
        [self.dict removeObjectForKey:@"name"];
        return;
    }
    // so if we already have a single name string, add it to the array
    NSObject *current = [self.dict valueForKey:@"name"];
    if (current && [current isKindOfClass:[NSString class]]) {
        NSMutableArray *tmp = [NSMutableArray arrayWithArray:names];
        [tmp addObject:current];
        names = [NSArray arrayWithArray:tmp];
    }
    [self.dict setValue:names forKey:@"name"];
}

- (NSArray *)names {
    NSObject *r = [self.dict valueForKey:@"name"];
    NSAssert([r isKindOfClass:[NSArray class]], @"expected array");
    if (![r isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return (NSArray *)r;
}

- (void)setIDs:(NSArray *)IDs {
    if (nil == IDs) {
        [self.dict removeObjectForKey:@"id"];
        return;
    }
    [self.dict setValue:IDs forKey:@"id"];
}

- (NSArray *)IDs {
    return [self.dict valueForKey:@"id"];
}

#pragma mark - BOOL Parameter Properties

- (void)setHighRelevance:(BOOL)highRelevance {
    [self setBoolValue:highRelevance forKey:@"high_relevance"];
}

- (BOOL)highRelevance {
    return [self boolValueForKey:@"high_relevance"];
}

- (void)setLimit:(BOOL)limit {
    [self setBoolValue:limit forKey:@"limit"];
}

- (BOOL)limit {
    return [self boolValueForKey:@"limit"];
}

- (void)setFuzzyMatch:(BOOL)fuzzyMatch {
    [self setBoolValue:fuzzyMatch forKey:@"fuzzy_match"];
}

- (BOOL)fuzzyMatch {
    return [self boolValueForKey:@"fuzzy_match"];
}

- (void)setReverse:(BOOL)reverse {
    [self setBoolValue:reverse forKey:@"reverse"];
}

- (BOOL)reverse {
    return [self boolValueForKey:@"reverse"];
}

#pragma mark - Private Methods

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key {
    [self setValue:[NSNumber numberWithInteger:value] forKey:key];
}

- (NSInteger)integerValueForKey:(NSString *)key {
    NSNumber *v = [self valueForKey:key];
    NSAssert1(nil != v, @"requested %@ property, but not set on param dictionary", key);
    if (v) {
        return [v integerValue];
    }
    return 0;    
}

- (void)setBoolValue:(BOOL)value forKey:(NSString *)key {
    [self setValue:[NSNumber numberWithBool:value] forKey:key];    
}

- (BOOL)boolValueForKey:(NSString *)key {
    NSNumber *v = [self valueForKey:key];
    NSAssert1(nil != v, @"requested %@ property, but not set on param dictionary", key);
    if (v) {
        return [v boolValue];
    }
    return 0;        
}

- (void)setFloatValue:(float)value forKey:(NSString *)key {
    [self setValue:[NSNumber numberWithFloat:value] forKey:key];
}
- (float)floatValueForKey:(NSString *)key {
    NSNumber *v = [self valueForKey:key];
    NSAssert1(nil != v, @"requested %@ property, but not set on param dictionary", key);
    if (v) {
        return [v floatValue];
    }
    return 0;
}

@end

