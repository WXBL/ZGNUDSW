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
//#import "WXSexView.m"
#import "WXInforTableViewCell.h"
#import "WXUpdateUserNameController.h"
@interface WXManagementController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>{
    
    BOOL isFullScreen;
}
@property (nonatomic,strong)NSString *fullPath;

@property (nonatomic,strong)UITableView *manageTableView;

@property (nonatomic,strong)UIButton *headImageBtn;

@property (nonatomic,strong)UIImage *picNameImg;

@property (nonatomic,strong)NSMutableArray *userDetailArray;
@property (nonatomic,strong)NSMutableArray *userManageArray;

//列表属性
@property (nonatomic,strong)UIView *sexView;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UILabel *sexLabel;
@property (nonatomic,strong)UILabel *birthLabel;
//性别选择
@property (nonatomic,strong)UIButton *manButton;
@property (nonatomic,strong)UIButton *gileButton;
@property (nonatomic,strong)UIButton *cancelButton;

//添加选择器
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIView *dateView;

@end

@implementation WXManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userDetailArray = [NSMutableArray arrayWithObjects:@"头像",@"用户名",@"昵称",@"性别",@"出生日期", nil];
    self.userManageArray = [NSMutableArray arrayWithObjects:@"收获地址",@"安全管理", nil];
    
    self.sexView  = [[UIView alloc]init];
    self.userName = [[UILabel alloc]init];
    self.sexLabel = [[UILabel alloc]init];
    self.birthLabel = [[UILabel alloc]init];
    
    //    WXSexView *sexView = [[WXSexView alloc]init];
    //    sexView.frame = CGRectMake(0, 0, screenWidth, screenHeigth);
    //    [self.view addSubview:sexView];
    //    sexView.hidden = YES;
    //    self.sexView = sexView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"ChangeUserNameNotification" object:nil];
    
    
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
    updateFinish.frame = CGRectMake(topView.frame.size.width - 80, 10, 80, topView.frame.size.height);
    [updateFinish setTitle:@"完成" forState:UIControlStateNormal];
    [updateFinish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updateFinish addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    updateFinish.titleLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:updateFinish];
}

-(void)addTableView{
    self.manageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-50) style:UITableViewStyleGrouped];
    self.manageTableView.delegate = self;
    self.manageTableView.dataSource = self;
    //    self.manageTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.manageTableView];
    
}

-(void)changeName:(NSNotification *)notification{
    NSDictionary *nameDictionary=[notification userInfo];
    self.userName.text=[nameDictionary objectForKey:@"name"];
    NSLog(@"%@",self.userName.text);
    [self.manageTableView reloadData];

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
        return self.userDetailArray.count;
    }else{
        return self.userManageArray.count;
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
    
    static NSString *cellStr = @"cellID";
    WXInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[WXInforTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        
        if (indexPath.section ==0 && indexPath.row ==0) {
            UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
            headButton.frame  = CGRectMake(screenWidth *0.7, 0, 80, 80);
            [headButton.layer setCornerRadius:40];
            headButton.layer.masksToBounds = YES;
            [headButton setImage:self.picNameImg forState:UIControlStateNormal];
            [headButton addTarget:self action:@selector(ClickHeadButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:headButton];
            self.headImageBtn = headButton;
            
            
        }
    }
    if (indexPath.section ==0) {
        
        if (indexPath.row ==0) {
            [self.headImageBtn setImage:self.picNameImg forState:UIControlStateNormal];
        }
        else if (indexPath.row == 1){
            
            cell.textlbl.text = self.userName.text;
            
        }else if (indexPath.row == 2){
            
            cell.textlbl.text = self.userName.text;
        }
        else if (indexPath.row == 3){
            
            cell.textlbl.text=self.sexLabel.text;
        }else{
            
            cell.textlbl.text=self.birthLabel.text;
        }
        cell.textLabel.text = self.userDetailArray[indexPath.row];
    }else{
        cell.textLabel.text = self.userManageArray[indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
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
    
    if (indexPath.section == 0) {
        if (indexPath.row ==2) {
            WXUpdateUserNameController *updateName = [[WXUpdateUserNameController alloc]init];
            [self presentViewController:updateName animated:YES completion:nil];
        }else if (indexPath.row ==3) {
            
            UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            sexView.alpha = 0.5;
            sexView.backgroundColor = [UIColor grayColor];
            [self.view addSubview:sexView];
            self.sexView = sexView;
            
            UIButton *manButton = [UIButton buttonWithType:UIButtonTypeCustom];
            manButton.frame = CGRectMake(sexView.frame.size.width * 0.1, sexView.frame.size.height-200, sexView.frame.size.width *0.8, 40);
            [ manButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1]];
            [manButton setTitle:@"男" forState:UIControlStateNormal];
            [manButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            manButton.layer.cornerRadius = 10;
            manButton.tag = 101;
            [manButton addTarget:self action:@selector(ClickSexButton:) forControlEvents:UIControlEventTouchUpInside];
            self.manButton = manButton;
            
            UIButton *gileButton = [UIButton buttonWithType:UIButtonTypeCustom];
            gileButton.frame = CGRectMake(sexView.frame.size.width * 0.1, sexView.frame.size.height-130, sexView.frame.size.width *0.8, 40);
            [ gileButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1]];
            [gileButton setTitle:@"女" forState:UIControlStateNormal];
            [gileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            gileButton.layer.cornerRadius = 10;
            gileButton.tag = 102;
            [gileButton addTarget:self action:@selector(ClickSexButton:) forControlEvents:UIControlEventTouchUpInside];
            self.gileButton = gileButton;
            
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelButton.frame = CGRectMake(sexView.frame.size.width * 0.1, sexView.frame.size.height-60, sexView.frame.size.width *0.8, 40);
            [ cancelButton setBackgroundColor:[UIColor grayColor]];
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cancelButton.layer.cornerRadius = 10;
            cancelButton.tag = 103;
            [cancelButton addTarget:self action:@selector(ClickSexButton:) forControlEvents:UIControlEventTouchUpInside];
            self.cancelButton = cancelButton;
            [self.view addSubview:manButton];
            [self.view addSubview:gileButton];
            [self.view addSubview:cancelButton];
        }else{
            UIView *birthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];
            birthView.backgroundColor = [UIColor grayColor];
            birthView.alpha = 0.5;
            [self.view addSubview:birthView];
            self.dateView = birthView;
            
            UIButton *birthButton = [UIButton buttonWithType:UIButtonTypeCustom];
            birthButton.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [birthButton addTarget:self action:@selector(ClickBirthButton:) forControlEvents:UIControlEventTouchUpInside];
            [birthView addSubview:birthButton];
            
            //1.创建日期／时间选择器
            self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.6, self.view.frame.size.width, self.view.frame.size.height * 0.4)];
            self.datePicker.backgroundColor = [UIColor whiteColor];
            //2.日期选择器模式
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            //3.日期范围
            NSString *minStr = @"1900-01-01";
            NSDate *currentData = [NSDate date];//获取当前时间，日期
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *maxStr = [dateFormatter stringFromDate:currentData];
            
            
            NSDate *minDate = [dateFormatter dateFromString:minStr];
            
            NSDate *maxDate = [dateFormatter dateFromString:maxStr];
            
            self.datePicker.minimumDate = minDate;
            self.datePicker.maximumDate = maxDate;
            
            //默认日期
            self.datePicker.date = minDate;
            
            //使用动画使表盘会滚动到你指定的日期
            [self.datePicker setDate:maxDate animated:YES];
            
            
            
            [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            
            [self.view addSubview:self.datePicker];
            
            
        }
    }
    
}

////触发日期选择器事件
-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker *)sender;
    NSDate *_date = control.date;
    
    _date = self.datePicker.date;
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc]init];
    [pickerFormatter setDateFormat:@"yyyy／MM／dd"];
    NSString *dateString = [pickerFormatter stringFromDate:_date];
    
    NSLog(@"date..%@",dateString);
    
    self.birthLabel.text = dateString;
    [self.manageTableView reloadData];
}

-(void)ClickBirthButton:(id)sender{
    self.datePicker.hidden = YES;
    self.dateView.hidden = YES;
    
}

//点击性别按钮触犯事件
-(void)ClickSexButton:(UIButton *)sender{
    if (sender.tag == 101) {
        self.sexLabel.text = @"男";
        
        
    }else if (sender.tag == 102){
        self.sexLabel.text = @"女";
    }else{
        
        self.sexView.hidden = YES;
    }
    self.sexView.hidden = YES;
    self.manButton.hidden = YES;
    self.gileButton.hidden = YES;
    self.cancelButton.hidden = YES;
    [self.manageTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            return 80;
        }
        return 40;
    }
    return 40;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
