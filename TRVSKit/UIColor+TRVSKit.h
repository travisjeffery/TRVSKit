//
//  UIColor+TRVSKit.h
//  TRVSKit
//
//  Created by Travis Jeffery on 9/20/13.
//
//

@interface UIColor (TRVSKit)

+ (UIColor *)trvs_colorWithHexString:(NSString *)hexString;

- (CGFloat)trvs_alpha;
- (CGFloat)trvs_red;
- (CGFloat)trvs_blue;
- (CGFloat)trvs_green;

@end
