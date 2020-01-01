//
//  ViewController.m
//  WXMenuPageView
//
//  Created by Luke on 2019/12/29.
//  Copyright © 2019 Luocheng. All rights reserved.
//
// 一个菜单栏吸顶列表的另一种实现思路例子

#import "ViewController.h"
#import "WXPageHeaderView.h"
#import "WXPageListView.h"
#import "Header.h"

#import "WXMainPageView.h"

@interface ViewController ()<WXMainPageViewDelegate>
@property (nonatomic, strong) WXMainPageView  *menuPageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.menuPageView];
}

- (WXMainPageView *)menuPageView {
    if (!_menuPageView) {
        _menuPageView = [[WXMainPageView alloc] initWithFrame:self.view.bounds];
        _menuPageView.delegate = self;
    }
    return _menuPageView;
}

#pragma mark - <WXMainPageViewDelegate>

- (NSInteger)numberOfMenuForPageView:(WXMainPageView *)pageView {
    return 2;
}

- (UIView<WXPageListViewDelegate> *)pageView:(WXMainPageView *)pageView
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
