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
#import "DWTabBar.h"
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
    [self setUpTabBar];
    [self addDcChildViewContorller];
     self.selectedViewController = [self.viewControllers objectAtIndex:2];
}

//适配iphonex的tabbar(自定义的tabbar在self.view.bounds.size.height-KSafeBarHeight - 49 - 0.5中的必须多减去个任意数值，它的点击范围才能有效，不知道为啥)
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            //此处注意设置 y的值 不要使用屏幕高度 - 49 ，因为还有tabbar的高度 ，用当前tabbarController的View的高度 - 49即可
            view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-KSafeBarHeight - 49 - 0.5, view.frame.size.width, 49);
        }
    }
    // 此处是自定义的View的设置 如果使用了约束 可以不需要设置下面,_bottomView的frame
//    _bottomView.frame = self.tabBar.bounds;
}

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    [self setValue:[[DWTabBar alloc] init] forKey:@"tabBar"];
}


#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"LYShareViewController",
                              MallTitleKey  : @"推广",
                              MallImgKey    : @"推广icon",
                              MallSelImgKey : @"推广icon2"},
                            
                            @{MallClassKey  : @"LYMessageViewController",
                              MallTitleKey  : @"消息",
                              MallImgKey    : @"消息icon",
                              MallSelImgKey : @"消息icon2"},
                            
                            @{MallClassKey  : @"LYWalletViewController",
                              MallTitleKey  : @"",
                              MallImgKey    : @"",
                              MallSelImgKey : @""},
                            
                            @{MallClassKey  : @"LYServiceItemController",
                              MallTitleKey  : @"客服",
                              MallImgKey    : @"客服icon",
                              MallSelImgKey : @"客服icon2"},
                            
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
