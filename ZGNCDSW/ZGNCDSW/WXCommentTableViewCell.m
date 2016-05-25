//
//  WXCommentTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCommentTableViewCell.h"
#import "WXUserModel.h"
@interface  WXCommentTableViewCell()

@property (nonatomic,strong)UIView *commentView;

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *commentContent;
@property (nonatomic,strong)UILabel *commentTime;
@property (nonatomic,strong)UILabel *category;

@end

@implementation WXCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    WXCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WXCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];

        
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //点击cell时不变色
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化评论信息
        [self setupComment];
    }
    return self;
}

-(void)setupComment
{
    /** 评论信息整体*/
    UIView *commentView = [[UIView alloc]init];
    commentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:commentView];
    
    /**用户昵称*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [commentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /**评论内容*/
    UILabel *commentContent = [[UILabel alloc]init];
    commentContent.font = [UIFont systemFontOfSize:14];
    commentContent.numberOfLines = 0;
    [commentView addSubview:commentContent];
    self.commentContent = commentContent;
    
    /**时间 */
    UILabel *commentTime = [[UILabel alloc]init];
    commentTime.font = [UIFont systemFontOfSize:12];
    commentTime.textColor = [UIColor grayColor];
    [commentView addSubview:commentTime];
    self.commentTime = commentTime;
    
    /**分类 */
    UILabel *category = [[UILabel alloc]init];
    category.font = [UIFont systemFontOfSize:12];
    category.textColor = [UIColor grayColor];
    [commentView addSubview:category];
    self.category = category;
}

-(void)setStatusFrame:(WXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    WXStatusModel *status = statusFrame.status;
//    WXUserModel *user = status.user;
    //评论整体
    self.commentView.frame = statusFrame.commentViewF;
    
    //昵称
//    self.nameLabel.text = user.UserName;
    self.nameLabel.text = @"asdffa";
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    //正文
//    self.commentContent.text = status.Comment_Content;
    self.commentContent.text = @"alskdjflaksjdfl;aksjdflka";
    self.commentContent.frame = statusFrame.commentContentF;
    
    //时间
    self.commentTime.text = status.Comment_Time;
    self.commentTime.frame = statusFrame.commentTimeF;
    
    //分类
    self.category.text = status.category;
    self.category.text = @"2015/3/2";
    self.category.frame = statusFrame.categoryF;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
