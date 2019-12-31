//
//  PageHeaderView.m
//  ScrollPageDemo
//
//  Created by 610582 on 2019/12/28.
//  Copyright © 2019 Luke. All rights reserved.
//

#import "PageHeaderView.h"
#import "Header.h"

@interface PageHeaderView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIImageView       *headerImageView;
@property (nonatomic, strong) UIButton          *tmpMenuBtn;
@end

@implementation PageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.tableView];
        
        [self addSubview:self.headerImageView];
        self.tmpMenuBtn = [self createButton:0];
        self.tmpMenuBtn.selected = YES;
        [self addSubview:self.tmpMenuBtn];
        [self addSubview:[self createButton:1]];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = kRandomColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath==%ld", indexPath.row);
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        _tableView.tableFooterView = [UIView new];
        _tableView.exclusiveTouch = YES;
        _tableView.tableFooterView = self.headerImageView;
        _tableView.scrollEnabled = NO;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        CGRect rect = CGRectMake(0, 0, KScreenWidth, kHeaderHeight - kMenuKeight);
        _headerImageView = [[UIImageView alloc] initWithFrame:rect];
        _headerImageView.backgroundColor = [UIColor systemPinkColor];
        _headerImageView.image = [UIImage imageNamed:@"points_banner"];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [_headerImageView addGestureRecognizer:tap];
    }
    return _headerImageView;
}

- (void)tapImageView:(UIGestureRecognizer *)gesture {
    NSLog(@"tapImageView==%@", gesture.view);
}

- (UIButton *)createButton:(NSInteger)index {
    CGFloat width = KScreenWidth/2;
    CGFloat y = CGRectGetMaxY(self.headerImageView.frame);
    CGRect rect = CGRectMake(index * width, y, width-1, kMenuKeight);
    NSString *title = (index == 0) ? @"Menu1" : @"Menu2";
    
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
    [button addTarget:self action:@selector(menuAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = index;
    return button;
}

- (void)menuAction:(UIButton *)button {
    self.tmpMenuBtn.selected = NO;
    if (self.touchMenuBlock) {
        self.touchMenuBlock(button.tag);
    }
    button.selected = YES;
    self.tmpMenuBtn = button;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIPanGestureRecognizer *panGesture = self.mainScrollView.panGestureRecognizer;
    if (panGesture) {
        if (point.y < kHeaderHeight) {
            [self removeGestureRecognizer:panGesture];
            [self addGestureRecognizer:panGesture];
        } else {
            [self.mainScrollView removeGestureRecognizer:panGesture];
            [self.mainScrollView addGestureRecognizer:panGesture];
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
