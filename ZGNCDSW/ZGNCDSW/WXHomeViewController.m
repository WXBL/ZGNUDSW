//
//  WXHomeViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXHomeViewController.h"
#import "WXSearchBar.h"
#import "UIView+Extension.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD.h"
#import "WXCategoryTableViewCell.h"
//#import "WXNewsTableCell.m"
#import "WXRecommendTableViewCell.h"
#import "WXNewsDetailViewController.h"
#import "MDDataBaseUtil.h"
#import "WXUserLoginViewController.h"
#import "WXMyInforController.h"
#import "WXBuyCartController.h"
#import "WXFarmImportsController.h"
#import "WXNewsController.h"
#import "WXTopView.h"
#import "WXProductCategoryViewController.h"
#import "WXNewsModel.h"
#import "WXImageModel.h"
#import "WXMerchantListViewController.h"
@interface WXHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *rootTableView;

//搜索
@property (nonatomic,strong)WXSearchBar *searchBar;
// 创建一个用来引用计时器对象的属性
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;



//声明一个搜索后的可变数组
@property (nonatomic,strong)NSMutableArray *filteredGoods;
//显示当前列表内容
@property (nonatomic,strong)NSMutableArray *currentNewsArray;

@end

@implementation WXHomeViewController

-(NSMutableArray *)newsListArray{
    if (!_newsListArray) {
        self.newsListArray=[NSMutableArray array];
    }
    return _newsListArray;
}


// 实现UIScrollView的滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 如何计算当前滚动到了第几页？
    // 1. 获取滚动的x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    // 用已经偏移了得值, 加上半页的宽度
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    
    // 2. 用x方向的偏移的值除以一张图片的宽度(每一页的宽度)，取商就是当前滚动到了第几页（索引）
    int page = offsetX / scrollView.frame.size.width;
    
    // 3. 将页码设置给UIPageControl
    self.pageControl.currentPage = page;
    
    //NSLog(@"滚了，要在这里根据当前的滚动来计算当前是第几页。");
}

// 实现即将开始拖拽的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止计时器
    // 调用invalidate一旦停止计时器, 那么这个计时器就不可再重用了。下次必须重新创建一个新的计时器对象。
    [self.timer invalidate];
    
    // 因为当调用完毕invalidate方法以后, 这个计时器对象就已经废了，无法重用了。所以可以直接将self.timer设置为nil
    self.timer = nil;
}

// 实现拖拽完毕的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    // 重新启动一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 再次修改一下新创建的timer的优先级
    // 修改self.timer的优先级与控件一样
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//要改变StatusBar的显示样式需要在UIViewController中重载
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [WXSearchBar searchBar];
    self.searchBar.delegate=self;
    //    searchBar.width = self.view.frame.size.width * 0.8;
    //    searchBar.height = 30;
    
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
    
    
    
    [self addScrollView];
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice:) name:@"choice" object:nil];
    
    [center addObserver:self selector:@selector(recommend:) name:@"recommend" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.rootTableView reloadData];
    
}
-(void)recommend:(NSNotification *)notification{
    NSDictionary *recommendDic=[notification userInfo];
    NSString *recommend=[recommendDic objectForKey:@"click"];
    WXFarmImportsController *productVC=[[WXFarmImportsController alloc] init];
    switch (recommend.intValue) {
        case 0:
            productVC.typeModel.Type_Name=@"s";
            break;
        case 1:
            productVC.typeModel.Type_Name=@"sd";
            break;
        case 2:
            productVC.typeModel.Type_Name=@"e";
            break;
        case 3:
            productVC.typeModel.Type_Name=@"w";
            break;
        case 4:
            productVC.typeModel.Type_Name=@"r";
            break;
            
        default:
            break;
    }
    [self presentViewController:productVC animated:YES completion:nil];
    
}
-(void)notice:(NSNotification*)notification{
    NSDictionary *choiceDictionary=[notification userInfo];
    NSString *choice=[choiceDictionary objectForKey:@"choice"];
    NSLog(@"%@",choice);
    UIAlertView * alertView=nil;
    switch (choice.intValue) {
//        case 0:
//            NSLog(@"%@",[MDDataBaseUtil userName]);
//            if ([MDDataBaseUtil userName]==NULL) {
//                WXUserLoginViewController *loginVC=[[WXUserLoginViewController alloc] init];
//                [self presentViewController:loginVC animated:YES completion:nil];
//            }else{
//                WXMyInforController *myInforVC=[[WXMyInforController alloc] init];
//                [self presentViewController:myInforVC animated:YES completion:nil];
//            }
//            break;
//        case 1:
//            if ([MDDataBaseUtil userName]==NULL) {
//                WXUserLoginViewController *loginVC=[[WXUserLoginViewController alloc] init];
//                [self presentViewController:loginVC animated:YES completion:nil];
//            }else{
//                
//            }
//            break;
//        case 2:
//            alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商家入驻，请登录官方网站注册！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
//           
//            break;
//        case 3:
//            alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"大宗团购，请电话联系商家！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
////            if ([MDDataBaseUtil userName]==NULL) {
////                WXUserLoginViewController *loginVC=[[WXUserLoginViewController alloc] init];
////                [self presentViewController:loginVC animated:YES completion:nil];
////            }else{
////                WXFarmImportsController *farmImportVC=[[WXFarmImportsController alloc] init];
////                [self presentViewController:farmImportVC animated:YES completion:nil];
////            }
//            break;
//        case 4:
//        {
//            WXProductCategoryViewController *productCategoryCV=[[WXProductCategoryViewController alloc] init];
//            [self presentViewController:productCategoryCV animated:YES completion:nil];
//        }
//            break;
//        case 5:
//        {
//            WXFarmImportsController *farmImportVC=[[WXFarmImportsController alloc] init];
//            farmImportVC.typeModel.Type_Name=@"ad";
//            [self presentViewController:farmImportVC animated:YES completion:nil];
//        }
//            break;
//        case 6:
//        {
//            WXNewsController *newsVC=[[WXNewsController alloc] init];
//            [self presentViewController:newsVC animated:YES completion:nil];
//        }
//            break;
//        case 7:
//            if ([MDDataBaseUtil userName]==NULL) {
//                WXUserLoginViewController *loginVC=[[WXUserLoginViewController alloc] init];
//                [self presentViewController:loginVC animated:YES completion:nil];
//            }else{
//                WXBuyCartController *buyCarVC=[[WXBuyCartController alloc] init];
//                [self presentViewController:buyCarVC animated:YES completion:nil];
//            }
//            break;
        case 0:{
            WXNewsController *newsVC=[[WXNewsController alloc] init];
            [self presentViewController:newsVC animated:YES completion:nil];
        }
           
            break;
        case 1:{
            WXMerchantListViewController *merchantList=[[WXMerchantListViewController alloc] init];
            [self presentViewController:merchantList animated:YES completion:nil];
        }
       
            break;
        case 2:{
            WXProductCategoryViewController *productCategoryCV=[[WXProductCategoryViewController alloc] init];
            [self presentViewController:productCategoryCV animated:YES completion:nil];
        }
        
            
            break;
        case 3:{
            WXFarmImportsController *farmImportVC=[[WXFarmImportsController alloc] init];
            farmImportVC.typeModel.Type_Name=@"ad";
            [self presentViewController:farmImportVC animated:YES completion:nil];
        }
     
            break;
            
        default:
            break;
    }
     [alertView show];
}



#pragma mark -设置轮播图片
-(void)addScrollView{
    
    self.rootTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth) style:UITableViewStyleGrouped];
    self.rootTableView.delegate = self;
    self.rootTableView.dataSource = self;
    self.rootTableView.tag = 0;
    
    self.rootTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.rootTableView.tableFooterView=[[UIView alloc] init];
    
    //隐藏UITableViewCell的分隔线
    [self.rootTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.rootTableView];
    
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeigth *0.3);
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.rootTableView.tableHeaderView = self.scrollView;
    self.scrollView.delegate = self;
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth *0.3, screenHeigth *0.25, screenWidth * 0.4, 40)];
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1]];
    [self.rootTableView addSubview:self.pageControl];
    
    CGFloat imgW = screenWidth;
    CGFloat imgH = screenHeigth * 0.3
    ;
    CGFloat imgY = 0;
    
    // 1. 循环创建5个UIImageView添加到ScrollView中
    for (int i = 0; i < 4; i++) {
        // 创建一个UIImageView
        UIImageView *imgView = [[UIImageView alloc] init];
        
        // 设置UIImageView中的图片
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        imgView.image = [UIImage imageNamed:imgName];
        
        // 计算每个UIImageView在UIScrollView中的x坐标值
        CGFloat imgX = i * imgW;
        // 设置imgView的frame
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        // 把imgView添加到UIScrollView中
        [self.scrollView addSubview:imgView];
    }
    
    
    // 设置UIScrollView的contentSize(内容的实际大小)
    CGFloat maxW = self.scrollView.frame.size.width * 4;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    
    // 实现UIScrollView的分页效果
    // 当设置允许分页以后, UIScrollView会按照自身的宽度作为一页来进行分页。
    self.scrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 指定UIPageControl的总页数
    self.pageControl.numberOfPages = 4;
    
    // 指定默认是第0页
    self.pageControl.currentPage = 0;
    
    
    // 创建一个"计时器"控件NSTimer控件
    // 通过scheduledTimerWithInterval这个方法创建的计时器控件, 创建好以后自动启动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 修改self.timer的优先级与控件一样
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //    [self.scrollView bringSubviewToFront:self.pageControl];
    
    
    
    
}

// 自动滚动图片的方法
// 因为在创建计时器的时候, 指定了时间间隔是1.0秒,所以下面这个方法每隔一秒钟执行一次
- (void)scrollImage
{
    // 每次执行这个方法的时候, 都要让图片滚动到下一页
    // 如何让UIScrollView滚动到下一页?
    // 1. 获取当前的UIPageControl的页码
    NSInteger page = self.pageControl.currentPage;
    
    // 2. 判断页码是否到了最后一页, 如果到了最后一页, 那么设置页码为0（回到第一页）。如果没有到达最后一页, 则让页码+1
    if (page == self.pageControl.numberOfPages - 1) {
        // 表示已经到达最后一页了
        page = 0; // 回到第一页
    } else {
        page++;
    }
    // 3. 用每页的宽度 * (页码 + 1) == 计算除了下一页的contentOffset.x
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    
    // 4. 设置UIScrollView的contentOffset等于新的偏移的值
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
    // 如果图片现在已经滚动到最后一页了, 那么就滚动到第一页
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - search搜索功能实现
-(void)search:(id)sender{
    NSString *searchString = self.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains [c] %@",searchString];
    self.filteredGoods = [NSMutableArray arrayWithArray:[self.newsListArray filteredArrayUsingPredicate:predicate]];
    if (self.filteredGoods.count > 0) {
        self.currentNewsArray=self.filteredGoods;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有搜索到您想要的商品";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
    }
    [self.rootTableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self search:nil];
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.searchBar.text = nil;
    self.filteredGoods = self.newsListArray;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [self search:nil];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.filteredGoods = self.newsListArray;
    [self search:nil];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self search:nil];
    return YES;
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else{
        //        if (tableView.tag == 0) {
        //            if (self.currentNewsArray.count == 0) {
        //                return 1;
        //            }else{
        //                return self.currentNewsArray.count;
        //            }
        //
        //        }else{
        //            if (self.newsListArray.count == 0) {
        //                return 10;
        //            }else{
        //                return self.newsListArray.count;
        //            }
        //        }
        //    }
        if (self.newsListArray.count>10) {
            return 11;
        }else{
            return self.newsListArray.count+1;
        }
        //        return 10;
        
    }
    
}

/**
 * section底部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
/**
 * section顶部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellStr = @"cell1";
            WXCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[WXCategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            
            //点击cell时不变色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            static NSString *cellStr = @"cell";
            WXRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[WXRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            
            //点击cell时不变色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }else{
        
        if (indexPath.row == 0) {
            static NSString *cellStr = @"cell2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            cell.textLabel.text = @"行业资讯";
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            //点击cell时不变色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellID=@"newsListCellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            WXNewsModel *model=[self.newsListArray objectAtIndex:indexPath.row-1];
            UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, screenWidth - 20, 100)];
            newView.backgroundColor = [UIColor whiteColor];
            [newView.layer setCornerRadius:5];
            [cell addSubview:newView];
            
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            
            
            UIImageView *newImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetHeight(newView.frame)-10, CGRectGetHeight(newView.frame)-10)];
            WXImageModel *imgModel=[model.newsImgArr firstObject];
            [newImage setImage:[UIImage imageNamed:imgModel.Image_ur]];
            [newView addSubview:newImage];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newImage.frame)+10, 5, CGRectGetWidth(newView.frame)-CGRectGetMaxX(newImage.frame)-20, 25)];
            titleLabel.text = model.Administrivia_Name;
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:16];
            [newView addSubview:titleLabel];
            
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame) , CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), CGRectGetHeight(newView.frame)-CGRectGetMaxY(titleLabel.frame)-5)];
            detailLabel.text = [model.Administrivia_Content substringToIndex:40];
            detailLabel.textColor = [UIColor grayColor];
            detailLabel.textAlignment = NSTextAlignmentLeft;
            detailLabel.font = [UIFont systemFontOfSize:14];
            detailLabel.numberOfLines = 0;
            [newView addSubview:detailLabel];
            
            //            UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //            messageButton.frame = CGRectMake(screenWidth * 0.3, newView.frame.size.height - 35, 100, 30);
            //            [messageButton setTitle:@"消息" forState:UIControlStateNormal];
            //            [messageButton setTintColor:[UIColor grayColor]];
            //
            //
            //            [messageButton setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
            //            [newView addSubview:messageButton];
            
            //点击cell时不变色
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
            
        }
        
        
    }
    
    
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    if (section == 1) {
//        NSString *titleStr = @"行业资讯";
//        return titleStr;
//    }
//    return nil;
//}



#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if(indexPath.row==0){
            WXNewsController *newVC=[[WXNewsController alloc] init];
            [self presentViewController:newVC animated:YES completion:nil];
        }else{
            WXNewsDetailViewController *newDetailViewController = [[WXNewsDetailViewController alloc]init];
            newDetailViewController.theNew=[self.newsListArray objectAtIndex:indexPath.row-1];
            [self presentViewController:newDetailViewController animated:YES completion:nil];
        }
        
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            return 90;
        }else{
            return 180;
        }
        
        
    }else{
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 110;
        }
    }
    
}


@end
