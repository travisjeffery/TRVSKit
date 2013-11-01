//
//  TRVSColorTests.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/22/13.
//
//

#import <XCTest/XCTest.h>
#import "Color+TRVSKit.h"

@interface TRVSColorTests : XCTestCase

@end

@implementation TRVSColorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testColorWithHexString {
    PlatformColor *expected = [PlatformColor colorWithRed:236.f/255.f green:242.f/255.f blue:254.f/255.f alpha:1.f];
    PlatformColor *actual = [PlatformColor trvs_colorWithHexString:@"ecf2fe"];
    XCTAssertEqualObjects(actual, expected);
}

- (void)testColorWithHexStringWithPrefix {
    PlatformColor *expected = [PlatformColor colorWithRed:236.f/255.f green:242.f/255.f blue:254.f/255.f alpha:1.f];
    PlatformColor *actual = [PlatformColor trvs_colorWithHexString:@"#ecf2fe"];
    XCTAssertEqualObjects(actual, expected);
}

- (void)testRGBA {
    CGFloat red = .2f, blue = .3f, green = .4f, alpha = .5f;
    PlatformColor *color = [PlatformColor colorWithRed:red green:green blue:blue alpha:alpha];
    XCTAssertEqual(red, [color trvs_red]);
    XCTAssertEqual(blue, [color trvs_blue]);
    XCTAssertEqual(green, [color trvs_green]);
    XCTAssertEqual(alpha, [color trvs_alpha]);
}

@end
