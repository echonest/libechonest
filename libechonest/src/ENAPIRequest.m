//
//  ENAPIRequest.m
//  libechonest
//
//  Created by Art Gillespie on 3/10/11. art@tapsquare.com
//

#import "ENAPIRequest.h"

#import "ENAPI_utils.h"
#import "ENAPI.h"
#import "ENSigner.h"
#import "NSObject+JSON.h"
#import "asi-http-request/ASIHTTPRequest.h"

@interface ENAPIRequest()

- (void)_prepareToStart;
- (NSString *)_constructURL;
- (NSInteger)_generateTimestamp;
- (NSString *)_generateNonce:(NSInteger)timestamp;
- (NSString *)_constructBaseSignatureForOAuth;
- (void)_includeOAuthParams;

@property (retain) ASIHTTPRequest *request;
@property (retain,readwrite) NSMutableDictionary *params;
@property (retain) NSDictionary *_responseDict;
@property (assign) BOOL isAPIRequest;
@property (retain) NSString *analysisURL;
@end

@implementation ENAPIRequest
@synthesize delegate, response, _responseDict, endpoint;
@synthesize request, params;
@synthesize userInfo;
@synthesize isAPIRequest;
@synthesize analysisURL;

+ (ENAPIRequest *)requestWithEndpoint:(NSString *)endpoint_ {
    return [[[ENAPIRequest alloc] initWithEndpoint:endpoint_] autorelease];
}

+ (ENAPIRequest *)requestWithAnalysisURL:(NSString *)url_ {
    return [[[ENAPIRequest alloc] initWithAnalysisURL:url_] autorelease];
}

- (ENAPIRequest *)initWithEndpoint:(NSString *)endpoint_ {
    self = [super init];
    if (self) {
        CHECK_API_KEY
        self.isAPIRequest = YES;
        endpoint = [endpoint_ retain];
        self.params = [NSMutableDictionary dictionaryWithCapacity:4];
        [self.params setValue:[ENAPI apiKey] forKey:@"api_key"];
        [self.params setValue:@"json" forKey:@"format"];
        if ([ENAPI isSecuredEndpoint:endpoint]) {
            // fail fast is consumer key & secret missing
            CHECK_OAUTH_KEYS
        }
    }
    return self;
}

- (ENAPIRequest *)initWithAnalysisURL:(NSString *)url {
    self = [super init];
    if (self) {
        CHECK_API_KEY
        self.isAPIRequest = NO;
        self.analysisURL = url;
        self.params = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return self;    
}

- (void)dealloc {
    [params release];
    [request release];
    [_responseDict release];
    [endpoint release];
    [userInfo release];
    [analysisURL release];
    [super dealloc];
}

- (void)startSynchronous {
    [self _prepareToStart];
    self.request.delegate = self;
    [self.request startSynchronous];
}

- (void)startAsynchronous {
    [self _prepareToStart];
    self.request.delegate = self;
    [self.request startAsynchronous];
}

- (void)setValue:(id)value forParameter:(NSString *)param {
    [self.params setValue:value forKey:param];
}

- (void)setIntegerValue:(NSInteger)value forParameter:(NSString *)param {
    [self.params setValue:[NSNumber numberWithInteger:value] forKey:param];
}

- (void)setFloatValue:(float)value forParameter:(NSString *)param {
    [self.params setValue:[NSNumber numberWithFloat:value] forKey:param];
}

- (void)setBoolValue:(BOOL)value forParameter:(NSString *)param {
    [self.params setValue:[NSNumber numberWithBool:value] forKey:param];
}

- (void)cancel {
    [self.request clearDelegatesAndCancel];
}

- (BOOL)complete {
    return self.request.complete;
}

#pragma mark - Properties

- (NSDictionary *)response {
    if (nil == _responseDict) {
        NSDictionary *dict = [self.request.responseString JSONValue];
        _responseDict = [dict retain];
    }
    return _responseDict;
}

- (NSString *)responseString {
    return self.request.responseString;
}

- (NSInteger)responseStatusCode {
    return self.request.responseStatusCode;
}

- (NSError *)error {
    return self.request.error;
}

- (NSUInteger)echonestStatusCode {
    return [[self.response valueForKeyPath:@"response.status.code"] intValue];
}

- (NSString *)echonestStatusMessage {
    return [self.response valueForKeyPath:@"response.status.message"];
}

- (NSURL *)requestURL {
    return self.request.url;
}

#pragma mark - ASIHTTPRequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
    if ([delegate respondsToSelector:@selector(requestFinished:)]) {
        [delegate requestFinished:self];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    if([delegate respondsToSelector:@selector(requestFailed:)]) {
        [delegate requestFailed:self];
    }
}

#pragma mark - Private Methods

- (void)_prepareToStart {
    if (nil != self.analysisURL) {
        self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.analysisURL]];
    } else {
        // add OAuth parameter if we're hitting a secured endpoint
        if ([ENAPI isSecuredEndpoint:self.endpoint]) {
            [self _includeOAuthParams];
        }
        self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self _constructURL]]];

    }
}

- (NSString *)_constructURL {
    NSString *ret = [NSString stringWithFormat:@"%@%@?%@", ECHONEST_API_URL, self.endpoint, [self.params enapi_queryString]];
    return ret;
}

- (NSInteger)_generateTimestamp {
    NSDate *now = [[NSDate alloc] init];
    NSTimeInterval timestamp = [now timeIntervalSince1970];
    [now release];
    return (NSInteger)timestamp;
}

- (NSString *)_generateNonce:(NSInteger)timestamp {
    NSString *tmp = [[NSString alloc] initWithFormat:@"%d", timestamp];
    NSData *nonceData = [tmp dataUsingEncoding:NSUTF8StringEncoding];
    NSString *nonce = [nonceData enapi_MD5];
    [tmp release];
    return nonce;
}

- (NSString *)_constructBaseSignatureForOAuth {
    NSString *queryString = [self.params enapi_queryString];

    NSString *base_signature = [NSString stringWithFormat:@"GET&%@%@&%@",
                                ENEscapeStringForURL(ECHONEST_API_URL),
                                ENEscapeStringForURL(self.endpoint),
                                ENEscapeStringForURL(queryString)];

    NSString *signature = [ENSigner signText:base_signature
                            WithKeyAndEncode:[ENAPI sharedSecret]];

    return signature;
}

- (void)_includeOAuthParams {
    NSTimeInterval timestamp = [self _generateTimestamp];
    NSString *nonce = [self _generateNonce:timestamp];

    [self setValue:[ENAPI consumerKey] forParameter:@"oauth_consumer_key"];
    [self setIntegerValue:(NSInteger)timestamp  forParameter:@"oauth_timestamp"];
    [self setValue:@"HMAC-SHA1" forParameter:@"oauth_signature_method"];
    [self setValue:nonce forParameter:@"oauth_nonce"];
    [self setValue:@"1.0" forParameter:@"oauth_version"];

    NSString *signature = [self _constructBaseSignatureForOAuth];

    [self setValue: signature forParameter:@"oauth_signature"];
}

@end