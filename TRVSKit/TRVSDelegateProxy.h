//
//  TRVSDelegateProxy.h
//  TRVSKit
//
//  Created by Travis Jeffery on 10/7/13.
//
//

#import <Foundation/Foundation.h>

@interface TRVSDelegateProxy : NSProxy

@property (nonatomic, copy, readonly) NSArray *delegates;

- (instancetype)initWithDelegates:(NSArray *)delegates;

@end
