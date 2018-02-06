//
//  LYLinkCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYLinkCell.h"
// Controllers

// Models
#import "LYLinkItem.h"
// Views

// Vendors

// Categories

// Others

@interface LYLinkCell ()
//名称
@property(nonatomic, strong) UILabel *titleLabel;
//百分比
@property(nonatomic, strong) UILabel *percentLabel;
//间隔线
@property(nonatomic, strong) UIView *line;
//打开按钮
@property(nonatomic, strong) UIButton *openBtn;
//删除按钮
@property(nonatomic, strong) UIButton *delegateBtn;


@end

@implementation LYLinkCell

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
    _titleLabel.font = PFR18Font;
    [self addSubview:_titleLabel];
    
    _commenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commenBtn setImage:[UIImage imageNamed:@"商户"] forState:0];
//    [_commenBtn setTitle:@"普通商户" forState:0];
    [_commenBtn setTitleColor:RGB(132, 132, 132) forState:0];
    _commenBtn.titleLabel.font = PFR14Font;
    [self addSubview:_commenBtn];
    
    _percentLabel = [[UILabel alloc] init];
    _percentLabel.font = [UIFont systemFontOfSize:32.0];
    [self addSubview:_percentLabel];
    
    _line = [UIView new];
    _line.backgroundColor = RGB(231, 231, 231);
    [self addSubview:_line];
    
    _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openBtn setTitle:@"查看二维码" forState:0];
    [_openBtn setTitleColor:RGB(250, 183, 46) forState:0];
    _openBtn.titleLabel.font = PFR14Font;
    [self addSubview:_openBtn];
    
    [_openBtn addTarget:self action:@selector(openBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delegateBtn setImage:[UIImage imageNamed:@"删除"] forState:0];
    [self addSubview:_delegateBtn];
    
    [_delegateBtn addTarget:self action:@selector(delegateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.width.equalTo(1);
        make.top.equalTo(DCMargin);
        make.height.equalTo(self.dc_height - 2*DCMargin);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.top);
        make.centerX.equalTo(self.centerX).offset(-self.dc_width / 4);
    }];
    
    [_commenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(DCMargin);
        make.centerX.equalTo(_titleLabel.centerX);
        make.size.equalTo(CGSizeMake(100, 30));
    }];
    
    [_percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.top);
        make.centerX.equalTo(self.centerX).offset(self.dc_width / 4);
    }];
    
    
    [_delegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.size.equalTo(CGSizeMake(25, 25));
    }];
    
    [_openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_percentLabel.bottom).offset(3);
        make.centerX.equalTo(_percentLabel.centerX);
        make.size.equalTo(CGSizeMake(100, 30));
    }];
    
    
}

#pragma mark - Setter Getter Methods

-(void)setLinkItem:(LYLinkItem *)linkItem
{
    _linkItem = linkItem;
    _titleLabel.text = linkItem.shop_name;
    NSString *str = [NSString stringWithFormat:@"%.2f", [linkItem.shoprate doubleValue] * 100];
    NSString *sttt = [DCSpeedy changeFloat:str];
    _percentLabel.text = [NSString stringWithFormat:@"%@%@", sttt, @"%"];
}

#pragma mark - 点击事件

-(void)openBtnClick
{
    !_openClickBlock  ? : _openClickBlock();
}

-(void)delegateBtnClick
{
    !_delegateBtnClickBlock  ? : _delegateBtnClickBlock();
}

@end
