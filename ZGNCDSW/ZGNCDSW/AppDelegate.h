//
//  AppDelegate.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSUserDefaults *defaults;
}


@property (strong, nonatomic) UIWindow *window;
@property(readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;
@property(readonly,strong,nonatomic)NSManagedObjectModel *managedObjectModel;
@property(readonly,strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;

@end

