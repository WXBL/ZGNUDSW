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
#import "WXAddressController.h"
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
    
    self.userDetailArray = [NSMutableArray arrayWithObjects:@"用户名",@"昵称",@"性别",@"出生日期", nil];
    
    self.sexView  = [[UIView alloc]init];
    self.userName = [[UILabel alloc]init];
    self.sexLabel = [[UILabel alloc]init];
    self.birthLabel = [[UILabel alloc]init];
    
   
    
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
    [updateFinish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认修改吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
     UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




#pragma mark - tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return self.userDetailArray.count;
   
    
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
        
    }
        if (indexPath.row == 0){
            
            cell.textlbl.text = self.userName.text;
            
        }else if (indexPath.row == 1){
            
            cell.textlbl.text = self.userName.text;
        }
        else if (indexPath.row == 2){
            
            cell.textlbl.text=self.sexLabel.text;
        }else{
            
            cell.textlbl.text=self.birthLabel.text;
        }
        cell.textLabel.text = self.userDetailArray[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}






#pragma mark -tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
        if (indexPath.row ==0 ) {
            WXUpdateUserNameController *updateName = [[WXUpdateUserNameController alloc]init];
            [self presentViewController:updateName animated:YES completion:nil];
        }else if (indexPath.row ==2) {
            
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
        }else if(indexPath.row ==3){
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
