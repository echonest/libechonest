//
//  NSArray+ENAPI.m
//  libechonest
//
//  Created by Art Gillespie on 3/29/11. art@tapsquare.com
//

#import "NSArray+ENAPI.h"
#import "NSObject+JSON.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation NSArray (NSArray_ENAPI)

- (NSString *)enapi_catalogUpdateBlockWithAction:(NSString *)action {
    // first create the array of "item" dictionaries
    NSMutableArray *f_items = [NSMutableArray arrayWithCapacity:self.count];
    for (MPMediaItem *item in (NSArray *)self) {
        // see http://developer.echonest.com/docs/v4/catalog.html#update
        
        NSMutableDictionary *block = [NSMutableDictionary dictionaryWithCapacity:4];
        
        [block setValue:[[item valueForProperty:MPMediaItemPropertyPersistentID] descriptionWithLocale:nil] forKey:@"item_id"];
        [block setValue:[item valueForProperty:MPMediaItemPropertyTitle] forKey:@"song_name"];
        [block setValue:[item valueForProperty:MPMediaItemPropertyArtist] forKey:@"artist_name"];
        [block setValue:[item valueForProperty:MPMediaItemPropertyPlayCount] forKey:@"play_count"];
        [block setValue:[item valueForProperty:MPMediaItemPropertySkipCount] forKey:@"skip_count"];
        
        NSMutableDictionary *item_dict = [NSDictionary dictionaryWithObject:block forKey:@"item"];
        if (nil != action) {
            [item_dict setValue:action forKey:@"action"];
        }
        [f_items addObject:item_dict];
    }
    return [f_items JSONRepresentation];
}

@end
