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
    
//    NSIndexPath *indexPath;
    
}


@property (nonatomic,strong)UIView *cellView;


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
    [self addSubview:toolbar];
    toolbar.delegate = self;
    self.toolbar = toolbar;
}

/**
 * 初始化收货地址cell
 */
-(void)showAddressCell{
    UIView *cellView = [[UIView alloc]init];
    cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cellView];
    self.cellView = cellView;

    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor blackColor];
    name.font = [UIFont systemFontOfSize:14];
    name.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:name];
    self.name = name;
    
  
    UILabel *phone = [[UILabel alloc]init];
    phone.font = AddressCellPhoneFont;
    phone.textAlignment = NSTextAlignmentCenter;
    [cellView addSubview:phone];
    self.phone = phone;
    
    UILabel *address = [[UILabel alloc]init];;
    address.font = AddressCellAddDetailFont;
    address.numberOfLines = 0;
    [cellView addSubview:address];
    self.address = address;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    [cellView addSubview:lineView];
    self.lineView  = lineView;
    
    if (_addressModel.addressClickState == 1) {
        
        isbool = YES;
        [self.toolbar.defaultBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
        
    } else {
        
        isbool = NO;
        [self.toolbar.defaultBtn setImage:[UIImage imageNamed:@"unselected_btn"] forState:UIControlStateNormal];
    }

    
}

//-(void)defaultAddressImage:(WXAddressModel *)addressModel{
//    if (_addressModel.addressClickState == 1) {
//        
//        isbool = YES;
//        [self.toolbar.defaultBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateNormal];
//        
//    } else {
//        
//        isbool = NO;
//        [self.toolbar.defaultBtn setImage:[UIImage imageNamed:@"unselected_btn"] forState:UIControlStateNormal];
//    }
//}


-(void)setAddressFrame:(WXAddressFrame *)addressFrame{
    _addressFrame = addressFrame;
    
    WXAddressModel *address = addressFrame.address;
    
    self.cellView.frame = addressFrame.cellViewF;
    //收件人
    self.name.frame = addressFrame.usernameF;
    self.name.text = address.username;
    
    //phone
    self.phone.frame = addressFrame.phoneF;
    self.phone.text = address.Phone;
    
    self.address.frame = addressFrame.addressDetailF;
    self.address.text = address.Specific_Address;
    
    self.lineView.frame = addressFrame.lineF;
    
    self.toolbar.frame = addressFrame.toolBarF;
    

}



-(void)addressToolBar:(UIView *)toolBar didClickButton:(UIButton *)button{

    if (button.tag ==200){
    
        
    }else{
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
