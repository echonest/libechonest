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

#pragma mark - Private Methods

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key {
    [self setValue:[NSNumber numberWithInteger:value] forKey:key];
}

- (NSInteger)integerValueForKey:(NSString *)key {
    NSNumber *v = [self valueForKey:@"start"];
    NSAssert1(nil != v, @"requested %@ property, but not set on param dictionary", key);
    if (v) {
        return [v integerValue];
    }
    return 0;    
}

- (NSInteger)count {
    return self.dict.count;
}

@end

