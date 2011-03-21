//
//  ENAPI.h
//  libechonest
//
//  Created by Art Gillespie on 3/15/11. art@tapsquare.com
//

#import <Foundation/Foundation.h>

extern const NSString *ENLicenseEchoSource;
extern const NSString *ENLicenseAllRightsReserved;
extern const NSString *ENLicenseCreativeCommonsBy_SA;
extern const NSString *ENLicenseCreativeCommonsBy_NC;
extern const NSString *ENLicenseCreativeCommonsBy_NC_ND;
extern const NSString *ENLicenseCreativeCommonsBy_NC_SA;
extern const NSString *ENLicenseCreativeCommonsBy_ND;
extern const NSString *ENLicenseCreativeCommonsBy;
extern const NSString *ENLicensePublicDomain;
extern const NSString *ENLicenseUnknown;


@interface ENAPI : NSObject {
    
}

+ (void)initWithApiKey:(NSString *)apiKey;
+ (NSString *)apiKey;

@end
