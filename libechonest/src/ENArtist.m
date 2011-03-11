//
//  ENArtist.m
//  libechonest
//
//  Created by Art Gillespie on 2/23/11.
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import "ENArtist.h"


@implementation ENArtist

+ (void) audioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion {
    
}

+ (BOOL) audioWithName:(NSString *)name count:(NSInteger)count start:(NSInteger)start data:(NSArray **)data error:(NSError **)error {
    return NO;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
