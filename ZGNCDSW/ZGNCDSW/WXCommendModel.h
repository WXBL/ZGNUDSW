//
//  WXCommendModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXCommendModel : NSObject
@property(strong,nonatomic)NSString *Comment_ID;
@property(strong,nonatomic)NSString *Comment_Content;
@property(strong,nonatomic)NSString *Comment_Time;
@property(strong,nonatomic)NSString *Indent_ID;

-(id)getCommentDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getcommentListWithArrayJSON:(NSArray *)array;
@end
