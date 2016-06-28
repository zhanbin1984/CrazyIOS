//
//  KLTransformView.m
//  TransformTest
//
//  Created by ndcq on 16/6/27.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "KLTransformView.h"

@implementation KLTransformView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 0.3);
    CGContextTranslateCTM(ctx, -40, 300);
    for (int i=0; i<50; i++) {
        CGContextTranslateCTM(ctx, 50, 50);
        CGContextScaleCTM(ctx, 0.93, 0.93);
        CGContextRotateCTM(ctx, -M_PI/10);
        CGContextFillRect(ctx, CGRectMake(0, 0, 150, 75));
    }
    CGContextRestoreGState(ctx);
    CGContextFillRect(ctx, CGRectMake(0, 0, 150, 75));
}

@end
