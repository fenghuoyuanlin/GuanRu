//
//  LYUpdateTwoCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/31.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYUpdateTwoCell : UITableViewCell
//指示颜色图标
@property(nonatomic, strong) UIView *indicatorView;
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;
//关联
@property(nonatomic, strong) UILabel *infoLabel;
//内容
@property(nonatomic, strong) UILabel *contentLabel;

@end
