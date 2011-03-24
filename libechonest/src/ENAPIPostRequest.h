//
//  ENAPIPostRequest.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import "asi-http-request/ASIFormDataRequest.h"
#import "asi-http-request/ASIProgressDelegate.h"


@interface ENAPIPostRequest : ASIFormDataRequest <ASIProgressDelegate> {
    
}

+ (ENAPIPostRequest *)trackUploadRequestWithFile:(NSString *)filePath;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithFile:(NSString *)filePath;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithId:(NSString *)trackid;

+ (ENAPIPostRequest *)trackAnalyzeRequestWithMD5:(NSString *)md5;

- (NSDictionary *)results;

@end
