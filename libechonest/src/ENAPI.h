//
//  ENAPI.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>
#import "ENAPI_utils.h"
#import "ENAPIRequest.h"
#import "ENAPIPostRequest.h"
#import "NSData+MD5.h"
#import "NSMutableDictionary+QueryString.h"
#import "ENParamDictionary.h"

// License string constants

extern NSString * const ENLicenseEchoSource;
extern NSString * const ENLicenseAllRightsReserved;
extern NSString * const ENLicenseCreativeCommonsBy_SA;
extern NSString * const ENLicenseCreativeCommonsBy_NC;
extern NSString * const ENLicenseCreativeCommonsBy_NC_ND;
extern NSString * const ENLicenseCreativeCommonsBy_NC_SA;
extern NSString * const ENLicenseCreativeCommonsBy_ND;
extern NSString * const ENLicenseCreativeCommonsBy;
extern NSString * const ENLicensePublicDomain;
extern NSString * const ENLicenseUnknown;

// Sort string constants

extern NSString * const ENSortFamiliarityAscending;
extern NSString * const ENSortFamiliarityDescending;
extern NSString * const ENSortHotttnesssAscending;
extern NSString * const ENSortHotttnesssDescending;
extern NSString * const ENSortWeight;
extern NSString * const ENSortFrequency;

@interface ENAPI : NSObject {
    
}

+ (void)initWithApiKey:(NSString *)apiKey;
+ (NSString *)apiKey;


@end
