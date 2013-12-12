//
//  NSOperationQueue+TRVSKit.m
//  Tests
//
//  Created by Travis Jeffery on 12/11/13.
//
//

#import "NSOperationQueue+TRVSKit.h"

@implementation NSOperationQueue (TRVSKit)

- (void)trvs_addFrontMostOperation:(NSOperation *)operation {
    [self setupDependenciesForFrontMostOperation:operation];
    [self addOperation:operation];
}

- (void)trvs_addFrontMostOperations:(NSArray *)operations waitUntilFinished:(BOOL)wait {
    for (NSOperation *operation in operations) [self setupDependenciesForFrontMostOperation:operation];    
    [self addOperations:operations waitUntilFinished:wait];
}

- (void)trvs_addFrontMostOperationWithBlock:(void (^)(void))block {
    [self trvs_addFrontMostOperation:[NSBlockOperation blockOperationWithBlock:block]];
}

#pragma mark - Private

- (void)setupDependenciesForFrontMostOperation:(NSOperation *)frontMostOperation {
    @synchronized(self) {
        BOOL isSuspended = [self isSuspended];
        [self setSuspended:YES];
        for (NSOperation *operation in self.operations)
            if (!operation.isExecuting) [operation addDependency:frontMostOperation];
        [self setSuspended:isSuspended];
    }
}

@end
