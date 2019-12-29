//
//  PageHeaderView.h
//  ScrollPageDemo
//
//  Created by 610582 on 2019/12/28.
//  Copyright © 2019 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageHeaderView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, copy) void (^touchMenuBlock)(UIButton *);

@end

NS_ASSUME_NONNULL_END
