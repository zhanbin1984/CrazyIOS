//
//  ViewController.m
//  GCDQueueTest
//
//  Created by 游时钰 on 16/6/14.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
- (IBAction)serial:(id)sender;
- (IBAction)concurrent:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iv;
- (IBAction)downimage:(id)sender;
- (IBAction)syncSerial:(id)sender;
- (IBAction)syncConcurrent:(id)sender;
- (IBAction)dispatchApply:(id)sender;
- (IBAction)dispatch_group:(id)sender;
- (IBAction)dispatch_group2:(id)sender;
- (IBAction)diapatch_once:(id)sender;

@end

@implementation GCDViewController
dispatch_queue_t serialQueue;
dispatch_queue_t concurrentQueue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    serialQueue=dispatch_queue_create("zhanbin.serial.queue", DISPATCH_QUEUE_SERIAL);
    concurrentQueue=dispatch_queue_create("zhanbin.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serial:(id)sender {
    dispatch_async(serialQueue, ^{
        for (int i=0; i<1000; i++) {
             NSLog(@"%@=====%s=====%d",[NSThread currentThread],dispatch_queue_get_label(serialQueue),i);
        }
    });
    
    dispatch_async(serialQueue, ^{
        for (int i=0; i<1000; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
}

- (IBAction)concurrent:(id)sender {
    dispatch_async(concurrentQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"%@=====%s=====%d",[NSThread currentThread],dispatch_queue_get_label(concurrentQueue),i);
        }
    });
    
    dispatch_async(concurrentQueue, ^{
        for (int i=0; i<100; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
}

- (IBAction)downimage:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *urlStr=@"https://www.baidu.com/img/baidu_jgylogo3.gif";
        NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr]];
        UIImage *image=[[UIImage alloc] initWithData:data];
        if (image!=nil) {
//            [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.iv.image=image;
            });
        }
        else{
            NSLog(@"---下载图片出现错误---");
        }

    });
}

- (IBAction)syncSerial:(id)sender {
    
    //死锁
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        for (int i=0; i<1000; i++) {
//            NSLog(@"%@=====%s=====%d",[NSThread currentThread],dispatch_queue_get_label(serialQueue),i);
//        }
//    });
    //死锁
    dispatch_async(serialQueue, ^{
        dispatch_sync(serialQueue, ^{
            for (int i=0; i<1000; i++) {
                NSLog(@"%@=====%s=====%d",[NSThread currentThread],dispatch_queue_get_label(serialQueue),i);
            }
        });
    });
    
    dispatch_sync(serialQueue, ^{
        for (int i=0; i<1000; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
}

- (IBAction)syncConcurrent:(id)sender {
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<1000; i++) {
            NSLog(@"%@=====%s=====%d",[NSThread currentThread],dispatch_queue_get_label(concurrentQueue),i);
        }
    });
    
    dispatch_sync(concurrentQueue, ^{
        for (int i=0; i<1000; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
}

- (IBAction)dispatchApply:(id)sender {
    dispatch_apply(1000, concurrentQueue, ^(size_t time) {
        NSLog(@"=====执行［%lu］=====%@",time,[NSThread currentThread]);
        
    });
    NSLog(@"=====执行完成====%@",[NSThread currentThread]);
}

- (IBAction)dispatch_group:(id)sender {
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i=0; i<500; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i=0; i<500; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i=0; i<500; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
    dispatch_group_async(group, concurrentQueue, ^{
        for (int i=0; i<500; i++) {
            NSLog(@"%@=====%d",[NSThread currentThread],i);
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"执行完成");
    });
}

- (IBAction)dispatch_group2:(id)sender {
    dispatch_group_t group=dispatch_group_create();
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_enter(group);
        // 任务代码1 假定任务 是异步执行block回调
        dispatch_async(concurrentQueue, ^{
            for (int i=0; i<500; i++) {
                NSLog(@"%@=====%d",[NSThread currentThread],i);
            }
            dispatch_group_leave(group);
        });
        
        dispatch_group_enter(group);
        // 任务代码2 假定任务 是异步执行block回调
        dispatch_async(concurrentQueue, ^{
            for (int i=0; i<500; i++) {
                NSLog(@"%@=====%d",[NSThread currentThread],i);
            }
            dispatch_group_leave(group);
        });
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程处理
            NSLog(@"执行完成");
        });
    });
    
}

- (IBAction)diapatch_once:(id)sender {
    static dispatch_once_t once=0;
    dispatch_once(&once, ^{
        NSLog(@"单次执行任务");
        [NSThread sleepForTimeInterval:4];
    });
}

-(void)updateUI:(UIImage *)image
{
    self.iv.image=image;
}

@end
