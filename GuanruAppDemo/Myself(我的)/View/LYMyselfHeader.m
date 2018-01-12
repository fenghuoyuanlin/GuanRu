//
//  LYMyselfHeader.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYMyselfHeader.h"
// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories
#import "UIImage+DCCircle.h"
#import "JKDBModel.h"
// Others

@interface LYMyselfHeader ()



@end

@implementation LYMyselfHeader

#pragma mark - initial
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = RGBA(50, 112, 229, 1.0);
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapClick)]];
    //下次给图片设置圆角时layer.cornerRadius = 30数值直接是数字（用宽度/2显示不出来）
    _titleImgView = [[UIImageView alloc] init];
//    _titleImgView.backgroundColor = [UIColor whiteColor];
    LYUserInfo *userInfo = UserInfoData;
    UIImage *image = ([userInfo.userimage isEqualToString:@"头像"]) ? [UIImage imageNamed:@"头像"] : [DCSpeedy Base64StrToUIImage:userInfo.userimage];
    [_titleImgView setImage:image];
    _titleImgView.userInteractionEnabled = YES;

    [self addSubview:_titleImgView];
    //添加手势
    UITapGestureRecognizer * singleRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [_titleImgView addGestureRecognizer:singleRecognizer];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR14Font;
    _titleLabel.textColor = [UIColor whiteColor];
//    _titleLabel.text = @"游客";
    [self addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = PFR14Font;
    _infoLabel.textColor = [UIColor whiteColor];
//    _infoLabel.text = @"马上登录";
    [self addSubview:_infoLabel];
    
    _indicatorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _indicatorBtn.backgroundColor= [UIColor whiteColor];
    [self addSubview:_indicatorBtn];
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    _titleImgView.layer.cornerRadius = 30;
    _titleImgView.layer.masksToBounds = YES;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleImgView.right).offset(20);
        make.top.equalTo(30);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleImgView.right).offset(20);
        make.top.equalTo(_titleLabel.bottom).offset(15);
    }];
    
    [_indicatorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImgView.centerY);
        make.right.equalTo(-25);
        make.size.equalTo(CGSizeMake(22, 22));
    }];
    
}

#pragma mark - Setter Getter Methods
-(void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    
}

#pragma mark - 点击事件

-(void)viewTapClick
{
    !_bgClickBlock ? : _bgClickBlock();
}

-(void)click:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"点击了图像");
    !_viewClickBlock ? : _viewClickBlock();
}

@end
