//
//  WXTypeModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXTypeModel : NSObject
@property(strong,nonatomic)NSString *Type_ID;
@property(strong,nonatomic)NSString *Type_Name;
@property(strong,nonatomic)NSString *Note;
@property(strong,nonatomic)NSString *Parent_Class_ID;

-(id)getTypeDataWithDictionaryWithJSON:(NSDictionary *)dict;
-(id)getTypeDataWithArrayJSON:(NSArray *)array;
@end
