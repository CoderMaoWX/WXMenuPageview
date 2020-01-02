//
//  WXPageMainView.m
//  WXMenuPageView
//
//  Created by Luke on 2020/1/2.
//  Copyright © 2020 Luocheng. All rights reserved.
//

#import "WXPageMainView.h"
#import "WXPageHeaderView.h"
#import "WXPageListView.h"
#import "Header.h"

@interface WXPageMainView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) WXPageHeaderView   *headerView;
@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, strong) UIScrollView       *touchScrollView;
@property (nonatomic, assign) BOOL               hasStickyMenu;
@end

@implementation WXPageMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.collectionView];
    [self addSubview:self.headerView];
}

#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(numberOfMenuForPageView:)]) {
        return [self.delegate numberOfMenuForPageView:self];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    UIView<WXPageListViewDelegate> *pageView = nil;
    if ([self.delegate respondsToSelector:@selector(pageView:pageForMenuAtIndex:)]) {
       pageView = [self.delegate pageView:self pageForMenuAtIndex:indexPath.item];
    }
    if ([pageView isKindOfClass:[UIView class]]) {
        if ([pageView respondsToSelector:@selector(listViewDidScroll:)]) {
            [pageView listViewDidScroll:self.listViewDidScroll];
        }
        [cell.contentView addSubview:pageView];
    }
    return cell;
}

#pragma mark - <UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *pageView = cell.contentView.subviews.firstObject;
    if (!pageView)return;
    UIScrollView *scrollView = [pageView viewWithTag:2019];
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        self.headerView.mainScrollView = scrollView;

        CGFloat headerViewY = self.headerView.frame.origin.y;
        CGFloat menuMinY = kHeaderHeight - kMenuKeight;
        if (headerViewY <= -menuMinY) {
            if (!self.hasStickyMenu) {
                self.hasStickyMenu = YES;
                [scrollView setContentOffset:CGPointMake(0, -kMenuKeight)];
            }
        } else if (self.touchScrollView) {
            self.hasStickyMenu = NO;
            [scrollView setContentOffset:CGPointMake(0, self.touchScrollView.contentOffset.y)];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell
      forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger page = collectionView.contentOffset.x / collectionView.bounds.size.width;
    if (page < [collectionView numberOfItemsInSection:0]) {
        /// 设置头部主ScrollView事件
        [self setupHeaderMainScrollView:page];
        
        /// 选中指定Menu菜单
        [self selectedPageMenu:page];
    }
}

#pragma mark - <DealwithMainScroll>

- (void)setupHeaderMainScrollView:(NSInteger)page {
    NSIndexPath *path = [NSIndexPath indexPathForRow:page inSection:0];
    UICollectionViewCell *curCell = [self.collectionView cellForItemAtIndexPath:path];
    UIView *pageView = curCell.contentView.subviews.firstObject;
    if (!pageView)return;
    UIScrollView *scrollView = [pageView viewWithTag:2019];
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        self.headerView.mainScrollView = scrollView;
    }
}

- (void)selectedPageMenu:(NSInteger)page {
    NSLog(@"当前菜单栏===%ld", (long)page);
    NSArray *menuBtnArray = self.headerView.subviews;
    for (NSInteger i=0; i<menuBtnArray.count; i++) {
        UIButton *menuBtn = menuBtnArray[i];
        if (![menuBtn isKindOfClass:[UIButton class]]) continue;
        if (menuBtn.tag == page) {
            menuBtn.selected = YES;
        } else {
            menuBtn.selected = NO;
        }
    }
}

- (void)scrollToIndexPage:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
}

- (void(^)(UIScrollView *))listViewDidScroll {
    __weak WXPageMainView *weakSelf = self;
    CGFloat menuMinY = kHeaderHeight - kMenuKeight;
    
    return ^(UIScrollView * scrollView) {
        weakSelf.touchScrollView = scrollView;
        
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat toOffsetY = -(kHeaderHeight + offsetY);
        if (-toOffsetY > 0 && -toOffsetY > menuMinY) {
            toOffsetY = -menuMinY;
        }
        //NSLog(@"offsetY==%.2f",toOffsetY);
        weakSelf.headerView.frame = CGRectMake(0, toOffsetY, KScreenWidth, kHeaderHeight);
        
        scrollView.showsVerticalScrollIndicator = (toOffsetY <= -menuMinY);
        //scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(kMenuKeight, 0, 0, 0);
    };
}

#pragma mark - <InitSubView>

- (WXPageHeaderView *)headerView {
    if (!_headerView) {
        CGRect rect = CGRectMake(0, 0, KScreenWidth, kHeaderHeight);
        _headerView = [[WXPageHeaderView alloc] initWithFrame:rect];
        _headerView.backgroundColor = [UIColor systemPinkColor];
        
        __weak WXPageMainView *weakSelf = self;
        _headerView.touchMenuBlock = ^(NSInteger index) {
            [weakSelf scrollToIndexPage:index];
        };
    }
    return _headerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.alwaysBounceHorizontal = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}

@end
