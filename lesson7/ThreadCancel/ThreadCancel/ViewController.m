//
//  ViewController.m
//  ThreadCancel
//
//  Created by ndcq on 16/6/13.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSThread *thread;
}

- (IBAction)cancelThread:(id)sender;
- (IBAction)getThreadStatus:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    thread=[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)run
{
    [thread setName:@"新线程"];
    for (int i=0; i<20; i++) {
        if ([NSThread currentThread].isCancelled) {
            [NSThread exit];
        }
        NSLog(@"-----------%@-----------%d",[NSThread currentThread],i);
        [NSThread sleepForTimeInterval:0.5];
    }
}


- (IBAction)cancelThread:(id)sender {
    [thread cancel];
}

- (IBAction)getThreadStatus:(id)sender {
    NSLog(@"thread is canceled:%d",thread.isCancelled);
    NSLog(@"thread is executing:%d",thread.isExecuting);
    NSLog(@"thread is finished:%d",thread.isFinished);
}



@end
