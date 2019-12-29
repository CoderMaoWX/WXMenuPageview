//
//  Header.h
//  WXMenuPageView
//
//  Created by Luke on 2019/12/29.
//  Copyright © 2019 Luocheng. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kMenuKeight      44.0
#define kHeaderHeight  (200.0)

#define kNavBarHeight    44
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kTopBarHeight   (kNavBarHeight + kStatusBarHeight)
#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define KScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kRandomColor    [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]



#endif /* Header_h */
