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

    NSBlockOperation *first = [NSBlockOperation blockOperationWithBlock:^{
        XCTAssert(count == 1);
        ++count;
    }];
    
    NSBlockOperation *second = [NSBlockOperation blockOperationWithBlock:^{
        XCTAssert(count == 2);
    }];
    
    [second addDependency:first];
    
    [operationQueue addOperations:@[first, second] waitUntilFinished:NO];
    
    [operationQueue trvs_addFrontMostOperationWithBlock:^{
        ++count;
    }];
    
    [operationQueue setSuspended:NO];
    [operationQueue waitUntilAllOperationsAreFinished];
}

- (void)testFrontMostOperationOverridesExistingDependencies {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount = 1;
    [operationQueue setSuspended:YES];
    TRVSMonitor *monitor = [[TRVSMonitor alloc] initWithExpectedSignalCount:2];
    
    NSBlockOperation *first = [NSBlockOperation blockOperationWithBlock:^{
        [monitor signal];
    }];
    
    NSBlockOperation *second = [NSBlockOperation blockOperationWithBlock:^{
        [monitor signal];
    }];
    
    [second addDependency:first];
    
    [operationQueue trvs_addFrontMostOperation:first];
    [operationQueue trvs_addFrontMostOperation:second];
    
    [operationQueue setSuspended:NO];
    
    XCTAssert([monitor wait]);
}

- (void)testFrontMostOperationAndWaitUntilFinished {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue setSuspended:YES];
    NSDate *startDate = [NSDate date];
    
    NSBlockOperation *waitOperation = [NSBlockOperation blockOperationWithBlock:^{
        sleep(1);
    }];

    [operationQueue setSuspended:NO];
    [operationQueue trvs_addFrontMostOperations:@[waitOperation] waitUntilFinished:YES];
    
    NSTimeInterval timeInteval = [startDate timeIntervalSinceNow];
    XCTAssert(timeInteval <= -1.0);
    
}

@end
