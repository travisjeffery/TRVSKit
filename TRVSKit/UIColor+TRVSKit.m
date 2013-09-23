//
//  UIColor+TRVSKit.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/20/13.
//
//

#import "UIColor+TRVSKit.h"

@interface NSString (TRVSKitPrivate)

- (NSUInteger)trvs_hexValue;

@end

@implementation NSString (TRVSKitPrivate)

- (NSUInteger)trvs_hexValue {
	NSUInteger result = 0;
	sscanf([self UTF8String], "%x", &result);
	return result;
}

@end

@implementation UIColor (TRVSKit)

+ (UIColor *)trvs_colorWithHexString:(NSString *)hexString {
	if ([hexString hasPrefix:@"#"]) {
		hexString = [hexString substringFromIndex:1];
	} else if ([hexString hasPrefix:@"0x"]) {
		hexString = [hexString substringFromIndex:2];
	}

	NSUInteger length = [hexString length];
	if (length != 3 && length != 6 && length != 8) {
		return nil;
	}

    if (length == 3) {
        NSString *r = [hexString substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hexString substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hexString substringWithRange:NSMakeRange(2, 1)];
        hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
                                               r, r, g, g, b, b];
    } else if (length == 6) {
		hexString = [hexString stringByAppendingString:@"ff"];
	}

	CGFloat red = [[hexString substringWithRange:NSMakeRange(0, 2)] trvs_hexValue] / 255.0f;
	CGFloat green = [[hexString substringWithRange:NSMakeRange(2, 2)] trvs_hexValue] / 255.0f;
	CGFloat blue = [[hexString substringWithRange:NSMakeRange(4, 2)] trvs_hexValue] / 255.0f;
	CGFloat alpha = [[hexString substringWithRange:NSMakeRange(6, 2)] trvs_hexValue] / 255.0f;

	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (CGFloat)trvs_red {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[0];
}


- (CGFloat)trvs_green {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[1];
}


- (CGFloat)trvs_blue {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[2];
}

- (CGFloat)trvs_alpha {
	return CGColorGetAlpha(self.CGColor);
}

@end
