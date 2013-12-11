//
//  NSScrollView+TRVSKit.h
//  Tests
//
//  Created by Travis Jeffery on 12/10/13.
//
//

#import <Cocoa/Cocoa.h>

@interface NSScrollView (TRVSKit)

- (BOOL)trvs_isAtBottom;
- (void)trvs_scrollToBottom;

@end
