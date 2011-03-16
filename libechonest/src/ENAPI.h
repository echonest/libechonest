//
//  ENAPI.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ENAPI : NSObject {
    
}

+ (void)initWithApiKey:(NSString *)apiKey;
+ (NSString *)apiKey;

@end
