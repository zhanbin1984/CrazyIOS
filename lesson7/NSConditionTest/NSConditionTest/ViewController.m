//
//  ViewController.m
//  NSConditionTest
//
//  Created by ndcq on 16/6/14.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"
#import "FKAccount.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *drawDepositBtn;

@end

@implementation ViewController
FKAccount *account;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    account=[[FKAccount alloc] initWithAccountNo:@"321231" balance:1000.0];
    [self.drawDepositBtn addTarget:self action:@selector(drawDepositAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawDepositAccount:(id)sender
{
    NSThread *thread1=[[NSThread alloc] initWithTarget:self selector:@selector(depositMethod:) object:[NSNumber numberWithInt:800]];
    thread1.name=@"甲1";
    NSThread *thread2=[[NSThread alloc] initWithTarget:self selector:@selector(depositMethod:) object:[NSNumber numberWithInt:800]];
    thread2.name=@"甲2";
    NSThread *thread3=[[NSThread alloc] initWithTarget:self selector:@selector(depositMethod:) object:[NSNumber numberWithInt:800]];
    thread3.name=@"甲3";
    [thread1 start];
    [thread2 start];
    [thread3 start];
    
    NSThread *thread4=[[NSThread alloc] initWithTarget:self selector:@selector(drawMethod:) object:[NSNumber numberWithInt:800]];
    thread4.name=@"乙";
    [thread4 start];
    
}

-(void)drawMethod:(NSNumber *)drawAccount
{
    for (int i=0; i<100; i++) {
        [account draw:drawAccount.doubleValue];
    }
    
}

-(void)depositMethod:(NSNumber *)drawAccount
{
    for (int i=0; i<100; i++) {
        [account deposit:drawAccount.doubleValue];
    }
    
}

@end
