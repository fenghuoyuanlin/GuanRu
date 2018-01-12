//
//  LYPersonlSettingCell.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/26.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYPersonlSettingCell.h"
// Controllers

// Models

// Views

// Vendors
#import "UIImage+DCCircle.h"
// Categories

// Others

@implementation LYPersonlSettingCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.textColor = [UIColor lightGrayColor];
    _infoLabel.font = PFR14Font;
    
    _cellLine = [[UIView alloc] init];
    _cellLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self addSubview:_cellLine];
    
    _setSwitch = [[UISwitch alloc] init];
    [_setSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    _setSwitch.onTintColor = [UIColor redColor];//在oneSwitch开启的状态显示的颜色 默认是blueColor
    //    _setSwitch.tintColor = [UIColor lightGrayColor];//设置关闭状态的颜色
    //    _setSwitch.thumbTintColor = [UIColor whiteColor];//设置开关上左右滑动的小圆点的颜色
    
    _imgViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [DCSpeedy dc_setUpBezierPathCircularLayerWith:_imgViewBtn  :CGSizeMake(_imgViewBtn.dc_width * 0.5, _imgViewBtn.dc_width * 0.5)];
    _imgViewBtn.userInteractionEnabled = NO;
    
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(DCMargin);
        make.centerY.equalTo(self);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.left);
        make.right.equalTo(0);
        make.height.equalTo(1);
        make.bottom.equalTo(0);
    }];
    
    if (_type == cellTypeOne)
    {
        [self addSubview:_setSwitch];
        [_setSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-DCMargin);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(60, 35));
        }];
    }
    else if (_type == cellTypeTwo)
    {
        [self addSubview:_imgViewBtn];
        [_imgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(- 4 * DCMargin);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(50, 50));
        }];
        
        [_imgViewBtn setImage:[UIImage dc_circleImage:@"icon"] forState:UIControlStateNormal];
        //如果在cell中设置Button的圆角此方法必须在自动布局中设置才有效！！！
        [DCSpeedy dc_setUpBezierPathCircularLayerWith:_imgViewBtn  :CGSizeMake(_imgViewBtn.dc_width * 0.5, _imgViewBtn.dc_width * 0.5)];
    }
    else if (_type == cellTypeThree)
    {
        [self addSubview:_imgViewBtn];
        [_imgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(- 4 * DCMargin);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
    }
    else if (_type == cellTypeFour)
    {
        [self addSubview:_infoLabel];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(-15);
        }];
    }
}

#pragma mark - Setter Getter methods


#pragma mark - 点击switch事件
-(void)switchAction:(UISwitch *)sender
{
    NSLog(@"%@", sender.isOn ? @"ON" : @"OFF");
}

@end
