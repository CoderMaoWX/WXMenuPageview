//
//  SecondPageView.h
//  ScrollPageDemo
//
//  Created by Luke on 2019/12/25.
//  Copyright © 2019 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondPageView : UIView

@property (nonatomic, copy) void (^listViewDidScroll)(UIScrollView *);

@end

NS_ASSUME_NONNULL_END
