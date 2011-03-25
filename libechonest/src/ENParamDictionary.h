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
@property (assign) NSInteger results;
@property (assign) NSInteger start;

@end
