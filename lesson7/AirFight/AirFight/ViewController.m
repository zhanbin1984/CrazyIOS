//
//  ViewController.m
//  AirFight
//
//  Created by 游时钰 on 16/6/15.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBack:) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)enterBack:(NSNotification *)notification
{
    UIApplication *app=[UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier backTaskId;
//    backTaskId=[app beginBackgroundTaskWithExpirationHandler:^{
//        NSLog(@"＝＝＝再额外申请的10分钟内依然没有完成任务＝＝＝");
//        [app endBackgroundTask:backTaskId];
//    }];
//    if (backTaskId==UIBackgroundTaskInvalid) {
//        NSLog(@"＝＝＝IOS版本不支持后台运行＝＝＝");
//        return;
//    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"＝＝＝额外申请的后台任务时间为：%f＝＝＝",app.backgroundTimeRemaining);
        for (int i=0; i<100; i++) {
            NSLog(@"下载任务完成了%d%%",i);
            [NSThread sleepForTimeInterval:5];
        }
        NSLog(@"＝＝＝剩余的后台任务时间为：%f＝＝＝",app.backgroundTimeRemaining);
        //[app endBackgroundTask:backTaskId];
    });
}

@end
