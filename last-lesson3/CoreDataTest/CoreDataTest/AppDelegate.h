//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by ndcq on 16/7/1.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
// 定义Core Data的3个核心API的属性
@property (readonly, strong, nonatomic) NSManagedObjectContext*
managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator*
persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

