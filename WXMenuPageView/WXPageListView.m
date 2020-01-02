//
//  WXPageListView.m
//  ScrollPageDemo
//
//  Created by Luke on 2019/12/25.
//  Copyright © 2019 Luke. All rights reserved.
//

#import "WXPageListView.h"
#import "Header.h"
#import "MJRefresh.h"

//static NSInteger kColumnCount = 3;

@interface WXPageListView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger kColumnCount;
@property (nonatomic, copy) void (^listViewDidScroll)(UIScrollView *);
@end

@implementation WXPageListView

- (instancetype)initWithFrame:(CGRect)frame columnCount:(NSInteger)column {
    self = [super initWithFrame:frame];
    if (self) {
        self.kColumnCount = column;
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
}

- (void)configMainHeight:(UICollectionView *)collectionView {
    CGRect frame = self.bounds;
    CGFloat height = collectionView.contentSize.height;
    BOOL lessThenMainHeight = (height < frame.size.height);
    
    CGFloat offsetBottom = lessThenMainHeight ? (frame.size.height - height - kMenuKeight) : 0.0;
    collectionView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, offsetBottom, 0);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 54;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = kRandomColor_A(0.3);
    if (indexPath.item == 0) {//更新底部高度
        [self configMainHeight:collectionView];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kColumnCount == 0) { self.kColumnCount = 3; }
    CGFloat size = (KScreenWidth - 10 * (self.kColumnCount + 1) ) / self.kColumnCount;
    return CGSizeMake(size, size * 1.2);
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"didSelectItemAtIndexPath==%@", cell);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.listViewDidScroll) {
        self.listViewDidScroll(scrollView);
    }
}

#pragma mark - <WXPageListViewDelegate>

- (void)listViewDidScroll:(void(^)(UIScrollView *))didScrollBlock {
    self.listViewDidScroll = didScrollBlock;
}

#pragma mark - <InitSubView>

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        UIEdgeInsets offsetEdge = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = offsetEdge;
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
