//
//  NSDictionary+TRVSKit.m
//  Tests
//
//  Created by Travis Jeffery on 4/23/14.
//
//

#import "NSDictionary+TRVSKit.h"

@implementation NSDictionary (TRVSKit)

+ (NSDictionary *)dictionaryByMergingDict1:(NSDictionary *)dict1 dict2:(NSDictionary *)dict2 {
    NSMutableDictionary *result = dict1.mutableCopy;
    
    [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [result setObject:[[dict1 objectForKey: key] dictionaryByMergingWithDictionary:obj] forKey:key];
        } else {
            [result setObject:obj forKey:key];
        }
    }];
    
    return result;
}

- (NSDictionary *)dictionaryByMergingWithDictionary:(NSDictionary *)dict {
    return [self.class dictionaryByMergingDict1:self dict2:dict];
}

@end
