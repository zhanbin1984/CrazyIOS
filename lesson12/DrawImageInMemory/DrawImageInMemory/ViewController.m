//
//  ViewController.m
//  DrawImageInMemory
//
//  Created by ndcq on 16/6/24.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *iv=[[UIImageView alloc] initWithImage:[self drawImage:self.view.frame.size]];
    //iv.frame=CGRectMake(50, 50, 250, 250);
    iv.backgroundColor=[UIColor redColor];
    [self.view addSubview:iv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)drawImage:(CGSize) size
{
    //准备绘图环境
    UIGraphicsBeginImageContext(size);
    //获取绘图CGContextRef
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //开始绘图
    CGContextSetLineWidth(ctx, 8);
    CGContextSetRGBStrokeColor(ctx,0, 1, 0, 1);
    CGContextStrokeRect(ctx, CGRectMake(30, 30, 120, 160));
    CGContextSetRGBFillColor(ctx, 1, 1, 0, 1);
    CGContextFillRect(ctx, CGRectMake(180, 30, 120, 60));
    
    UIImage *image=[UIImage imageNamed:@"chat_video_play"];
    [image drawInRect:CGRectMake(30, 200, 60, 60)];
    CGContextDrawImage(ctx, CGRectMake(30, 380, 60, 60), image.CGImage);
    //获取绘制的图形
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //绘图结束并关闭绘图环境
    UIGraphicsEndImageContext();
    NSString *path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"newPng.png"];
    [UIImagePNGRepresentation(newImage) writeToFile:path atomically:YES];
    return newImage;
}

@end
