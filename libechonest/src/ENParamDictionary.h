//
//  ENParamDictionary.h
//  libechonest
//
//  Copyright (c) 2011, tapsquare, llc. (http://www.tapsquare.com, art@tapsquare.com)
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//   * Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
//   * Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in the
//     documentation and/or other materials provided with the distribution.
//   * Neither the name of the tapsquare, llc nor the names of its contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL TAPSQUARE, LLC. BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Foundation/Foundation.h>


@interface ENParamDictionary : NSObject {
    
}

+ (ENParamDictionary *)paramDictionary;
- (id)init;
- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;

@property (unsafe_unretained, readonly) NSMutableDictionary *dict;
@property (readonly) NSInteger count;

/* parameter properties */


// string parameters
@property (strong) NSString *name;
@property (strong) NSString *sort;
@property (strong) NSString *title;
@property (strong) NSString *artist;
@property (strong) NSString *combined;
@property (strong) NSString *artist_id;

// int parameters
@property (assign) NSInteger results;
@property (assign) NSInteger start;
@property (assign) NSInteger minResults;

// float parameters
@property (assign) float minFamiliarity;
@property (assign) float maxFamiliarity;
@property (assign) float minHotttnesss;
@property (assign) float maxHotttnesss;
@property (assign) float minTempo;
@property (assign) float maxTempo;
@property (assign) float minDuration;
@property (assign) float maxDuration;
@property (assign) float minLoudness;
@property (assign) float maxLoudness;

// multiple parameters
@property (strong) NSArray *licenses;
@property (strong) NSArray *buckets;
@property (strong) NSArray *descriptions;
@property (strong) NSArray *seedCatalogs;
@property (strong) NSArray *names; // for some requests (e.g. artist/similar) we support multiple names
@property (strong) NSArray *IDs;   // for same requests (e.g. artist/similar) we support multiple ids

// BOOL parameters
@property (assign) BOOL highRelevance;
@property (assign) BOOL limit;
@property (assign) BOOL fuzzyMatch;
@property (assign) BOOL reverse;

@end
