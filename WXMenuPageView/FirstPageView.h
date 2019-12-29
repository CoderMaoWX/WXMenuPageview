//
//  FirstPageView.h
//  ScrollPageDemo
//
//  Created by Luke on 2019/12/25.
//  Copyright © 2019 Luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstPageView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) void (^listViewDidScroll)(UIScrollView *);

@end
