//
//  NSScrollView+TRVSKit.m
//  Tests
//
//  Created by Travis Jeffery on 12/10/13.
//
//

#import "NSScrollView+TRVSKit.h"

@implementation NSScrollView (TRVSKit)

- (BOOL)trvs_isAtBottom {
    NSScroller *scroller = self.verticalScroller;
    return [scroller knobProportion] == 1.0 || [scroller floatValue] == 1.0;
}

- (void)trvs_scrollToBottom {
    [self scrollToEndOfDocument:nil];
}


@end
