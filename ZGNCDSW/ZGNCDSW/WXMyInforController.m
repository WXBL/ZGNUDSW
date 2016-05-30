//
//  WXMyInforController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMyInforController.h"
#import "WXHeaderView.h"
//#import "WXOrderController.h"
#import "WXUserInforModel.h"
#import "WXManagementController.h"
#import "WXUserLoginViewController.h"
//#import "WXCommendTableViewController.h"
//#import "WXReceivingTableViewController.h"
//#import "WXPayingTableViewController.h"
//#import "WXReturnrefundTableVC.h"
#import "WXGZProductViewController.h"
#import "MDDataBaseUtil.h"
#import "WXSafetyViewController.h"
#import "MBProgressHUD.h"
#import "WXAdviceViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#define UPDATE_USER_IMAGE @""
@interface WXMyInforController ()<WXHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong)UIButton *headButton;

@property (nonatomic,strong)UIView *orderView;
@property (nonatomic,strong)UIButton *orderBtn;

@property (nonatomic,strong)UIView *myMoneyView;
@property (nonatomic,strong)UIButton *moneyButton;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *numLabel;

@property (nonatomic,strong)UIImage *picImage;
@end

@implementation WXMyInforController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    //添加头部个人信息
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addHeaderView];
    [self.tableView reloadData];
}


-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)addHeaderView{
    
    WXHeaderView *headerView = [[WXHeaderView alloc]init];
    headerView.delegate = self;
    self.headButton = headerView.headerButton;
    self.tableView.tableHeaderView = headerView;
    
    
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    WXHeaderView *headerView = [[WXHeaderView alloc]init];
//    headerView.delegate = self;
//    self.headButton = headerView.headerButton;
//    return headerView;
//}
-(void)changeUserInfor:(NSNotification *)notification{
    NSDictionary *userDictionary=[notification userInfo];
    
    self.picImage=[userDictionary objectForKey:@"UserPic"];
    
    
    //    [self addContents];
}

- (void)headerView:(UIView *)headerView didClickButton:(UIButton *)button{
    if (button.tag == 0) {
        [self ClickHeadImageBtn:button];
    }else if (button.tag ==1){
        [self ClickLoginBtn:button];
    }
    
}


#pragma mark -点击头像
-(void)ClickHeadImageBtn:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photo];
    }];
    
    UIAlertAction *xiangji = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
//    UIAlertAction *localvideo = [UIAlertAction actionWithTitle:@"本地视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self locallVideo];
//    }];
//    UIAlertAction *shotvideo = [UIAlertAction actionWithTitle:@"拍摄视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self shotVideo];
//    }];
    
    
    [alertController addAction:okAction];
    [alertController addAction:xiangji];
//    [alertController addAction:localvideo];
//    [alertController addAction:shotvideo];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//相册
-(void)photo{
    /**
     
     UIImagePickerControllerSourceTypePhotoLibrary ,//来自图库
     UIImagePickerControllerSourceTypeCamera ,//来自相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum //来自相册
     */
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

//相机
-(void)camera{
    
    //判断是否可以打开相机，模拟器此功能无法使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

////本地视频
//- (void)locallVideo
//{
//    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
//    
//    imgPickerCtrl.delegate = self;
//    
//    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    
//    //自定媒体类型
//    imgPickerCtrl.mediaTypes = @[@"public.movie"];
//    
//    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
//    
//}
////拍摄视频
//- (void)shotVideo
//{
//    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
//    
//    imgPickerCtrl.delegate = self;
//    
//    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    imgPickerCtrl.mediaTypes = @[@"public.movie"];
//    
//    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
//    
//}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    /**
     
     选取的信息都在info中，info 是一个字典。
     字典中的键：
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     
     
     */
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //如果是拍摄的照片
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //保存在相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
        NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,UPDATE_USER_IMAGE];
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"UserID"]=[MDDataBaseUtil userID];
        params[@"User_image"]=image;
        
        [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
            if (responseObject) {
                [MDDataBaseUtil setUserImage:responseObject];
                [self.headButton setImage:image forState:UIControlStateNormal];
            }
        }failure:^(AFHTTPRequestOperation *operation,NSError *error){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请求数据失败，请稍后重试" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:cancleAction];
        }];
        

        [self.headButton setImage:image forState:UIControlStateNormal];

        
    }else if ([mediaType isEqualToString:@"public.movie"])
    {
        //获取视图的url
        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
        //播放视频
        NSLog(@"%@",url);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ClickLoginBtn:(UIButton *)sender{
    WXUserLoginViewController *loginViewController = [[WXUserLoginViewController alloc]init];
    [self presentViewController:loginViewController animated:YES completion:nil];
}



#pragma mark - 账户管理
-(void)ClickManagementButton:(UIButton *)sender{
    WXManagementController *managementViewController = [[WXManagementController alloc]init];
    [self presentViewController:managementViewController animated:YES completion:nil];
}



#pragma mark - tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([MDDataBaseUtil userName] == NULL) {
        return 2;
    }else{
         return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section ==1){
        return 4;
    }
    return 1;

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
    return 15;
}

/**
 * 显示完全分割线
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            [cell.imageView setImage:[UIImage imageNamed:@"个人中心icon管理"]];
            cell.textLabel.text = @"账户管理";
            
        }else{
            [cell.imageView setImage:[UIImage imageNamed:@"个人中心icon收藏"]];
            cell.textLabel.text = @"我的收藏";
           
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                [cell.imageView setImage:[UIImage imageNamed:@"个人中心icon账户安全"]];
                cell.textLabel.text = @"账户安全";
                break;
            case 1:
                [cell.imageView setImage:[UIImage imageNamed:@"个人中心icon清除缓存"]];
                cell.textLabel.text = @"清楚缓存";
                break;
            case 2:
                [cell.imageView setImage:[UIImage imageNamed:@"个人中心icon意见反馈"]];
                cell.textLabel.text = @"意见反馈";
                break;
            case 3:
                [cell.imageView setImage:[UIImage imageNamed:@"个人中心icon关于"]];
                cell.textLabel.text = @"关于我们";
                break;
            default:
                break;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    
    return cell;
}


#pragma mark -tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([MDDataBaseUtil userName] == NULL) {
        WXUserLoginViewController *loginViewController = [[WXUserLoginViewController alloc]init];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }else{
        switch (indexPath.section) {
               
                
            case 0:
                if (indexPath.row == 0) {
                    WXManagementController *managementViewController = [[WXManagementController alloc]init];
                    [self presentViewController:managementViewController animated:YES completion:nil];
                }else{
                    WXGZProductViewController *keep = [[WXGZProductViewController alloc]init];
                    [self presentViewController:keep animated:YES completion:nil];
                }
                
                break;
            case 1:
                switch (indexPath.row) {
                    case 0:
                    {
                        WXSafetyViewController *safetyView = [[WXSafetyViewController alloc]init];
                        [self presentViewController:safetyView animated:YES completion:nil];
   
                    }
//                        [self Safety];
                        break;
                    case 1:
                    {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
                            
                            NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachPath];
                            
                            NSLog(@"files :%ld",[files count]);
                            
                            for (NSString *p in files) {
                                NSError *error;
                                NSString *path = [cachPath stringByAppendingPathComponent:p];
                                if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
                                    [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                                }
                            }
                            
                            [self performSelectorOnMainThread:@selector(clearCachesSuccess) withObject:nil waitUntilDone:YES];
                        });
                    }
                        break;
                    case 2:
                    {
                        WXAdviceViewController *adviceViewController = [[WXAdviceViewController alloc]init];
                        [self presentViewController:adviceViewController animated:YES completion:nil];
                    }
                        break;
                    case 3:
                        
                        break;
                    default:
                        break;
                }
                break;
            case 2:{
                [MDDataBaseUtil removeUserID];
                [MDDataBaseUtil removeUserName];
                [MDDataBaseUtil removePassword];
                [MDDataBaseUtil removeUserImage];
                [MDDataBaseUtil removeTel];
                [MDDataBaseUtil removeSex];
                [MDDataBaseUtil removeNowAddress];
                [MDDataBaseUtil removeLevelID];
                [MDDataBaseUtil removeLastLoginTime];
                [MDDataBaseUtil removeLoginAddress];
                [MDDataBaseUtil removeAge];
                [MDDataBaseUtil removeRegisteTime];
                [MDDataBaseUtil removeEmail];
                [MDDataBaseUtil removeRankContent];
                [self viewWillAppear:YES];
            }
            
                break;
            default:
                break;
        }
    }
}

//账户安全
-(void)Safety{
    WXSafetyViewController *safetyView = [[WXSafetyViewController alloc]init];
    [self presentViewController:safetyView animated:YES completion:nil];
}

//清除缓存
-(void)clearCachesSuccess{
    NSLog(@"清理成功");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"清理成功";
    hud.margin = 10.f;
    hud.yOffset = 100.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
