//
//  NSDictionary+TRVSKit.h
//  Tests
//
//  Created by Travis Jeffery on 4/23/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TRVSKit)

+ (NSDictionary *)trvs_dictionaryByMergingDictionary:(NSDictionary *)dict1 withDictionary:(NSDictionary *)dict2;
- (NSDictionary *)trvs_dictionaryByMergingWithDictionary:(NSDictionary *)dict;

@end
