//
//  LYMyselfHeader.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYMyselfHeader : UIView

//标题
@property(nonatomic, strong) UILabel *titleLabel;
//内容
@property(nonatomic, strong) UILabel *infoLabel;

//图片
@property(nonatomic, strong) UIImageView *titleImgView;

//指示按钮
@property(nonatomic, strong) UIButton *indicatorBtn;

//图片链接
@property(nonatomic, strong) NSString *imgUrl;

//点击头像回调
@property(nonatomic, copy) dispatch_block_t viewClickBlock;
//点击视图回调
@property(nonatomic, copy) dispatch_block_t bgClickBlock;

@end
