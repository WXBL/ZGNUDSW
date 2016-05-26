//
//  WXTabBarController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXTabBarController.h"
#import "PrefixHeader.pch"
#import "WXHomeViewController.h"
#import "WXMessageTableViewController.h"
#import "WXNewsController.h"
#import "WXMyInforController.h"
#import "WXFarmImportsController.h"
#import "WXNavigationController.h"
#import "WXUserLoginViewController.h"
#import "MDDataBaseUtil.h"
#import "WXUserLoginViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "WXNewsModel.h"
#import "WXProductModel.h"
#define GET_NEWSLIST_URL @""
@interface WXTabBarController ()

@end

@implementation WXTabBarController

-(NSMutableArray *)newsMutableArray{
    if (!_newsMutableArray) {
        self.newsMutableArray=[NSMutableArray array];
    }
    return _newsMutableArray;
}
-(NSMutableArray *)productMutableArray{
    if(!_productMutableArray){
        self.productMutableArray=[NSMutableArray array];
    }
    return _productMutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNewsData];
    //1.初始化字控制器
    WXHomeViewController *home = [[WXHomeViewController alloc]init];
    home.newsListArray=self.newsMutableArray;
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    WXNewsController *news = [[WXNewsController alloc]init];
    news.newsDataArray=self.newsMutableArray;
    [self addChildVc:news title:@"资讯"  image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    WXFarmImportsController *farmImports = [[WXFarmImportsController alloc]init];
    farmImports.showType=1;
    [self addChildVc:farmImports title:@"农产品" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    if (![[NSUserDefaults standardUserDefaults]stringForKey:@"userName"]) {
        
    }
    

    
    if ([MDDataBaseUtil userName]==NULL) {
        WXUserLoginViewController *userLoginVC=[[WXUserLoginViewController alloc] init];
        [self addChildVc:userLoginVC title:@"消息" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
//                WXUserLoginViewController *userLoginVC1=[[WXUserLoginViewController alloc] init];
//                [self addChildVc:userLoginVC1 title:@"我的" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    }else{
        WXMessageTableViewController *message = [[WXMessageTableViewController alloc]init];
        [self addChildVc:message title:@"消息" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
        
//        
//                WXMyInforController *myInfor = [[WXMyInforController alloc]init];
//                [self addChildVc:myInfor title:@"我的" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    }
    WXMyInforController *myInfor = [[WXMyInforController alloc]init];
    [self addChildVc:myInfor title:@"我的" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
//
    
    
}
-(void)setNewsData{
    AFHTTPRequestOperationManager *AFMgr=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_NEWSLIST_URL];
    
    [AFMgr GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responseObject){
        WXNewsModel *model=[[WXNewsModel alloc] init];
        self.newsMutableArray=[model getNewsListWithArrayJSON:responseObject];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
    }];
}

-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectImage{
    
    //设置字控制器的文字
    childVc.title = title;
    //    childVc.tabBarItem.title = title;
    //    childVc.navigationItem.title = title;
    
    //设置字控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
    
    //    //先给外面传进来的小控制器包装一个导航控制器
    WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:childVc];
    //添加字控制器
    [self addChildViewController:nav];
    
    //    [self addChildViewController:childVc];
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



@end
