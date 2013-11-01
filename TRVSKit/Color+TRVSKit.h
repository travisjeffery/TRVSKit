//
//  PlatformColor+TRVSKit.h
//  TRVSKit
//
//  Created by Travis Jeffery on 11/1/13.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE

#define PlatformColor UIColor

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

#define PlatformColor NSColor

#endif

@interface PlatformColor (TRVSKit)

+ (PlatformColor *)trvs_colorWithHexString:(NSString *)hexString;

- (CGFloat)trvs_alpha;
- (CGFloat)trvs_red;
- (CGFloat)trvs_blue;
- (CGFloat)trvs_green;

@end
