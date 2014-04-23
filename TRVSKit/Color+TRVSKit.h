//
//  TRVSColor+TRVSKit.h
//  TRVSKit
//
//  Created by Travis Jeffery on 11/1/13.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE

#define TRVSColor UIColor
#define TRVSColor UIColor

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

#define TRVSColor NSColor

#endif

@interface TRVSColor (TRVSKit)

+ (TRVSColor *)trvs_colorWithHexString:(NSString *)hexString;

- (CGFloat)trvs_alpha;
- (CGFloat)trvs_red;
- (CGFloat)trvs_blue;
- (CGFloat)trvs_green;

@end
