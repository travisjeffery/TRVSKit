//
//  TRVSKitTests.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/22/13.
//
//

#import <XCTest/XCTest.h>
// break these out into their own test files
#import "NSString+TRVSKit.h"
#import "UIColor+TRVSKit.h"

@interface TRVSKitTests : XCTestCase

@end

@implementation TRVSKitTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testTrimmingString {
    XCTAssertEqualObjects(@"hello, world", [@"   hello, world\n  " trvs_stringByTrimmingWhitespace]);
}

- (void)testColorWithHexString {
    UIColor *expected = [UIColor colorWithRed:236.f/255.f green:242.f/255.f blue:254.f/255.f alpha:1.f];
    UIColor *actual = [UIColor trvs_colorWithHexString:@"ecf2fe"];
    XCTAssertEqualObjects(actual, expected);
}

@end
