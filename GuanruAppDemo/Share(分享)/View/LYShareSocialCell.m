//
//  LYShareSocialCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYShareSocialCell.h"
// Controllers

// Models
#import "LYShareItem.h"
// Views

// Vendors
#import "LYUIBLButton.h"
// Categories

// Others

@interface LYShareSocialCell ()
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//分享按钮
@property(nonatomic, strong) LYUIBLButton *weichatBtn;

@property(nonatomic, strong) LYUIBLButton *friendBtn;

@property(nonatomic, strong) LYUIBLButton *qqBtn;

@end


@implementation LYShareSocialCell

#pragma mark - inital
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    _titleLabel.text = @"立即分享 下载赚钱";
    [self addSubview:_titleLabel];
    
    _weichatBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_weichatBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [_weichatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_weichatBtn setTitle:@"微信" forState:0];
    _weichatBtn.titleLabel.font = PFR16Font;
    _weichatBtn.tag = 0;
    [self addSubview:_weichatBtn];
    
    [_weichatBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _friendBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_friendBtn setImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
    [_friendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_friendBtn setTitle:@"朋友圈" forState:0];
    _friendBtn.titleLabel.font = PFR16Font;
    _friendBtn.tag = 1;
    [self addSubview:_friendBtn];
    
    [_friendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _qqBtn = [LYUIBLButton buttonWithType:UIButtonTypeCustom];
    [_qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [_qqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_qqBtn setTitle:@"QQ" forState:0];
    _qqBtn.titleLabel.font = PFR16Font;
    _qqBtn.tag = 2;
    [self addSubview:_qqBtn];
    
    [_qqBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 布局

//对这个cell的真实有效部分进行设置
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= DCMargin;
    frame.origin.y += DCMargin;
    
    frame.origin.x += DCMargin;
    frame.size.width -=  2 * DCMargin;
    
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(DCMargin);
    }];
    
    
    [_friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(20);
        make.centerX.equalTo(self.centerX);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [_weichatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_friendBtn.left).offset(-self.dc_width / 6);
        make.centerY.equalTo(_friendBtn.centerY);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_friendBtn.right).offset(self.dc_width / 6);
        make.centerY.equalTo(_friendBtn.centerY);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    
}

#pragma mark - Setter Getter Methods

#pragma mark - 点击事件
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        !_weichatBtnClickBlock  ? : _weichatBtnClickBlock();
    }
    else if (sender.tag == 1)
    {
        !_friendBtnClickBlock  ? : _friendBtnClickBlock();
    }
    else if (sender.tag == 2)
    {
        !_QQBtnClickBlock  ? : _QQBtnClickBlock();
    }
}

@end
