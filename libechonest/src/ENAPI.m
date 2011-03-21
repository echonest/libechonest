//
//  ENAPI.m
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import "ENAPI.h"

const NSString *ENLicenseEchoSource = @"echo-source";
const NSString *ENLicenseAllRightsReserved = @"all-rights-reserved";
const NSString *ENLicenseCreativeCommonsBy_SA = @"cc-by-sa";
const NSString *ENLicenseCreativeCommonsBy_NC = @"cc-by-nc";
const NSString *ENLicenseCreativeCommonsBy_NC_ND = @"cc-by-nc-nd";
const NSString *ENLicenseCreativeCommonsBy_NC_SA = @"cc-by-nc-sa";
const NSString *ENLicenseCreativeCommonsBy_ND = @"cc-by-nd";
const NSString *ENLicenseCreativeCommonsBy = @"cc-by";
const NSString *ENLicensePublicDomain = @"public-domain";
const NSString *ENLicenseUnknown = @"unknown";

static NSString *EN_API_KEY = nil;

@implementation ENAPI

+ (void)initWithApiKey:(NSString *)apiKey {
    EN_API_KEY = [apiKey retain];
}

+ (NSString *)apiKey {
    return EN_API_KEY;
}

@end
