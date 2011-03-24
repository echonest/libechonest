//
//  ENAPI.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>

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


@interface ENAPI : NSObject {
    
}

+ (void)initWithApiKey:(NSString *)apiKey;
+ (NSString *)apiKey;


@end
