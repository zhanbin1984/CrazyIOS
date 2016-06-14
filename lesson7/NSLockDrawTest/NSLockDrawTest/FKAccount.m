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
    NSLock *lock;
}

@end

@implementation FKAccount

-(id)initWithAccountNo:(NSString *)accountNo balance:(CGFloat)balance
{
    self=[super init];
    if (self) {
        _accountNo=accountNo;
        _balance=balance;
        lock=[[NSLock alloc] init];
    }
    return self;
}

-(void)draw:(CGFloat)drawAccount
{
    [lock lock];
    {
        if (self.balance>=drawAccount) {
            NSLog(@"%@取钱成功！吐出钞票：%g",[NSThread currentThread].name,drawAccount);
            [NSThread sleepForTimeInterval:1];
            _balance = _balance - drawAccount;
            NSLog(@"\t余额为：%g",self.balance);
        }else{
            NSLog(@"%@取钱失败！余额不足",[NSThread currentThread].name);
        }
    }
    [lock unlock];
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
