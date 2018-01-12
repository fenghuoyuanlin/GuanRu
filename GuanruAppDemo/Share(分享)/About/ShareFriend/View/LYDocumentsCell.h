//
//  LYDocumentsCell.h
//  GuanruAppDemo
//
//  Created by 刘园 on 2018/1/7.
//  Copyright © 2018年 guanrukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYDocumentItem;
@interface LYDocumentsCell : UICollectionViewCell
//消息模型
@property(nonatomic, strong) LYDocumentItem *messageItem;
//图片
@property(nonatomic, strong) UIImageView *imageNameView;

@end
