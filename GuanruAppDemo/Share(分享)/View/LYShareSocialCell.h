//
//  LYShareSocialCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/12/27.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYShareSocialCell : UITableViewCell

/** 微信按钮点击事件 */
@property (nonatomic, copy) dispatch_block_t weichatBtnClickBlock;
/** 朋友圈按钮点击事件 */
@property (nonatomic, copy) dispatch_block_t friendBtnClickBlock;
/** QQ按钮点击事件 */
@property (nonatomic, copy) dispatch_block_t QQBtnClickBlock;


@end
