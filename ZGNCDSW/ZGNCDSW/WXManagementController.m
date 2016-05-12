//
//  WXManagementController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXManagementController.h"
#import "WXTopView.h"
#import "WXHeaderView.h"
@interface WXManagementController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WXHeaderViewDelegate,UIAlertViewDelegate>{
    
    BOOL isFullScreen;
}
@property (nonatomic,strong)NSString *fullPath;

@property (nonatomic,strong)UITableView *manageTableView;

@property (nonatomic,strong)UIButton *headImageBtm;

@property (nonatomic,strong)UIImage *picNameImg;
@end

@implementation WXManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self saveImage:self.picNameImg withName:@"currentImage.png"];
    
    [self addNavBar];
    
    [self addTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.manageTableView reloadData];
}

-(void)viewDidLayoutSubviews
{
    if ([self.manageTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.manageTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.manageTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.manageTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"账户管理"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    UIButton *updateFinish = [UIButton buttonWithType:UIButtonTypeCustom];
    updateFinish.frame = CGRectMake(topView.frame.size.width - 80, 0, 80, topView.frame.size.height);
    [updateFinish setTitle:@"完成" forState:UIControlStateNormal];
    [updateFinish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [updateFinish addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:updateFinish];
}

-(void)addTableView{
    self.manageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-50) style:UITableViewStyleGrouped];
    self.manageTableView.delegate = self;
    self.manageTableView.dataSource = self;
//    self.manageTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.manageTableView];
    
}


-(void)finishClick{
    UIAlertView *alert = [[UIAlertView alloc]init];
    alert = [[UIAlertView alloc]initWithTitle:@"确认修改吗？" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *fullPath1 = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage1.png"];
        
        UIImage *savedImage = [[UIImage alloc]initWithContentsOfFile:fullPath1];
        [self saveImage:savedImage withName:@"currentImage.png"];
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage.png"];
        
        self.picNameImg = [[UIImage alloc]initWithContentsOfFile:fullPath];
        //        self.picNameImg=savedImage;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeUserInforNotification" object:self userInfo:@{@"UserPic":self.picNameImg}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage.png"];
        
        self.picNameImg = [[UIImage alloc]initWithContentsOfFile:fullPath];
        [self.manageTableView reloadData];
    }
    
}


#pragma mark - tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        return 3;
    }
    
}

/**
 * section底部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

/**
 * section顶部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
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
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"头像";
            UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
            headButton.frame  = CGRectMake(screenWidth *0.7, 0, 80, 80);
            [headButton.layer setCornerRadius:40];
            headButton.layer.masksToBounds = YES;
            [headButton setImage:self.picNameImg forState:UIControlStateNormal];
            [headButton addTarget:self action:@selector(ClickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:headButton];
            self.headImageBtm = headButton;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    
    return cell;
}


#pragma mark 点击头像按钮
-(void)ClickHeadButton:(UIButton *)sender{
    UIActionSheet *sheet;
    
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"相机",@"从相册中选择", nil];
    }else{
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册中选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    self.fullPath = fullPath;
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    self.picNameImg = savedImage;
//    [self.headImageBtm setImage:savedImage forState:UIControlStateNormal];
    
    [self.manageTableView reloadData];
    
    
    
//    self.headImageBtm.tag = 100;
    
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}


#pragma mark -tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            return 80;
        }
        return 44;
    }
    return 44;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
