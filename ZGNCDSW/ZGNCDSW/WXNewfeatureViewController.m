//
//  WXNewfeatureViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewfeatureViewController.h"
#import "UIView+Extension.h"
#import "WXHomeViewController.h"
#define NewfeatureCount 4
@interface WXNewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation WXNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.创建一个UIScrollview:显示所有新特性照片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //2.添加图片到scrollview中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i<NewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i *scrollW;
        
        //显示图片
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        
        //如果最后一个imageview，就往里面添加其他内容
        if (i == NewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    //3.设置scrollview其他属性
    scrollView.contentSize = CGSizeMake(NewfeatureCount *scrollW, 0);
    scrollView.bounces = NO;//去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //4.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = NewfeatureCount;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.2 alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.9 alpha:1];
    pageControl.centerX = scrollW *0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    //四舍五入计算出页码
    self.pageControl.currentPage = (int)(page +0.5);
}

-(void)setupLastImageView:(UIImageView *)imageView{
    //开启交互功能
    imageView.userInteractionEnabled = YES;
    
    //1.进入app
    UIButton *startBtn = [[UIButton alloc]init];
    startBtn.frame = CGRectMake(imageView.width *0.5, imageView.height *0.75, screenWidth *0.5, 30);
    [startBtn setBackgroundColor:[UIColor colorWithRed:0.3 green:0.7 blue:0.2 alpha:1]];
    [startBtn setTitle:@"进入APP" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(ClickStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    
}

-(void)ClickStartBtn{
    /**
     切换控制器的手段
     1.push:依赖于UINavigationController,控制器胡切换是可逆的，比如A切换到B，B又可以回到A
     2.modal：控制器胡切换是可逆的，比如A切换到B，B又可以回到A
     3.切换window的rootViewController
     */
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[WXHomeViewController alloc]init];
    
    
}

-(void)dealloc{
    NSLog(@"NewfeatureViewController-dealloc");
}

/*
 1.程序启动会自动加载叫做Default的图片
 1> 3.5inch 非retain屏幕：Default.png
 2> 3.5inch retina屏幕：Default@2x.png
 3> 4.0inch retain屏幕: Default-568h@2x.png
 
 2.只有程序启动时自动去加载的图片, 才会自动在4inch retina时查找-568h@2x.png
 */


/*
 一个控件用肉眼看不见，有哪些可能
 1.根本没有创建实例化这个控件
 2.没有设置尺寸
 3.控件的颜色跟父控件的背景色一样（实际上已经显示了，只不过用肉眼看不见）
 4.透明度alpha <= 0.01
 5.hidden = YES
 6.没有添加到父控件中
 7.被其他控件挡住了
 8.位置不对
 9.父控件发生了以上情况
 10.特殊情况
 * UIImageView没有设置image属性，或者设置的图片名不对
 * UILabel没有设置文字，或者文字颜色和跟父控件的背景色一样
 * UITextField没有设置文字，或者没有设置边框样式borderStyle
 * UIPageControl没有设置总页数，不会显示小圆点
 * UIButton内部imageView和titleLabel的frame被篡改了，或者imageView和titleLabel没有内容
 * .....
 
 添加一个控件的建议（调试技巧）：
 1.最好设置背景色和尺寸
 2.控件的颜色尽量不要跟父控件的背景色一样
 */





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
