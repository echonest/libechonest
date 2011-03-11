//
//  TestNSMutableDictionary+QueryString.m
//  libechonest
//
//  Created by Art Gillespie on 3/11/11. art@tapsquare.com
//

#import "TestNSMutableDictionary+QueryString.h"
#import "NSMutableDictionary+QueryString.h"

@implementation TestNSMutableDictionary_QueryString

- (void)testSlashEncoding {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setValue:@"Cut/Copy/Paste" forKey:@"slashdata"];
    NSString *encoded = [params queryString];
    NSString *escapeString = @"slashdata=Cut%2FCopy%2FPaste";
    STAssertTrue([encoded isEqualToString:escapeString], @"Escape failure: %@ != %@", encoded, escapeString);
}

- (void)testEqualsEscape {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setValue:@"this==that" forKey:@"eqdata"];
    NSString *encoded = [params queryString];
    NSString *escapeString = @"eqdata=this%3D%3Dthat";
    STAssertTrue([encoded isEqualToString:escapeString], @"Escape failure: %@ != %@", encoded, escapeString);
}

- (void)testSpaceEscape {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setValue:@"Hey Jude, Take A Sad Song..." forKey:@"spacedata"];
    NSString *encoded = [params queryString];
    NSString *escapeString = @"spacedata=Hey%20Jude%2C%20Take%20A%20Sad%20Song...";
    STAssertTrue([encoded isEqualToString:escapeString], @"Escape failure: %@ != %@", encoded, escapeString);    
}

- (void)testEscapeOmnibus {
    // this tests all the reserved characters specified by http://www.ietf.org/rfc/rfc3986.txt
    // as well as testing ordering (`queryString` returns the parameters sorted alphabetically by key)
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setValue:@" " forKey:@"space"];
    [params setValue:@"/" forKey:@"slash"];
    [params setValue:@"?" forKey:@"qmark"];
    [params setValue:@"#" forKey:@"hash"];
    [params setValue:@"[" forKey:@"lbrack"];
    [params setValue:@"]" forKey:@"rbrack"];
    [params setValue:@"@" forKey:@"atmark"];
    [params setValue:@"!" forKey:@"excmark"];
    [params setValue:@"$" forKey:@"dolla"];
    [params setValue:@"&" forKey:@"amp"];
    [params setValue:@"'" forKey:@"squote"];
    [params setValue:@"(" forKey:@"lparen"];
    [params setValue:@")" forKey:@"rparen"];
    [params setValue:@"*" forKey:@"aster"];
    [params setValue:@"+" forKey:@"plus"];
    [params setValue:@"," forKey:@"comma"];
    [params setValue:@";" forKey:@"semic"];
    [params setValue:@"=" forKey:@"equals"];
    
    NSString *encoded = [params queryString];
    NSLog(@"encoded = %@", encoded);
    NSString *escapeString = @"amp=%26&aster=%2A&atmark=%40&comma=%2C&dolla=%24&equals=%3D&excmark=%21&hash=%23&lbrack=%5B&lparen=%28&plus=%2B&qmark=%3F&rbrack=%5D&rparen=%29&semic=%3B&slash=%2F&space=%20&squote=%27";
    STAssertTrue([encoded isEqualToString:escapeString], @"Escape failure: %@ != %@", encoded, escapeString);
}

@end
