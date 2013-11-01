//
//  UICollectionView+TRVSKit.h
//  TRVSKit
//
//  Created by Travis Jeffery on 9/22/13.
//
//

@interface UICollectionView (TRVSKit)

- (NSIndexPath *)trvs_lastIndexPath;
- (void)trvs_scrollToBottomAnimated:(BOOL)animated;

@end
