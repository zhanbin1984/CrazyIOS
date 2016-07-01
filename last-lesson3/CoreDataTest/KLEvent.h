//
//  KLEvent.h
//  CoreDataTest
//
//  Created by ndcq on 16/7/1.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KLEvent : NSManagedObject

@property (nonatomic, retain) NSDate * happenDate;
@property (nonatomic, retain) NSString * name;

@end
