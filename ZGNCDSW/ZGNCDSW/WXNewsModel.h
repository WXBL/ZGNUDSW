//
//  WXNewsModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXNewsModel : NSObject
@property(strong,nonatomic)NSString *Administrivia_ID;
@property(strong,nonatomic)NSString *Administrivia_Name;
@property(strong,nonatomic)NSString *Administrivia_Content;
@property(strong,nonatomic)NSString *News_release_People_;
@property(strong,nonatomic)NSString *Release_Time;

-(id)getNewsDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getNewsListWithArrayJSON:(NSArray *)array;
@end
