//
//  LYShareFriendController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/11/3.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYShareFriendController.h"
// Controllers
#import "LYShareFaceController.h"
// Models
#import "LYDocumentItem.h"
// Views
#import "LYDocumentsCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface LYShareFriendController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//collectionView
@property(nonatomic, strong) UICollectionView *collectionView;
//10个属性数组
@property(nonatomic, strong) NSMutableArray<LYDocumentItem *> *walletArr;

@property(nonatomic, strong) NSString *url;

@end

static NSString *const LYDocumentsCellID = @"LYDocumentsCell";

@implementation LYShareFriendController

#pragma mark - lazyLoad
-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ScreenW / 3, ScreenH / 4);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        //注册
        //cell
        [_collectionView registerClass:[LYDocumentsCell class] forCellWithReuseIdentifier:LYDocumentsCellID];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpData];
    [self setUpAgentIdConnect];
}

#pragma mark - initial
-(void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = DCBGColor;
    self.title = @"推广二维码图案";
}

#pragma mark - 消息数据
-(void)setUpData
{
    _walletArr = [LYDocumentItem mj_objectArrayWithFilename:@"Documents.plist"];
}

#pragma mark - 获取代理商接口
-(void)setUpAgentIdConnect
{
    __weak typeof(self) weakSelf = self;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSDictionary *dic = @{
                          @"agentid": userid,
                          @"rate" : _rateStr
                          };
    [AFOwnerHTTPSessionManager getAddToken:GetAuthQrCodeUrl Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            weakSelf.url = responseObject[@"Data"][@"url"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}



#pragma mark - <UITableViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _walletArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LYDocumentsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYDocumentsCellID forIndexPath:indexPath];
    cell.messageItem = _walletArr[indexPath.row];
    
    return  cell;
}

#pragma mark - <UITableViewDelegate>


#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYDocumentsCell *cell = (LYDocumentsCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    LYShareFaceController *qrcodeVC = [[LYShareFaceController alloc] init];
    qrcodeVC.img = cell.imageNameView.image;
    qrcodeVC.urlString = _url;
    qrcodeVC.integer = indexPath.row;
    [self.navigationController pushViewController:qrcodeVC animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
