//
//  NSDictionary+TRVSKit.h
//  Tests
//
//  Created by Travis Jeffery on 4/23/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TRVSKit)

+ (NSDictionary *)dictionaryByMergingDict1:(NSDictionary *)dict1 dict2:(NSDictionary *)dict2;
- (NSDictionary *)dictionaryByMergingWithDictionary:(NSDictionary *)dict;

@end
