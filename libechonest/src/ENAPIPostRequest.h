//
//  ENAPIPostRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import "asi-http-request/ASIFormDataRequest.h"
#import "asi-http-request/ASIProgressDelegate.h"


@interface ENAPIPostRequest : ASIFormDataRequest <ASIProgressDelegate> {
    
}

+ (ENAPIPostRequest *)trackUploadRequestWithFile:(NSString *)filePath;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithFile:(NSString *)filePath;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithId:(NSString *)idOrMd5;

- (NSDictionary *)results;

@end
