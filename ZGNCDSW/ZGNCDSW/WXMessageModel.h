//
//  WXMessageModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMessageModel : NSObject
@property(strong,nonatomic)NSString *Information_ID;
@property(strong,nonatomic)NSString *Information_Name;
@property(strong,nonatomic)NSString *Information_Content;
@property(strong,nonatomic)NSString *Publish_time;
@property(strong,nonatomic)NSString *Information_Image;
@property(strong,nonatomic)NSString *Post_message_ID;
@property(strong,nonatomic)NSString *receiving_information_ID;

-(id)getMessageDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getMessageListWithArrayJSON:(NSArray *)array;
@end
