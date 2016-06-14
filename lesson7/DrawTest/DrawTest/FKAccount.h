//
//  FKAccount.h
//  DrawTest
//
//  Created by ndcq on 16/6/13.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FKAccount : NSObject

@property (nonatomic,copy) NSString *accountNo;
@property (nonatomic,readonly) CGFloat balance;

-(id)initWithAccountNo:(NSString *)accountNo balance:(CGFloat)balance;
-(void)draw:(CGFloat)drawAccount;

@end
