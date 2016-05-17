//
//  WXAddressTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressTableViewCell.h"
#import "WXtoolbarView.h"
#import "WXAddressModel.h"
#import "WXAddressFrame.h"
@interface WXAddressTableViewCell ()<WXAddressToolbarDelegate>{
    
    BOOL isbool;
}
@property (nonatomic,strong)UIView *cellView;

@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *phone;
@property (nonatomic,strong)UILabel *address;
@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,strong)UILabel *defaultAddress;
@property (nonatomic,strong)UIButton *defaultBtn;//勾选默认地址

@property (nonatomic,strong)WXtoolbarView *toolbar;
@end
@implementation WXAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    WXAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WXAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
        
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //点击cell时候不变颜色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self showAddressCell];
        
        //初始化工具条
        [self setupToolbar];
    }
    return self;
}

/**
 * 初始化工具条
 */
-(void)setupToolbar{
    WXtoolbarView *toolbar = [WXtoolbarView toolbar];
    toolbar.backgroundColor = [UIColor whiteColor];
    toolbar.frame = CGRectMake(0, self.cellView.frame.size.height+1, screenWidth, 30);
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 * 初始化收货地址cell
 */
-(void)showAddressCell{
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 90)];
    cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cellView];
    self.cellView = cellView;
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, cellView.frame.size.width/2-10, cellView.frame.size.height/3)];
    name.text = @"jwh";
    name.textColor = [UIColor blackColor];
    name.font = [UIFont systemFontOfSize:14];
    name.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:name];
    self.name = name;
    
  
    UILabel *phone = [[UILabel alloc]init];
    phone.frame = CGRectMake(cellView.frame.size.width/2, self.name.frame.origin.y, cellView.frame.size.width/2, self.name.frame.size.height);
    phone.font = AddressCellPhoneFont;
    phone.text = @"15075056282";
    phone.textAlignment = NSTextAlignmentCenter;
    [cellView addSubview:phone];
    self.phone = phone;
    
    UILabel *address = [[UILabel alloc]init];
    address.frame = CGRectMake(self.name.frame.origin.x, CGRectGetMaxY(name.frame), cellView.frame.size.width-20, cellView.frame.size.height/3*2);
    address.font = AddressCellAddDetailFont;
    address.text = @"天津市武清区财富兴园";
    address.numberOfLines = 0;
    [cellView addSubview:address];
    self.address = address;

    
}

//-(void)setAddressFrame:(WXAddressFrame *)addressFrame{
//    _addressFrame = addressFrame;
//    
//    WXAddressModel *address = addressFrame.address;
//    
//    self.cellView.frame = addressFrame.cellViewF;
//    //收件人
//    self.name.frame = addressFrame.usernameF;
////    self.name.text =address.username;
//    self.name.text = @"jwh";
//    
//    //phone
//    self.phone.frame = addressFrame.phoneF;
////    self.phone.text = address.Phone;
//    self.phone.text = @"15075056282";
//    
//    self.address.frame = addressFrame.addressDetailF;
////    self.address.text = address.Specific_Address;
//    self.address.text = @"天津市武清区";
//    
//    self.toolbar.frame = addressFrame.toolBarF;
//    
//
//}
//
-(void)addressToolBar:(UIView *)toolBar didClickButton:(UIButton *)button{
    if (button.tag ==100) {
        isbool = YES;
        [self.toolbar.defaultBtn setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
        
    }else if (button.tag ==200){
        
    }else{
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
