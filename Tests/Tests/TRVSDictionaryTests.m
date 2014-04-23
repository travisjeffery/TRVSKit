//
//  TRVSDictionaryTests.m
//  Tests
//
//  Created by Travis Jeffery on 4/23/14.
//
//

#import <XCTest/XCTest.h>
#import "NSDictionary+TRVSKit.h"

@interface TRVSDictionaryTests : XCTestCase

@end

@implementation TRVSDictionaryTests

- (void)testMerging {
    NSDictionary *result = @{ @"network": @{ @"wifi": @YES } };
    result = [result dictionaryByMergingWithDictionary:@{ @"network": @{ @"bluetooth": @NO }}];
    NSDictionary *expected = @{ @"network": @{ @"wifi": @YES, @"bluetooth": @NO } };
    
    XCTAssertEqualObjects(expected, result);
}

@end
