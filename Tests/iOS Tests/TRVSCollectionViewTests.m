//
//  TRVSCollectionViewTests.m
//  TRVSKit
//
//  Created by Travis Jeffery on 9/22/13.
//
//

#import <XCTest/XCTest.h>
#import "UICollectionView+TRVSKit.h"

@interface TRVSDataSource : NSObject <UICollectionViewDataSource>

@end

@implementation TRVSDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end

@interface TRVSCollectionViewTests : XCTestCase

@end

@implementation TRVSCollectionViewTests

- (void)testLastIndexPath {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    __strong id<UICollectionViewDataSource> dataSource = [[TRVSDataSource alloc] init];
    collectionView.dataSource = dataSource;
    XCTAssertEqualObjects([NSIndexPath indexPathForItem:4 inSection:3], [collectionView trvs_lastIndexPath]);
}

@end
