//
//  SecondPageView.m
//  ScrollPageDemo
//
//  Created by Luke on 2019/12/25.
//  Copyright © 2019 Luke. All rights reserved.
//

#import "SecondPageView.h"
#import "Header.h"

static NSInteger kColumnCount = 2;

@interface SecondPageView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation SecondPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)configMainHeight:(UICollectionView *)collectionView {
    CGRect frame = self.bounds;
    CGFloat height = collectionView.contentSize.height;
    BOOL lessThenMainHeight = (height < frame.size.height);
    
    CGFloat offsetBottom = lessThenMainHeight ? (frame.size.height - height - kMenuKeight) : 0.0;
    collectionView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, offsetBottom, 0);
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 54;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = kRandomColor;
    if (indexPath.item == 0) {//更新底部高度
        [self configMainHeight:collectionView];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = (KScreenWidth - 10 * (kColumnCount + 1) ) / kColumnCount;
    return CGSizeMake(size, size * 1.2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"didSelectItemAtIndexPath==%@", cell);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.listViewDidScroll) {
        self.listViewDidScroll(scrollView);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        UIEdgeInsets offsetEdge = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor lightTextColor];
        _collectionView.contentInset = offsetEdge;
//        _collectionView.scrollIndicatorInsets = offsetEdge
//        _collectionView.showsVerticalScrollIndicator = YES;
        [self configMainHeight:_collectionView];//先预设一个空数据的最大底部高度
        _collectionView.tag = 2019;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}

@end
