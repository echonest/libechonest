//
//  ENAPI.m
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import "ENAPI.h"

NSString * const ENLicenseEchoSource = @"echo-source";
NSString * const ENLicenseAllRightsReserved = @"all-rights-reserved";
NSString * const ENLicenseCreativeCommonsBy_SA = @"cc-by-sa";
NSString * const ENLicenseCreativeCommonsBy_NC = @"cc-by-nc";
NSString * const ENLicenseCreativeCommonsBy_NC_ND = @"cc-by-nc-nd";
NSString * const ENLicenseCreativeCommonsBy_NC_SA = @"cc-by-nc-sa";
NSString * const ENLicenseCreativeCommonsBy_ND = @"cc-by-nd";
NSString * const ENLicenseCreativeCommonsBy = @"cc-by";
NSString * const ENLicensePublicDomain = @"public-domain";
NSString * const ENLicenseUnknown = @"unknown";

NSString * const ENSortFamiliarityAscending = @"familiarity-asc";
NSString * const ENSortFamiliarityDescending = @"familiarity-desc";
NSString * const ENSortHotttnesssAscending = @"hotttnesss-asc";
NSString * const ENSortHotttnesssDescending = @"hotttnesss-desc";
NSString * const ENSortWeight = @"weight";
NSString * const ENSortFrequency = @"frequency";

static NSString *EN_API_KEY = nil;

@implementation ENAPI

+ (void)initWithApiKey:(NSString *)apiKey {
    EN_API_KEY = [apiKey retain];
}

+ (NSString *)apiKey {
    return EN_API_KEY;
}

@end
