//
//  WXFarmImportsController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXFarmImportsController.h"
#import "PrefixHeader.pch"
#import "WXfarmImportsTableViewCell.h"
#import "UIView+Extension.h"
#import "WXFarmDetailViewController.h"
#import "WXBuyCartController.h"
#import "WXTopView.h"
@interface WXFarmImportsController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UITextField *farmImports;
@property (nonatomic,strong)UIView *searchView;

@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation WXFarmImportsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    

    //设置导航
    if (self.showType==1) {
        [self addTitleView];
    }else{
        [self setNavBar];
    }
    
    
    
    //添加搜索
    [self addSearchView];
    
    [self addCollectionView];
    
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"农品购"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *buyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    buyCart.frame = CGRectMake(screenWidth -50, CGRectGetHeight(topView.frame)-40, 50, 40);
    [buyCart setImage:[UIImage imageNamed:@"detailBar_cart_press"] forState:UIControlStateNormal];
    [buyCart addTarget:self action:@selector(ClickBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:buyCart];
    [self.view addSubview:topView];
    
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//设置导航
-(void)setNavBar
{
    self.navigationItem.title = @"农品购";
    
    UIButton *buyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    buyCart.frame = CGRectMake(screenWidth -50, CGRectGetHeight(self.navigationController.navigationBar.frame)-40, 50, 40);
    [buyCart setImage:[UIImage imageNamed:@"detailBar_cart_press"] forState:UIControlStateNormal];
    [buyCart addTarget:self action:@selector(ClickBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:buyCart];
}
//添加搜索
-(void)addSearchView{
    //CGRectGetHeight(self.navigationController.navigationBar.frame)
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, screenWidth , 50)];
    self.searchView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

    [self.view addSubview:self.searchView];
    
    self.farmImports = [[UITextField alloc]initWithFrame:CGRectMake(20,CGRectGetHeight(self.searchView.frame)-40-3, screenWidth - 40, 40)];
    self.farmImports.placeholder = @"搜索农产品，景点，农业资讯";
    [self.farmImports.layer setCornerRadius:10];
    self.farmImports.backgroundColor = [UIColor whiteColor];
    self.farmImports.delegate = self;
    [self.searchView addSubview: self.farmImports];
    
    // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchIcon.width = 30;
    searchIcon.height = 30;
    searchIcon.contentMode = UIViewContentModeCenter;
    self.farmImports.leftView = searchIcon;
    self.farmImports.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)addCollectionView{
    
    float headerHeight = 30;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(screenWidth, headerHeight);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchView.frame), screenWidth, screenHeigth - self.searchView.frame.size.height) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[WXfarmImportsTableViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hederView"];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
    
}

//点击购物车触发事件
-(void)ClickBuyCartButton:(id)sender{
    
    WXBuyCartController *buyCartViewController = [[WXBuyCartController alloc]init];
    [self presentViewController:buyCartViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.keepArray.count;
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hederView" forIndexPath:indexPath];
    
    //    //添加标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,screenWidth / 2-10, 30)];
    titleLabel.text = @"农品铺子－共123123个产品";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    
//    //添加最新／最热／精华新闻按钮
//    UIButton *newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    newsButton.frame = CGRectMake(screenWidth / 1.8, 0, screenWidth / 2 /3 -10, 30);
//    [newsButton setTitle:@"最新" forState:UIControlStateNormal];
//    [newsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [newsButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
//    
//    UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    hotButton.frame = CGRectMake(screenWidth / 1.8 + (screenWidth / 2 /3 -10), 0, screenWidth / 2 /3 -10, 30);
//    [hotButton setTitle:@"最热" forState:UIControlStateNormal];
//    [hotButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [hotButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
//    
//    UIButton *creamButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    creamButton.frame = CGRectMake(screenWidth / 1.8 +(screenWidth / 2 /3 -10)*2, 0, screenWidth / 2 /3 -10, 30);
//    [creamButton setTitle:@"精华" forState:UIControlStateNormal];
//    [creamButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [creamButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [titleView addSubview:titleLabel];
//    [titleView addSubview:newsButton];
//    [titleView addSubview:hotButton];
//    [titleView addSubview:creamButton];
    
    [headerView addSubview:titleView];
    
    return headerView;
}

//每个cell所展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    WXfarmImportsTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来");
    }
    
    cell.farmImage.image = [UIImage imageNamed:@"news_list1"];
    cell.titleLabel.text = @"afsd";
    cell.priceLabel.text = @"10元／500g";
    cell.saleNumLabel.text = @"20";
    
    
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
    [self presentViewController:farmDetail animated:YES completion:nil];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


@end
