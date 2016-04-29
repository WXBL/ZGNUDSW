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
    
    [self addSearchView];
    [self addCollectionView];
    
}
-(void)addSearchView{
    //
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth , 120)];
    self.searchView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.searchView];
    
    self.farmImports = [[UITextField alloc]initWithFrame:CGRectMake(20,75, screenWidth - 40, 40)];
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
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.searchView.frame.size.height, screenWidth, screenHeigth - self.searchView.frame.size.height) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[WXfarmImportsTableViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
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

//每个cell所展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    WXfarmImportsTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来");
    }
    
    cell.farmImage.image = [UIImage imageNamed:@"news_list1"];
    
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
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


@end
