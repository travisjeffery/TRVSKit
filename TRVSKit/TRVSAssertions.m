//
//  TRVSAssertions.c
//  Tests
//
//  Created by Travis Jeffery on 5/26/14.
//
//

#import <Foundation/Foundation.h>
#import <Expecta/Expecta.h>

void trvs_assertNotificationsObserved(id self, void (^block)(void), id firstNotification, ...) {
    NSCParameterAssert(block != nil);
    NSCParameterAssert(firstNotification != nil);
    
    va_list args;
    va_start(args, firstNotification);
    NSMutableArray *observers = [[NSMutableArray alloc] init];
    __block NSUInteger actualObservedCount = 0;
    NSUInteger expectedObservedCount = 0;
    
    for (id currentNotification = firstNotification; currentNotification != nil; currentNotification = va_arg(args, id)) {
        ++expectedObservedCount;
        
        [observers addObject:[NSNotificationCenter.defaultCenter addObserverForName:currentNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
                              ++actualObservedCount;
        }]];
    }
    
    va_end(args);
    
    block();

    EXP_expect(actualObservedCount).will.equal(expectedObservedCount);
    
    for (id observer in observers) [NSNotificationCenter.defaultCenter removeObserver:observer];
}

void trvs_assertNotificationsNotObserved(id self, void (^block)(void), id firstNotification, ...) {
    NSCParameterAssert(block != nil);
    NSCParameterAssert(firstNotification != nil);
    
    va_list args;
    va_start(args, firstNotification);
    NSMutableArray *observers = [[NSMutableArray alloc] init];
    __block NSUInteger actualObservedCount = 0;
    NSUInteger expectedObservedCount = 0;
    
    for (id currentNotification = firstNotification; currentNotification != nil; currentNotification = va_arg(args, id)) {
        ++expectedObservedCount;
        
        [observers addObject:[NSNotificationCenter.defaultCenter addObserverForName:currentNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            ++actualObservedCount;
        }]];
    }
    
    va_end(args);
    
    block();
    
    EXP_expect(actualObservedCount).willNot.equal(expectedObservedCount);
    
    for (id observer in observers) [NSNotificationCenter.defaultCenter removeObserver:observer];
}
