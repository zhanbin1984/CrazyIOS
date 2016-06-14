//
//  ViewController.m
//  NSLockDrawTest
//
//  Created by ndcq on 16/6/14.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"
#import "FKAccount.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;

@end

@implementation ViewController
FKAccount *account;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    account=[[FKAccount alloc] initWithAccountNo:@"321231" balance:1000.0];
    [self.drawBtn addTarget:self action:@selector(drawAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawAccount:(id)sender
{
    NSThread *thread1=[[NSThread alloc] initWithTarget:self selector:@selector(drawMethod:) object:[NSNumber numberWithInt:800]];
    thread1.name=@"A线程";
    NSThread *thread2=[[NSThread alloc] initWithTarget:self selector:@selector(drawMethod:) object:[NSNumber numberWithInt:800]];
    thread2.name=@"B线程";
    [thread1 start];
    [thread2 start];
}

-(void)drawMethod:(NSNumber *)drawAccount
{
    [account draw:drawAccount.doubleValue];
}

@end
