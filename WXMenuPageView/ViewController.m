//
//  ViewController.m
//  WXMenuPageView
//
//  Created by Luke on 2019/12/29.
//  Copyright © 2019 Luocheng. All rights reserved.
//
// 一个菜单栏吸顶列表的另一种实现思路例子

#import "ViewController.h"
#import "WXPageListView.h"
#import "Header.h"
#import "MJRefresh.h"

#import "WXPageMainView.h"

@interface ViewController ()<WXMainPageViewDelegate>
@property (nonatomic, strong) WXPageMainView  *menuPageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.menuPageView];
}

- (WXPageMainView *)menuPageView {
    if (!_menuPageView) {
        _menuPageView = [[WXPageMainView alloc] initWithFrame:self.view.bounds];
        _menuPageView.delegate = self;
        
        __weak ViewController *weakSelf = self;
        _menuPageView.headerRefreshingBlock = ^(void){
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"ViewController===头部刷新完毕");
                [weakSelf.menuPageView endHeaderRefreshing];
            });
        };
    }
    return _menuPageView;
}

#pragma mark - <WXMainPageViewDelegate>

- (NSInteger)numberOfMenuForPageView:(WXPageMainView *)pageView {
    return 2;
}

- (UIView<WXPageListViewDelegate> *)pageView:(WXPageMainView *)pageView
                          pageForMenuAtIndex:(NSInteger)index
{
    CGRect rect = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopBarHeight);
    if (index == 0) {
        WXPageListView *firstPageView = [[WXPageListView alloc] initWithFrame:rect columnCount:3];
        return firstPageView;
        
    } else {
        WXPageListView *secondPageView = [[WXPageListView alloc] initWithFrame:rect columnCount:2];
        return secondPageView;
    }
}

@end
