//
//  ViewController.m
//  NSThreadTest
//
//  Created by ndcq on 16/6/13.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)cancelThread:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (int i=0; i<100; i++) {
        NSLog(@"===%@===%d",[NSThread currentThread],i);
        if (i==20) {
            NSThread *thread=[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
            //thread.name=@"hahaha";
            [thread start];
            
            [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
        }
        //[NSThread sleepForTimeInterval:0.001];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)run
{
    NSThread *thread=[NSThread currentThread];
    [thread setName:@"新线程"];
    for (int i=0; i<1000; i++) {
        NSLog(@"-----------%@-----------%d",[NSThread currentThread],i);
        if (i==50) {
            [NSThread exit];
        }
    }
}

- (IBAction)cancelThread:(id)sender {
}

@end
