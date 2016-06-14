//
//  ViewController.m
//  DownImage
//
//  Created by ndcq on 16/6/13.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)draw:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.button addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showImage:(id)sender {
    NSString *url=@"https://www.baidu.com/img/baidu_jgylogo3.gif";
    NSThread *thread=[[NSThread alloc] initWithTarget:self selector:@selector(downImageFromUrl:) object:url];
    [thread start];
}


-(void)downImageFromUrl:(NSString *)urlStr
{
    NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr]];
    UIImage *image=[[UIImage alloc] initWithData:data];
    
    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] init];
//    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest
//                                            returningResponse:&response error:nil];
//    UIImage *image=[[UIImage alloc] initWithData:data];
    if (image!=nil) {
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
    else{
        NSLog(@"---下载图片出现错误---");
    }
}

-(void)updateUI:(UIImage *)image
{
    self.imageView.image=image;
}

- (IBAction)draw:(id)sender {
}
@end
