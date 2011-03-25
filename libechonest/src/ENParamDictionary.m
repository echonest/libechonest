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
    [self setValue:name forKey:@"name"];
}

- (NSString *)name {
    return (NSString *)[self valueForKey:@"name"];
}

- (void)setSort:(NSString *)sort {
    [self setValue:sort forKey:@"sort"];
}

- (NSString *)sort {
    return [self valueForKey:@"sort"];
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

#pragma mark - Multiple Parameter Properties

- (void)setLicenses:(NSArray *)licenses {
    if (nil == licenses) {
        [self.dict removeObjectForKey:@"license"];
    }
    [self.dict setValue:licenses forKey:@"license"];
}

- (NSArray *)licenses {
    return [self.dict valueForKey:@"license"];
}

- (void)setBuckets:(NSArray *)buckets {
    if (nil == buckets) {
        [self.dict removeObjectForKey:@"bucket"];
    }
    [self.dict setValue:buckets forKey:@"bucket"];
}

- (NSArray *)buckets {
    return [self.dict valueForKey:@"bucket"];
}

- (void)setDescriptions:(NSArray *)descriptions {
    if (nil == descriptions) {
        [self.dict removeObjectForKey:@"description"];
    }
    [self.dict setValue:descriptions forKey:@"description"];
}

- (NSArray *)descriptions {
    return [self.dict valueForKey:@"description"];
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

