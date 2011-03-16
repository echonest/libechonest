//
//  ENAPIPostRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//  Copyright 2011 tapsquare, llc. All rights reserved.
//

#import "asi-http-request/ASIFormDataRequest.h"


@interface ENAPIPostRequest : ASIFormDataRequest {
    
}

+ (ENAPIPostRequest *)trackUploadRequestWithFile:(NSString *)filePath;

@end
