//
//  LYPersonlSettingCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, cellType) {
    cellTypeOne = 0,
    cellTypeTwo = 1,
    cellTypeThree = 2,
    cellTypeFour = 3,
};

@interface LYPersonlSettingCell : UITableViewCell

//标题
@property(nonatomic, strong) UILabel *titleLabel;
//UISwitch
@property(nonatomic, strong) UISwitch *setSwitch;
//图片
@property(nonatomic, strong) UIButton *imgViewBtn;
//内容
@property(nonatomic, strong) UILabel *infoLabel;
//下划线
@property(nonatomic, strong) UIView *cellLine;

//cell类型
@property(nonatomic, assign) cellType type;

@end
