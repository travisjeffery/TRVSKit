//
//  NSDictionary+TRVSKit.m
//  Tests
//
//  Created by Travis Jeffery on 4/23/14.
//
//

#import "NSDictionary+TRVSKit.h"

@implementation NSDictionary (TRVSKit)

+ (NSDictionary *)trvs_dictionaryByMergingDictionary:(NSDictionary *)dict1 withDictionary:(NSDictionary *)dict2 {
    NSMutableDictionary *result = dict1.mutableCopy;
    
    [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [result setObject:[[dict1 objectForKey: key] trvs_dictionaryByMergingWithDictionary:obj] forKey:key];
        } else {
            [result setObject:obj forKey:key];
        }
    }];
    
    return result;
}

- (NSDictionary *)trvs_dictionaryByMergingWithDictionary:(NSDictionary *)dict {
    return [self.class trvs_dictionaryByMergingDictionary:self withDictionary:dict];
}

@end
