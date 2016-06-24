//
//  DownImageOperation.h
//  NSOperationTest
//
//  Created by 游时钰 on 16/6/16.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownImageOperation : NSOperation

@property(nonatomic, strong)NSURL *url;
@property(nonatomic, weak)UIImageView *imageView;

-(instancetype)initWithURL:(NSURL *)url imageView:(UIImageView *)iv;

@end
