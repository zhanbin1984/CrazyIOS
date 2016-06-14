//
//  FKAccount.m
//  DrawTest
//
//  Created by ndcq on 16/6/13.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "FKAccount.h"

@interface FKAccount()
{
    NSCondition *condition;
    BOOL flag;
}

@end

@implementation FKAccount

-(id)initWithAccountNo:(NSString *)accountNo balance:(CGFloat)balance
{
    self=[super init];
    if (self) {
        _accountNo=accountNo;
        _balance=balance;
        condition=[[NSCondition alloc] init];
        flag=NO;
    }
    return self;
}

-(void)draw:(CGFloat)drawAccount
{
    [condition lock];
    if (flag==NO) {
        [condition wait];
    }
    else{
        if (self.balance>=drawAccount) {
            NSLog(@"%@取钱成功！吐出钞票：%g",[NSThread currentThread].name,drawAccount);
            _balance = _balance - drawAccount;
            NSLog(@"\t余额为：%g",self.balance);
        }else{
            NSLog(@"%@取钱失败！余额不足",[NSThread currentThread].name);
        }
        flag=NO;
        [condition broadcast];
    }
    [condition unlock];
}

-(void)deposit:(CGFloat)depositAccount
{
    [condition lock];
    NSLog(@"%@开始存钱",[NSThread currentThread].name);
    if (flag==YES) {
        NSLog(@"%@开始存钱等待",[NSThread currentThread].name);
        [condition wait];
    }
    else{
        NSLog(@"%@存钱成功！存入钞票：%g",[NSThread currentThread].name,depositAccount);
        _balance = _balance + depositAccount;
        NSLog(@"\t余额为：%g",self.balance);
        flag=YES;
        [condition broadcast];
    }
    [condition unlock];
}

-(NSUInteger)hash
{
    return [self.accountNo hash];
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (other!=nil&&[other class] == [FKAccount class]) {
        FKAccount* target=(FKAccount *)other;
        return [target.accountNo isEqualToString:self.accountNo];
    }
    return NO;
}

@end
