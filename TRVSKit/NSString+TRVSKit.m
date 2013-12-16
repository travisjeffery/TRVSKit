//
//  NSString+TRVSKit.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/20/13.
//
//

#import "NSString+TRVSKit.h"

@implementation NSString (TRVSKit)

- (NSString *)trvs_stringByEscapingEntities {
    return (__bridge_transfer NSString *)(trvs_createStringByEscapingEntities(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL));
}

- (NSString *)trvs_stringWithLinks {
    NSMutableString *linkedString = [self mutableCopy];
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    [detector enumerateMatchesInString:self options:0 range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop) {
        if (match.URL) {
            NSString *link = [NSString stringWithFormat:@"<a href=\"%@\">%@</a>", match.URL.absoluteString, match.URL.absoluteString];
            [linkedString replaceCharactersInRange:match.range withString:link];
        }
    }];
    return linkedString;
}

- (NSString *)trvs_stringByTrimmingWhitespace {
    return [[self trvs_stringByTrimmingLeadingWhitespaceAndNewlineCharacters]
                  trvs_stringByTrimmingTrailingWhitespaceAndNewlineCharacters];
}

- (NSString *)trvs_stringByJSONSerializingWithKey:(NSString *)key {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@{key:self} options:0 error:NULL] encoding:NSUTF8StringEncoding];
}

#pragma mark - Private

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

CFStringRef trvs_createStringByEscapingEntities(CFAllocatorRef allocator, CFStringRef string, CFDictionaryRef entitiesDictionary) {
    CFMutableStringRef escapedString = CFStringCreateMutable(allocator, 0);
    CFMutableCharacterSetRef startChars = CFCharacterSetCreateMutable(allocator);
    
    CFStringInlineBuffer inlineBuffer;
    CFIndex index = 0;
    CFIndex loc = index;
    CFIndex stringLength = CFStringGetLength(string);
    UniChar uchar;
    
    CFCharacterSetAddCharactersInString(startChars, CFSTR("&<>'\""));
    
    CFStringInitInlineBuffer(string, &inlineBuffer, CFRangeMake(0, stringLength));
    for(index = 0; index < stringLength; index++) {
        uchar = CFStringGetCharacterFromInlineBuffer(&inlineBuffer, index);
        if(CFCharacterSetIsCharacterMember(startChars, uchar)) {
            CFStringRef previousSubstring = CFStringCreateWithSubstring(allocator, string, CFRangeMake(loc, index - loc));
            CFStringAppend(escapedString, previousSubstring);
            CFRelease(previousSubstring);
            switch(uchar) {
                case '&':
                    CFStringAppend(escapedString, CFSTR("&amp;"));
                    break;
                case '<':
                    CFStringAppend(escapedString, CFSTR("&lt;"));
                    break;
                case '>':
                    CFStringAppend(escapedString, CFSTR("&gt;"));
                    break;
                case '\'':
                    CFStringAppend(escapedString, CFSTR("&apos;"));
                    break;
                case '"':
                    CFStringAppend(escapedString, CFSTR("&quot;"));
                    break;
            }
            loc = index + 1;
        }
    }

    CFStringRef remainder = CFStringCreateWithSubstring(allocator, string, CFRangeMake(loc, index - loc));
    if (NULL != remainder) {
        CFStringAppend(escapedString, remainder);
        CFRelease(remainder);
    }
    
    CFRelease(startChars);
    return escapedString;
}

@end
