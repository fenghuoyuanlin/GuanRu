//
//  LYWalletViewController.m
//  GuanruAppDemo
//
//  Created by 刘园 on 2017/10/23.
//  Copyright © 2017年 guanrukeji. All rights reserved.
//

#import "LYWalletViewController.h"
// Controllers
#import "LYMyAccountController.h"
#import "LYMyRateController.h"
#import "LYUpdateController.h"
#import "LYCreditCardController.h"
#import "LYMoreServiceController.h"
#import "LYMyProfitController.h"
#import "LYMerchantController.h"
#import "LYBillSearchController.h"
#import "LYCreditLoansController.h"
#import "LYDataCenterController.h"
#import "LYLinkController.h"
#import "LYQrcodePayController.h"
#import "LYNavigationController.h"
#import "LYWalletServiceController.h"
#import "LYFillDataController.h"
#import "LYLoginViewController.h"
#import "LYEnterViewController.h"
#import "LYWalletServiceController.h"
#import "LYPaymentDetailController.h"
#import "LYShareViewController.h"
#import "LYCreditLoansController.h"
// Models
#import "LYWalletItem.h"
#import "LYMoreItem.h"
#import "LYCardItem.h"
// Views
#import "LYExceedCell.h"
#import "LYBottomCell.h"
#import "LYCycleCell.h"
#import "LYMoreItemCell.h"
#import "LYWalletHeader.h"
#import "LYTopLineFootView.h"
#import "LYTitleHeaderView.h"
// Vendors
#import <MJExtension.h>
#import "SubLBXScanViewController.h"
// Categories

// Others

@interface LYWalletViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//collectionView
@property(nonatomic, strong) UICollectionView *collectionView;
//推荐商品属性数组
@property(nonatomic, strong) NSMutableArray<LYMoreItem *> *moreArr;
//信用卡办理数组
@property(nonatomic, strong) NSMutableArray<LYCardItem *> *cardArr;

@property(nonatomic, strong) LYWalletHeader *headerView;

@end

//cell
static NSString *const LYExceedCellID = @"LYExceedCell";
static NSString *const LYBottomCellID = @"LYBottomCell";
static NSString *const LYCycleCellID = @"LYCycleCell";
static NSString *const LYMoreItemCellID = @"LYMoreItemCell";

//footer(section2)
static NSString *const LYTopLineFootViewID = @"LYTopLineFootView";
//header
static NSString *const LYTitleHeaderViewID = @"LYTitleHeaderView";

@implementation LYWalletViewController

#pragma mark - lazyLoad

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, -kStatusBarHeight, ScreenW, ScreenH - 64 + kStatusBarHeight);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        //注册
        //cell
        [_collectionView registerClass:[LYExceedCell class] forCellWithReuseIdentifier:LYExceedCellID];
        [_collectionView registerClass:[LYBottomCell class] forCellWithReuseIdentifier:LYBottomCellID];
        [_collectionView registerClass:[LYCycleCell class] forCellWithReuseIdentifier:LYCycleCellID];
        [_collectionView registerClass:[LYMoreItemCell class] forCellWithReuseIdentifier:LYMoreItemCellID];
        
        //footer
        //foot
        [_collectionView registerClass:[LYTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LYTopLineFootViewID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"]; //分割线
        //header
        [_collectionView registerClass:[LYTitleHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LYTitleHeaderViewID];
        
    }
    return _collectionView;
}

-(LYWalletHeader *)headerView
{
    if (!_headerView)
    {
        _headerView = [[LYWalletHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 125)];
        
            __weak typeof(self) weakSelf = self;
            _headerView.faceBtnClickBlock = ^{
                NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
                if (str)
                {
                    [weakSelf.navigationController pushViewController:[[LYLinkController alloc] init] animated:YES];
                }
                else
                {
                    [weakSelf rightLogin];
                }
            };
            
            _headerView.qrcodeBtnClickBlock = ^{
                NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
                if (str)
                {
                    [weakSelf.navigationController pushViewController:[[LYEnterViewController alloc] init] animated:YES];
                }
                else
                {
                    [weakSelf rightLogin];
                }
            };
    
        
        
    }
    return _headerView;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    // 设置导航栏字体颜色
//    UIColor *naiColor = [UIColor whiteColor];
//    attributes[NSForegroundColorAttributeName] = naiColor;
//    attributes[NSFontAttributeName] = PFR20Font;
//    self.navigationController.navigationBar.barTintColor = RGBA(50, 112, 229, 1.0);
//    self.navigationController.navigationBar.titleTextAttributes = attributes;
    // 这样设置状态栏样式是白色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    // 设置导航栏字体颜色
//    UIColor * naiColor = [UIColor blackColor];
//    attributes[NSForegroundColorAttributeName] = naiColor;
//    attributes[NSFontAttributeName] = PFR20Font;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = attributes;
    // 这样设置状态栏样式是黑色的
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.headerView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self setUpData];
}

#pragma mark - 加载数据
-(void)setUpData
{
    _moreArr = [LYMoreItem mj_objectArrayWithFilename:@"Grid.plist"];
    
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (section == 2) ? 4 : 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0)
    {
        __weak typeof(self) weakSelf = self;
        LYCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYCycleCellID forIndexPath:indexPath];
        cell.cycleImageClickBlock = ^{
            LYWalletServiceController *VC = [[LYWalletServiceController alloc] init];
            VC.urlString = @"http://f.chuandu365.com";
            VC.title = @"川渡科技";
            [weakSelf.navigationController pushViewController:VC animated:YES];
        };
        gridcell = cell;
    }
    else if(indexPath.section == 1)
    {
        LYExceedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYExceedCellID forIndexPath:indexPath];
        cell.itemBlock = ^(NSIndexPath *indexPath) {
            //这个标识放在block里面，在外面容易导致循环引用
            NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
            if (str)
            {
                if (indexPath.row == 0)
                {
                    LYLinkController *tempVC = [[LYLinkController alloc] init];
                    tempVC.judeCode = @"1001";
                    tempVC.title = @"小额收款";
                    [weakSelf.navigationController pushViewController:tempVC animated:YES];
                }
                else if (indexPath.row == 1)
                {
                    LYLinkController *tempVC = [[LYLinkController alloc] init];
                    tempVC.judeCode = @"1002";
                    tempVC.title = @"大额收款";
                    [weakSelf.navigationController pushViewController:tempVC animated:YES];
                }
                else if (indexPath.row == 2)
                {
                    LYLinkController *tempVC = [[LYLinkController alloc] init];
                    tempVC.judeCode = @"1003";
                    tempVC.title = @"信用卡收款";
                    [weakSelf.navigationController pushViewController:tempVC animated:YES];
                }
                else if (indexPath.row == 3)
                {
                    [weakSelf.navigationController pushViewController:[[LYEnterViewController alloc] init] animated:YES];
                }
            }
            else
            {
                [weakSelf rightLogin];
            }
            
        };
        gridcell = cell;
    }
    else if (indexPath.section == 2)
    {
        LYMoreItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYMoreItemCellID forIndexPath:indexPath];
        cell.gridItem = _moreArr[indexPath.row];
        gridcell = cell;
    }
    else if (indexPath.section == 3)
    {
        LYBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYBottomCellID forIndexPath:indexPath];
        cell.itemBlock = ^(NSIndexPath *indexPath) {
            if (indexPath.row == 0)
            {
                LYWalletServiceController *serVC = [[LYWalletServiceController alloc] init];
                serVC.title = @"信用卡办理";
                serVC.urlString = @"http://real.izhongyin.com/wxportal/creditCard/bankCards.do?org_id=019300000000";
                [weakSelf.navigationController pushViewController:serVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                LYWalletServiceController *serVC = [[LYWalletServiceController alloc] init];
                serVC.title = @"进度查询";
                serVC.urlString = @"http://real.izhongyin.com/wxportal/creditCard/creditBanksQuery";
                [weakSelf.navigationController pushViewController:serVC animated:YES];
            }
        };
        gridcell = cell;
    }
    return  gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter)
    {
        if (indexPath.section == 1)
        {
            __weak typeof(self) weakSelf = self;
            LYTopLineFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LYTopLineFootViewID forIndexPath:indexPath];
            footerView.questionClickBlock = ^{
                LYWalletServiceController *serVC = [[LYWalletServiceController alloc] init];
                serVC.title = @"常见问题";
                serVC.urlString = @"http://www.1shouyin.com/AboutUs/question.html";
                [weakSelf.navigationController pushViewController:serVC animated:YES];
            };
            reusableView = footerView;
        }
        else if (indexPath.section == 3)
        {
            UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
            footview.backgroundColor = [UIColor whiteColor];
            reusableView = footview;
        }
        else
        {
            UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
            footview.backgroundColor = DCBGColor;
            reusableView = footview;
        }
        
    }
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section == 3)
        {
            LYTitleHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LYTitleHeaderViewID forIndexPath:indexPath];
            reusableView = headerView;
        }
    }
    return reusableView;
    
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)//属性
    {
        return (iphone5) ? CGSizeMake(ScreenW, 150) : CGSizeMake(ScreenW, 200);
    }
    if (indexPath.section == 1)//属性
    {
        return CGSizeMake(ScreenW, ScreenW / 4);
    }
    if (indexPath.section == 2)//猜你喜欢
    {
        return CGSizeMake(ScreenW / 4, ScreenW / 4 + 30);
    }
    if (indexPath.section == 3)
    {
        return (iphone5) ? CGSizeMake(ScreenW, 70) : CGSizeMake(ScreenW, 90);
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return (section == 1) ? CGSizeMake(ScreenW, 60) : (section == 0) ? CGSizeMake(ScreenW, 0) : CGSizeMake(ScreenW, 15);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 3)
    {
        return CGSizeMake(ScreenW, 50);
    }
    
    return CGSizeZero;
}


#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 3) ? 15 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 0) ? 0 : (section == 2) ? 0 : 0;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了10个第%zd属性第%zd",indexPath.section,indexPath.row);
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
    
    if (indexPath.section != 0)
    {
        
        if (str)
        {
            if (indexPath.section == 1)
            {
                NSLog(@"点击了section1");
            }
            else if (indexPath.section == 2)
            {
                if (indexPath.row == 0)
                {
                    [self.navigationController pushViewController:[[LYMerchantController alloc] init] animated:YES];
                }
                else if (indexPath.row == 1)
                {
                    [self.navigationController pushViewController:[[LYFillDataController alloc] init] animated:YES];
                }
                else if (indexPath.row == 2)
                {
                    [self.navigationController pushViewController:[[LYBillSearchController alloc] init] animated:YES];
                }
                else if (indexPath.row == 3)
                {
                    
                }
            }
            else if (indexPath.section == 3)
            {
                
            }
        }
        else
        {
            [self rightLogin];
        }
    }
    
    
}



#pragma mark - 二维码扫一扫
-(void)richScanItemClick
{
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    SubLBXScanViewController *vc = [[SubLBXScanViewController alloc]init];
    vc.title = @"扫码付";
    vc.style = style;
    vc.isQQSimulator = YES;
    
     LYNavigationController *nav = [[LYNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
    vc.scanResult = ^(NSString *strScanned){
        NSLog(@"%@", strScanned);
    };
    
}

#pragma mark - 获取代理商接口
-(void)setUpAgentIdConnect
{
    __weak typeof(self) weakSelf = self;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSDictionary *dic = @{
                          @"agentid": userid
                          };
    [AFOwnerHTTPSessionManager getAddToken:GetAgentUrl Parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSString *code = responseObject[@"code"];
        if ([code isEqualToString:@"0000"])
        {
            NSString *url = responseObject[@"Data"][@"url"];
            LYWalletServiceController *walletService = [[LYWalletServiceController alloc] init];
            walletService.urlString = url;
            walletService.title = @"设置下级代理商结算费率";
            [weakSelf.navigationController pushViewController:walletService animated:YES];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - 立刻登录
-(void)rightLogin
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"我们还没有找到您的账户信息，请马上登录！" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:[[LYLoginViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
