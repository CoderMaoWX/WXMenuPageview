//
//  Header.h
//  WXMenuPageView
//
//  Created by Luke on 2019/12/29.
//  Copyright © 2019 Luocheng. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kMenuKeight      44.0
#define kHeaderHeight    (200.0)

#define kNavBarHeight    44
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kTopBarHeight   (kNavBarHeight + kStatusBarHeight)
#define KScreenHeight   [UIScreen mainScreen].bounds.size.height
#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kRandomColor    [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]



#endif /* Header_h */



//#import "ViewController.h"
//#import "WXPageHeaderView.h"
//#import "WXPageListView.h"
//#import "Header.h"
//
//@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
//@property (nonatomic, strong) WXPageHeaderView   *headerView;
//@property (nonatomic, strong) WXPageListView     *firstPageView;
//@property (nonatomic, strong) WXPageListView     *secondPageView;
//@property (nonatomic, strong) UICollectionView   *collectionView;
//@property (nonatomic, strong) UIScrollView       *touchScrollView;
//@property (nonatomic, assign) BOOL               hasStickyMenu;
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//
//    [self.view addSubview:self.collectionView];
//    [self.view addSubview:self.headerView];
//}
//
//#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
//- (NSInteger)collectionView:(UICollectionView *)collectionView
//     numberOfItemsInSection:(NSInteger)section {
//    return 2;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return collectionView.bounds.size;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
//                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
//    cell.contentView.backgroundColor = kRandomColor;
//    if (indexPath.item == 0) {
//        [cell.contentView addSubview:self.firstPageView];
//    } else {
//        [cell.contentView addSubview:self.secondPageView];
//    }
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView
//       willDisplayCell:(UICollectionViewCell *)cell
//    forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIView *pageView = cell.contentView.subviews.firstObject;
//    if (!pageView)return;
//    UIScrollView *scrollView = [pageView viewWithTag:2019];
//    if ([scrollView isKindOfClass:[UIScrollView class]]) {
//        self.headerView.mainScrollView = scrollView;
//
//        CGFloat headerViewY = self.headerView.frame.origin.y;
//        CGFloat menuMinY = kHeaderHeight - kMenuKeight;
//        if (headerViewY <= -menuMinY) {
//            if (!self.hasStickyMenu) {
//                self.hasStickyMenu = YES;
//                [scrollView setContentOffset:CGPointMake(0, -kMenuKeight)];
//            }
//        } else if (self.touchScrollView) {
//            self.hasStickyMenu = NO;
//            [scrollView setContentOffset:CGPointMake(0, self.touchScrollView.contentOffset.y)];
//        }
//    }
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell
//        forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger page = collectionView.contentOffset.x / collectionView.bounds.size.width;
//    if (page < [collectionView numberOfItemsInSection:0]) {
//        /// 设置头部主ScrollView事件
//        [self setupHeaderMainScrollView:page];
//
//        /// 选中指定Menu菜单
//        [self selectedPageMenu:page];
//    }
//}
//
//- (void)setupHeaderMainScrollView:(NSInteger)page {
//    NSIndexPath *path = [NSIndexPath indexPathForRow:page inSection:0];
//    UICollectionViewCell *curCell = [self.collectionView cellForItemAtIndexPath:path];
//    UIView *pageView = curCell.contentView.subviews.firstObject;
//    if (!pageView)return;
//    UIScrollView *scrollView = [pageView viewWithTag:2019];
//    if ([scrollView isKindOfClass:[UIScrollView class]]) {
//        self.headerView.mainScrollView = scrollView;
//    }
//}
//
//- (void)selectedPageMenu:(NSInteger)page {
//    NSLog(@"当前菜单栏===%ld", (long)page);
//    NSArray *menuBtnArray = self.headerView.subviews;
//    for (NSInteger i=0; i<menuBtnArray.count; i++) {
//        UIButton *menuBtn = menuBtnArray[i];
//        if (![menuBtn isKindOfClass:[UIButton class]]) continue;
//        if (menuBtn.tag == page) {
//            menuBtn.selected = YES;
//        } else {
//            menuBtn.selected = NO;
//        }
//    }
//}
//
//- (void)scrollToIndexPage:(NSInteger)index {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
//}
//
//- (void(^)(UIScrollView *))listViewDidScroll {
//    __weak ViewController *weakSelf = self;
//    CGFloat menuMinY = kHeaderHeight - kMenuKeight;
//
//    return ^(UIScrollView * scrollView) {
//        weakSelf.touchScrollView = scrollView;
//
//        CGFloat offsetY = scrollView.contentOffset.y;
//        CGFloat toOffsetY = -(kHeaderHeight + offsetY);
//        if (-toOffsetY > 0 && -toOffsetY > menuMinY) {
//            toOffsetY = -menuMinY;
//        }
//        //NSLog(@"offsetY==%.2f",toOffsetY);
//        weakSelf.headerView.frame = CGRectMake(0, toOffsetY, KScreenWidth, kHeaderHeight);
//
//        scrollView.showsVerticalScrollIndicator = (toOffsetY <= -menuMinY);
//        //scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(kMenuKeight, 0, 0, 0);
//    };
//}
//
//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        flowLayout.minimumLineSpacing = 0;
//        flowLayout.minimumInteritemSpacing = 0;
//
//        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
//        _collectionView.backgroundColor = [UIColor systemBlueColor];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        _collectionView.pagingEnabled = YES;
//        _collectionView.bounces = NO;
//        _collectionView.showsVerticalScrollIndicator = NO;
//        _collectionView.showsHorizontalScrollIndicator = YES;
//        _collectionView.alwaysBounceHorizontal = NO;
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
//    }
//    return _collectionView;
//}
//
//- (WXPageHeaderView *)headerView {
//    if (!_headerView) {
//        CGRect rect = CGRectMake(0, 0, KScreenWidth, kHeaderHeight);
//        _headerView = [[WXPageHeaderView alloc] initWithFrame:rect];
//        _headerView.backgroundColor = [UIColor systemPinkColor];
//
//        __weak ViewController *weakSelf = self;
//        _headerView.touchMenuBlock = ^(NSInteger index) {
//            [weakSelf scrollToIndexPage:index];
//        };
//    }
//    return _headerView;
//}
//
//- (WXPageListView *)firstPageView {
//    if (!_firstPageView) {
//        CGRect rect = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopBarHeight);
//        _firstPageView = [[WXPageListView alloc] initWithFrame:rect columnCount:3];
//        _firstPageView.listViewDidScroll = self.listViewDidScroll;
//    }
//    return _firstPageView;
//}
//
//- (WXPageListView *)secondPageView {
//    if (!_secondPageView) {
//        _secondPageView = [[WXPageListView alloc] initWithFrame:self.firstPageView.bounds columnCount:2];
//        _secondPageView.listViewDidScroll = self.listViewDidScroll;
//    }
//    return _secondPageView;
//}
//
//@end
