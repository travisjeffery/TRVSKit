//
//  TRVSDelegateProxy.m
//  TRVSKit
//
//  Created by Travis Jeffery on 10/7/13.
//
//

#import "TRVSDelegateProxy.h"

@interface TRVSDelegateProxy ()

@property (nonatomic, copy, readwrite) NSArray *delegates;

@end

@implementation TRVSDelegateProxy

- (instancetype)initWithDelegates:(NSArray *)delegates {
    self = [self init];
    if (self) {
        self.delegates = delegates;
    }
    return self;
}

- (instancetype)init {
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    __block NSMethodSignature *signature;
    [self.delegates enumerateObjectsUsingBlock:^(id delegate, NSUInteger idx, BOOL *stop) {
        signature = [[delegate class] instanceMethodSignatureForSelector:sel];
        if (signature) *stop = YES;
    }];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *returnType = [NSString stringWithCString:invocation.methodSignature.methodReturnType encoding:NSUTF8StringEncoding];
    BOOL voidReturnType = [returnType isEqualToString:@"v"];
    
    [self.delegates enumerateObjectsUsingBlock:^(id delegate, NSUInteger idx, BOOL *stop) {
        if ([delegate respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:delegate];
            if (!voidReturnType) *stop = YES;
        }
    }];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    __block BOOL responds = NO;
    [self.delegates enumerateObjectsUsingBlock:^(id delegate, NSUInteger idx, BOOL *stop) {
        if ([delegate respondsToSelector:aSelector]) {
            responds = YES;
            *stop = YES;
        }
    }];
    return responds;
}

@end
