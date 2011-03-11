//
//  ENEchonest.h
//  libechonest
//
//  Created by Art Gillespie on 3/8/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>


NSString *ENEchonestGetMessage();

@interface ENEchonest : NSObject {
@private
    
}

- (id)initWithApiKey:(NSString *)apiKey;

- (void)audioWithName:(NSString *)name count:(int)count start:(int)start;

@end
