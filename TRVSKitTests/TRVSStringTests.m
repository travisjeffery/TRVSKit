//
//  TRVSStringTests.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/22/13.
//
//

#import <XCTest/XCTest.h>
#import "NSString+TRVSKit.h"

@interface TRVSStringTests : XCTestCase

@end

@implementation TRVSStringTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testTrimmingString {
    XCTAssertEqualObjects(@"hello, world", [@"   hello, world\n  " trvs_stringByTrimmingWhitespace]);
}

@end
