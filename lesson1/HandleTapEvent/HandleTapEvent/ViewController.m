//
//  ViewController.m
//  HandleTapEvent
//
//  Created by 游时钰 on 16/6/16.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ViewController----touchesBegan");
}

-(void)singleTap:(UIGestureRecognizer *)recognizer
{
    NSLog(@"%@",self.navigationController.navigationBar.items);
    NSLog(@"%@",self.navigationItem);
}

@end
