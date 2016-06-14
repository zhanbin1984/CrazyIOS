//
//  ViewController.m
//  PriorityTest
//
//  Created by ndcq on 16/6/13.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"主线程的优先级为：%g",[NSThread threadPriority]);
    
    NSThread *thread1=[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    thread1.name=@"线程A";
    NSLog(@"线程A的优先级为：%g",[thread1 threadPriority]);
    thread1.threadPriority=-1.0;
    
    NSThread *thread2=[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    thread2.name=@"线程B";
    NSLog(@"线程B的优先级为：%g",[thread2 threadPriority]);
    thread2.threadPriority=2.0;
    
    [thread1 start];
    [thread2 start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)run
{
    for (int i=0; i<100; i++) {
        if (i==50) {
            [NSThread setThreadPriority:0.4];
        }
        NSLog(@"-------%@--------%g----%d",[NSThread currentThread].name,[NSThread threadPriority],i);
    }
}

@end
