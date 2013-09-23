//
//  UICollectionView+TRVSKit.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/22/13.
//
//

#import "UICollectionView+TRVSKit.h"

@implementation UICollectionView (TRVSKit)

- (NSIndexPath *)trvs_lastIndexPath {
    NSInteger section = [self.dataSource numberOfSectionsInCollectionView:self] - 1;
    NSInteger item = [self.dataSource collectionView:self numberOfItemsInSection:section] - 1;
    return [NSIndexPath indexPathForItem:item inSection:section];
}

- (void)trvs_scrollToBottomAnimated:(BOOL)animated {
    [self scrollToItemAtIndexPath:[self trvs_lastIndexPath] atScrollPosition:UICollectionViewScrollPositionBottom animated:animated];
}

@end
