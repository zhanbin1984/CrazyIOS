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
}

-(void)updateUI:(UIImage *)image
{
    self.iv.image=image;
}

@end
