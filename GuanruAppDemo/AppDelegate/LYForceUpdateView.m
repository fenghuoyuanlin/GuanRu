//
//  LYForceUpdateView.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/9.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYForceUpdateView.h"

@implementation LYForceUpdateView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
        
        [self addSubview:self.upDateBtn];
        [self.upDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(ScreenW / 1.5, ScreenW / 3 * 3.5));
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY);
        }];

    }
    
    return self;
}
/**
 *  强更图片按钮
 */
- (UIImageView *)upDateBtn{
    if(!_upDateBtn){
        _upDateBtn = [[UIImageView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upDateApp)];
        
        [_upDateBtn addGestureRecognizer:tap];
        
        _upDateBtn.userInteractionEnabled = YES;
    }
    return _upDateBtn;
}

- (void)upDateApp{
    
    NSLog(@"upDateApp");
    
    //更新
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", _appleID]];
    [[UIApplication sharedApplication] openURL:url];
    
}

@end
