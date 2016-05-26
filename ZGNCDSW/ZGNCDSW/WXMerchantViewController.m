//
//  WXMerchantViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMerchantViewController.h"
#import "WXTopView.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "WXProductModel.h"
#import "WXImageModel.h"
#import "UILabel+WXStringFrame.h"
#import "WXFarmDetailViewController.h"
#import "WXfarmImportsTableViewCell.h"
#define GET_PRODUCTSLIST_OFMERCHANTID_URL @""
@interface WXMerchantViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *productArray;
@property(nonatomic,strong)UICollectionView *productTableView;
@end

@implementation WXMerchantViewController
-(NSMutableArray *)productArray{
    if (!_productArray) {
        self.productArray =[[NSMutableArray alloc] init];
    }
    return _productArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addContent];
    
    [self setProductData];
    
    //设置导航
        [self setNavBar];
    

}
-(void)addContent{
    UIView *topContentView=[[UIView alloc] initWithFrame:CGRectMake(10, 60, screenWidth-20, 170)];
    [self.view addSubview:topContentView];
    topContentView.backgroundColor=[UIColor whiteColor];
    [topContentView.layer setCornerRadius:5];
    [topContentView.layer setMasksToBounds:YES];
    UILabel * merchantNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(5,5, CGRectGetWidth(topContentView.frame)-10, 60)];
    merchantNameLbl.font=[UIFont systemFontOfSize:18];
    merchantNameLbl.backgroundColor=[UIColor clearColor];
    merchantNameLbl.numberOfLines=0;
    merchantNameLbl.text=self.theMerchant.Company_Name;
    merchantNameLbl.textColor=[UIColor blackColor];
    [topContentView addSubview:merchantNameLbl];
    
    UILabel *teleLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(merchantNameLbl.frame), CGRectGetMaxY(merchantNameLbl.frame), CGRectGetWidth(merchantNameLbl.frame), 40)];
    teleLbl.font=[UIFont systemFontOfSize:16];
    teleLbl.backgroundColor=[UIColor clearColor];
    teleLbl.text=[NSString stringWithFormat:@"商家电话: %@",self.theMerchant.Tell];
    teleLbl.textColor=[UIColor blackColor];
    [topContentView addSubview:teleLbl];
    
    UILabel *addressLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(merchantNameLbl.frame), CGRectGetMaxY(teleLbl.frame), CGRectGetWidth(merchantNameLbl.frame), 60)];
    addressLbl.backgroundColor=[UIColor clearColor];
    addressLbl.font=[UIFont systemFontOfSize:16];
    addressLbl.textColor=[UIColor blackColor];
    addressLbl.numberOfLines=0;
    addressLbl.text=[NSString stringWithFormat:@"商家地址: %@",self.theMerchant.Company_Address];
    [topContentView addSubview:addressLbl];
    
    UIView * introductionView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(topContentView.frame), CGRectGetMaxY(topContentView.frame)+10, CGRectGetWidth(topContentView.frame), 110)];
    [self.view addSubview:introductionView];
    introductionView.backgroundColor=[UIColor whiteColor];
    [introductionView.layer setCornerRadius:5];
    [introductionView.layer setMasksToBounds:YES];
    
    UILabel *nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(introductionView.frame)-10, 40)];
    nameLbl.font=[UIFont systemFontOfSize:18];
    nameLbl.backgroundColor=[UIColor clearColor];
    nameLbl.text=@"商家介绍";
    nameLbl.textColor=[UIColor blackColor];
    [introductionView addSubview:nameLbl];
    
    UILabel *introductionLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLbl.frame), CGRectGetMaxY(nameLbl.frame), CGRectGetWidth(nameLbl.frame), 60)];
    introductionLbl.font=[UIFont systemFontOfSize:16];
    introductionLbl.backgroundColor=[UIColor clearColor];
    introductionLbl.text=self.theMerchant.Note;
    introductionLbl.textColor=[UIColor blackColor];
    introductionLbl.numberOfLines=0;
     CGSize size=[introductionLbl boundingRectWithSize:CGSizeMake(CGRectGetWidth(nameLbl.frame), 0)];
    introductionLbl.frame=CGRectMake(CGRectGetMinX(nameLbl.frame), CGRectGetMaxY(nameLbl.frame), size.width, size.height);
    [introductionView addSubview:introductionLbl];
    
    introductionView.frame=CGRectMake(CGRectGetMinX(topContentView.frame), CGRectGetMaxY(topContentView.frame)+10, CGRectGetWidth(topContentView.frame), CGRectGetHeight(nameLbl.frame)+size.height+10);
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.productTableView=[[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMinX(topContentView.frame), CGRectGetMaxY(introductionView.frame)+10, CGRectGetWidth(topContentView.frame), screenHeigth-CGRectGetMaxY(introductionView.frame)-10-5) collectionViewLayout:flowLayout];
    
    [self.productTableView registerClass:[WXfarmImportsTableViewCell class] forCellWithReuseIdentifier:@"COLLECcell"];
    
    [self.productTableView.layer setCornerRadius:5];
    [self.productTableView.layer setMasksToBounds:YES];
    self.productTableView.backgroundColor=[UIColor whiteColor];
    self.productTableView.delegate=self;
    self.productTableView.dataSource=self;
    [self.view addSubview:self.productTableView];
}
-(void)setProductData{
    AFHTTPRequestOperationManager *AFMGR=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_PRODUCTSLIST_OFMERCHANTID_URL];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"Merchant_ID"]=self.theMerchant.Merchant_ID;
    [AFMGR GET:path parameters:params success:^(AFHTTPRequestOperation *operation,NSArray *responseObject){
        self.productArray=[[[WXProductModel alloc] init] getProductListWithArrayJSON:responseObject];

    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
    }];
    
}
//设置导航
-(void)setNavBar
{
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"商品详情"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    //    UIButton *buyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    //    buyCart.frame = CGRectMake(screenWidth -50, 10, 50, 40);
    //    [buyCart setImage:[UIImage imageNamed:@"detailBar_cart_press"] forState:UIControlStateNormal];
    //    [buyCart addTarget:self action:@selector(ClickBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [topView addSubview:buyCart];
    
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.keepArray.count;
    //    return self.productArray.count;
    return 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}


//每个cell所展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"COLLECcell";
    WXfarmImportsTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来");
    }
    //    WXProductModel *productmodel=[self.productArray objectAtIndex:indexPath.row];
    //    WXImageModel *imgModel=[productmodel.Goods_Image firstObject];
    //    cell.farmImage.image = [UIImage imageNamed:imgModel.Image_ur];
    //    cell.titleLabel.text = productmodel.Goods_Name;
    //    cell.priceLabel.text = productmodel.Goods_Price;
    //    cell.saleNumLabel.text = productmodel.Goods_Inventory;
    cell.farmImage.image = [UIImage imageNamed:@""];
    cell.titleLabel.text = @"asdasd";
    cell.priceLabel.text = @"asdas";
    cell.saleNumLabel.text = @"asdas";
    return cell;
}

//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //边距占5*4=20 2个
    //图片为正方形，边长
    return CGSizeMake((screenWidth-20)/2, (screenWidth - 20)/2 + 50);
}

//定义每个UICollectionView的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WXFarmDetailViewController *farmDetail = [[WXFarmDetailViewController alloc]init];
    //    farmDetail.theProduct=[self.productArray objectAtIndex:indexPath.row];
    [self presentViewController:farmDetail animated:YES completion:nil];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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
