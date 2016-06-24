//
//  KLGeometryView.m
//  GeometryShape
//
//  Created by ndcq on 16/6/24.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "KLGeometryView.h"

@implementation KLGeometryView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 16);
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    const CGPoint points1[]={CGPointMake(20, 20),CGPointMake(100, 20)
        ,CGPointMake(100, 20),CGPointMake(20, 50)};
    CGContextStrokeLineSegments(ctx, points1, 4);
    
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    const CGPoint points2[]={CGPointMake(120, 20),CGPointMake(200, 20)
        ,CGPointMake(200, 20),CGPointMake(120, 50)};
    CGContextStrokeLineSegments(ctx, points2, 4);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    const CGPoint points3[]={CGPointMake(220, 20),CGPointMake(300, 20)
        ,CGPointMake(300, 20),CGPointMake(220, 50)};
    CGContextStrokeLineSegments(ctx, points3, 4);
}


@end
