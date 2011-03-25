//
//  ENAPIPostRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import "ENAPIPostRequest.h"
#import "ENAPI.h"
#import "ENAPI_utils.h"

@implementation ENAPIPostRequest

+ (ENAPIPostRequest *)trackUploadRequestWithFile:(NSString *)filePath {
    CHECK_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"%@track/upload", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ENAPIPostRequest *request = [ENAPIPostRequest requestWithURL:url];
    request.postFormat = ASIMultipartFormDataPostFormat;
    [request setPostValue:[ENAPI apiKey] forKey:@"api_key"];
    [request setFile:filePath forKey:@"track"];
    [request setPostValue:@"mp3" forKey:@"filetype"];
    request.uploadProgressDelegate = self;
    request.timeOutSeconds = 180;
    return request;
}

+ (ENAPIPostRequest *)trackAnalyzeRequestWithFile:(NSString *)filePath {
    CHECK_API_KEY
    // we need the md5 of the file
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSString *md5 = [fileData MD5];
    return [ENAPIPostRequest trackAnalyzeRequestWithMD5:md5];
}

+ (ENAPIPostRequest *)trackAnalyzeRequestWithId:(NSString *)trackid {
    CHECK_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"%@track/analyze", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
        
    ENAPIPostRequest *request = [ENAPIPostRequest requestWithURL:url];
    request.postFormat = ASIMultipartFormDataPostFormat;
    [request setPostValue:[ENAPI apiKey] forKey:@"api_key"];
    [request setPostValue:trackid forKey:@"id"];
    request.uploadProgressDelegate = self;
    request.timeOutSeconds = 180;
    return request;    
}

+ (ENAPIPostRequest *)trackAnalyzeRequestWithMD5:(NSString *)md5 {
    CHECK_API_KEY
    NSString *urlString = [NSString stringWithFormat:@"%@track/analyze", ECHONEST_API_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ENAPIPostRequest *request = [ENAPIPostRequest requestWithURL:url];
    request.postFormat = ASIMultipartFormDataPostFormat;
    [request setPostValue:[ENAPI apiKey] forKey:@"api_key"];
    [request setPostValue:md5 forKey:@"md5"];
    request.uploadProgressDelegate = self;
    request.timeOutSeconds = 180;
    return request;    
}

- (NSDictionary *)results {
    return [self.responseString JSONValue]; 
}

#pragma mark - ASIProgressDelegate

- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes {
}
@end
