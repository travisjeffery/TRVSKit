//
//  NSOperationQueue+TRVSKit.h
//  Tests
//
//  Created by Travis Jeffery on 12/11/13.
//
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (TRVSKit)

- (void)trvs_addFrontMostOperation:(NSOperation *)operation;
- (void)trvs_addFrontMostOperations:(NSArray *)operations waitUntilFinished:(BOOL)wait;
- (void)trvs_addFrontMostOperationWithBlock:(void (^)(void))block;

@end
