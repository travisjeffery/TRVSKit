//
//  TRVSDelegateProxyTests.m
//  TRVSKit
//
//  Created by Travis Jeffery on 10/8/13.
//
//

#import <XCTest/XCTest.h>
#import "TRVSDelegateProxy.h"

static NSInteger callCount = 0;

@interface TRVSDelegatingObject : NSObject

@property (nonatomic, strong) TRVSDelegateProxy *delegateProxy;
@property (nonatomic, weak) id delegate;

@end

@implementation TRVSDelegatingObject

@end

@interface TRVSDelegate : NSObject

- (void)incrementCallCount;

@end

@implementation TRVSDelegate

- (void)incrementCallCount {
    callCount++;
}

@end


@interface TRVSDelegateProxyTests : XCTestCase

@end

@implementation TRVSDelegateProxyTests

- (void)setUp {
    [super setUp];
    callCount = 0;
}

- (void)testMultipleDelegatesCalled {
    TRVSDelegatingObject *delegator = [[TRVSDelegatingObject alloc] init];
    NSArray *delegates = @[[[TRVSDelegate alloc] init], [[TRVSDelegate alloc] init]];
    delegator.delegateProxy = [[TRVSDelegateProxy alloc] initWithDelegates:delegates];
    delegator.delegate = delegator.delegateProxy;
    [delegator.delegate incrementCallCount];
    XCTAssert(callCount == 2);
}

@end
