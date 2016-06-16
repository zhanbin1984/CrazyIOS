//
//  DownImageOperation.m
//  NSOperationTest
//
//  Created by 游时钰 on 16/6/16.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import "DownImageOperation.h"

@implementation DownImageOperation

-(instancetype)initWithURL:(NSURL *)url imageView:(UIImageView *)iv
{
    self=[super init];
    if (self) {
        _imageView=iv;
        _url=url;
    }
    return self;
}

-(void)main
{
    NSData *data=[[NSData alloc] initWithContentsOfURL:self.url];
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
