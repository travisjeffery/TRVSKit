//
//  TRVSOperationQueueTests.m
//  Tests
//
//  Created by Travis Jeffery on 12/11/13.
//
//

#import <XCTest/XCTest.h>
#import "NSOperationQueue+TRVSKit.h"
#import <TRVSMonitor/TRVSMonitor.h>

@interface TRVSOperationQueueTests : XCTestCase

@end

@implementation TRVSOperationQueueTests

- (void)testFrontMostOperationRunsBeforeOthers {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount = 1;
    [operationQueue setSuspended:YES];
    __block NSInteger count = 0;

    TRVSMonitor *monitor = [[TRVSMonitor alloc] initWithExpectedSignalCount:2];
    
    [operationQueue addOperationWithBlock:^{
        XCTAssert(count == 1);
        [monitor signal];
    }];
    
    [operationQueue trvs_addFrontMostOperationWithBlock:^{
        ++count;
        [monitor signal];
    }];
    
    [operationQueue setSuspended:NO];
    
    XCTAssert([monitor wait]);
}

@end
