//
//  ViewController.m
//  NSOperationTest
//
//  Created by 游时钰 on 16/6/16.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import "NSOperationViewController.h"
#import "DownImageOperation.h"

@interface NSOperationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)downImage:(id)sender;
- (IBAction)invocationDownImage:(id)sender;
- (IBAction)operationChildDownImage:(id)sender;

@end

@implementation NSOperationViewController

NSOperationQueue *queue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    queue=[[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount=10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downImage:(id)sender {
    NSString *url=@"https://www.baidu.com/img/baidu_jgylogo3.gif";
    NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
        NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image=[[UIImage alloc] initWithData:data];
        if (image!=nil) {
            [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
        }
        else{
            NSLog(@"-----下载图片出现错误-------");
        }
    }];
    [queue addOperation:operation];
}

- (IBAction)invocationDownImage:(id)sender {
    NSString *url=@"https://www.baidu.com/img/baidu_jgylogo3.gif";
    NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downImageSelector:) object:url];
    [queue addOperation:operation];
}

- (IBAction)operationChildDownImage:(id)sender {
    DownImageOperation *downImageOperation=[[DownImageOperation alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com/img/baidu_jgylogo3.gif"] imageView:self.imageView];
    [queue addOperation:downImageOperation];
}

-(void)downImageSelector:(NSString *)url
{
    NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image=[[UIImage alloc] initWithData:data];
    if (image!=nil) {
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
    else{
        NSLog(@"-----下载图片出现错误-------");
    }
}

-(void)updateUI:(UIImage *)image
{
    self.imageView.image=image;
}

@end
