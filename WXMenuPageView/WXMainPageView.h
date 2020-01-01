//
//  WXMainPageView.h
//  WXMenuPageView
//
//  Created by Luke on 2020/1/2.
//  Copyright © 2020 Luocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXMainPageView;

@protocol WXPageListViewDelegate <NSObject>
@required
- (void)listViewDidScroll:(void(^)(UIScrollView *))didScrollBlock;
@end


@protocol WXMainPageViewDelegate <NSObject>
@required

- (NSInteger)numberOfMenuForPageView:(WXMainPageView *)pageView;

- (UIView<WXPageListViewDelegate> *)pageView:(WXMainPageView *)pageView pageForMenuAtIndex:(NSInteger)index;

@end


@interface WXMainPageView : UIView

@property (nonatomic, weak) id<WXMainPageViewDelegate> delegate;

@end

