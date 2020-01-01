//
//  WXPageListView.h
//  ScrollPageDemo
//
//  Created by Luke on 2019/12/25.
//  Copyright © 2019 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXPageListView : UIView

@property (nonatomic, copy) void (^listViewDidScroll)(UIScrollView *);

- (instancetype)initWithFrame:(CGRect)frame
                  columnCount:(NSInteger)column;

@end
