//
//  LYPaymentBaseController.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPaymentBaseController : UIViewController

//移除控制器
- (void)removeChildVc:(UIViewController *)childVc;
//添加控制器
- (void)addChildVc:(UIViewController *)childVc;

@end
