//
//  WXPageHeaderView.h
//  ScrollPageDemo
//
//  Created by 610582 on 2019/12/28.
//  Copyright © 2019 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXPageHeaderView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, copy) void (^touchMenuBlock)(NSInteger);

@end

NS_ASSUME_NONNULL_END
