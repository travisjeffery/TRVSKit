//
//  NSString+TRVSKit.h
//  TRVSKit
//
//  Created by Travis Jeffery on 9/20/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (TRVSKit)

- (NSString *)trvs_stringByTrimmingWhitespace;
- (NSString *)trvs_stringByEscapingEntities;
- (NSString *)trvs_stringWithLinks;
- (NSString *)trvs_stringByJSONSerializingWithKey:(NSString *)key;

@end
