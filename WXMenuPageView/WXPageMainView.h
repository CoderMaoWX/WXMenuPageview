//
//  WXPageMainView.h
//  WXMenuPageView
//
//  Created by Luke on 2020/1/2.
//  Copyright © 2020 Luocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXPageMainView;

@protocol WXPageListViewDelegate <NSObject>
@required
- (void)listViewDidScroll:(void(^)(UIScrollView *))didScrollBlock;
@end


@protocol WXMainPageViewDelegate <NSObject>
@required

- (NSInteger)numberOfMenuForPageView:(WXPageMainView *)pageView;

- (UIView<WXPageListViewDelegate> *)pageView:(WXPageMainView *)pageView pageForMenuAtIndex:(NSInteger)index;

@end


@interface WXPageMainView : UIView

@property (nonatomic, weak) id<WXMainPageViewDelegate> delegate;

@property (nonatomic, copy) void (^headerRefreshingBlock)(void);

- (void)endHeaderRefreshing;

@end

