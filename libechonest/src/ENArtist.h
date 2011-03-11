//
//  ENArtist.h
//  libechonest
//
//  Created by Art Gillespie on 2/23/11.
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ENArtist : NSObject {
@private
    
}

+ (void) audioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion;

+ (BOOL) audioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start data:(NSArray **)data error:(NSError **)error;

@end
