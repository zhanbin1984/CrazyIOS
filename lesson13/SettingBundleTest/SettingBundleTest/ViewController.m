//
//  ViewController.m
//  SettingBundleTest
//
//  Created by ndcq on 16/6/28.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *valuessss=[defaults stringForKey:@"username"];
    self.lbName.text=[defaults stringForKey:@"username"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
