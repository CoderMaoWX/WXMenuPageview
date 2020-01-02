//
//  WXPageListView.h
//  ScrollPageDemo
//
//  Created by Luke on 2019/12/25.
//  Copyright © 2019 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXPageMainView.h"

@interface WXPageListView : UIView<WXPageListViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame
                  columnCount:(NSInteger)column;

@end
