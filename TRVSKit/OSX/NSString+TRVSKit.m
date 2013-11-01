//
//  NSString+TRVSKit.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/20/13.
//
//

#import "NSString+TRVSKit.h"

@implementation NSString (TRVSKit)

- (NSString *)trvs_stringByTrimmingWhitespace {
    return [[self trvs_stringByTrimmingLeadingWhitespaceAndNewlineCharacters]
                  trvs_stringByTrimmingTrailingWhitespaceAndNewlineCharacters];
}

- (NSString *)trvs_stringByTrimmingTrailingWhitespaceAndNewlineCharacters {
    return [self trvs_stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trvs_stringByTrimmingLeadingWhitespaceAndNewlineCharacters {
    return [self trvs_stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)trvs_stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location + 1]; // Non-inclusive
}

- (NSString *)trvs_stringByTrimmingLeadingAndTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    return [[self trvs_stringByTrimmingLeadingCharactersInSet:characterSet]
                  trvs_stringByTrimmingTrailingCharactersInSet:characterSet];
}

- (NSString *)trvs_stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}



@end
