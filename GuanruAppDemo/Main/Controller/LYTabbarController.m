//
//  LYTabbarController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYTabbarController.h"
// Controllers
#import "LYNavigationController.h"
// Models

// Views

// Vendors

// Categories

// Others
@interface LYTabbarController ()

@end

#define Selected_tintColor [UIColor colorWithRed:50/ 255.0 green:(112 / 255.0) blue:(229 / 255.0) alpha:1]

#define Normal_tintColor [UIColor colorWithRed:100 green:(100 / 255.0) blue:(100 / 255.0) alpha:1]

#define Normal_titleFont [UIFont systemFontOfSize:13]

@implementation LYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addDcChildViewContorller];
}

#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"LYWalletViewController",
                              MallTitleKey  : @"钱包",
                              MallImgKey    : @"钱包icon",
                              MallSelImgKey : @"钱包icon2"},
                            
                            @{MallClassKey  : @"LYMessageViewController",
                              MallTitleKey  : @"消息",
                              MallImgKey    : @"消息icon",
                              MallSelImgKey : @"消息icon2"},
                            
                            @{MallClassKey  : @"LYMyselfViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"我的icon",
                              MallSelImgKey : @"我的icon2"}
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        vc.navigationItem.title = ([dict[MallTitleKey] isEqualToString:@"首页"] || [dict[MallTitleKey] isEqualToString:@"推广"]) ? nil : dict[MallTitleKey];
        LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        //        item.title = dict[MallTitleKey];//没有标题只有图片的时候
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);//（当只有图片的时候）需要自动调整
        item.title = dict[MallTitleKey];
        //如果不选中的话，用系统默认的是灰色的，如果自己想设置其他的颜色大小可以自行设置哦
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Normal_tintColor, NSFontAttributeName : Normal_titleFont} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Selected_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
