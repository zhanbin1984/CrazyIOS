//
//  ViewController.m
//  CALayerTest
//
//  Created by ndcq on 16/6/27.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor grayColor];
    self.view.layer.cornerRadius=20;
    self.view.layer.borderWidth=4;
    self.view.layer.borderColor=[UIColor redColor].CGColor;
    
    //新建一个简单的CALayer
    CALayer *subLayer=[CALayer layer];
    subLayer.backgroundColor=[UIColor magentaColor].CGColor;
    subLayer.cornerRadius=8 ;
    subLayer.borderColor=[UIColor blackColor].CGColor;
    subLayer.borderWidth=2;
    //设置阴影
    subLayer.shadowOffset=CGSizeMake(4, 5);
    subLayer.shadowRadius=1;
    subLayer.shadowColor=[UIColor blackColor].CGColor;
    subLayer.shadowOpacity=0.8;
    subLayer.frame=CGRectMake(30, 30, 120, 160);
    [self.view.layer addSublayer:subLayer];
    
    //新建一个简单的CALayer
    CALayer *subLayer2=[CALayer layer];
    subLayer2.backgroundColor=[UIColor magentaColor].CGColor;
    subLayer2.cornerRadius=8 ;
    subLayer2.borderColor=[UIColor blackColor].CGColor;
    subLayer2.borderWidth=2;
    //设置阴影
    subLayer2.shadowOffset=CGSizeMake(4, 5);
    subLayer2.shadowRadius=1;
    subLayer2.shadowColor=[UIColor blackColor].CGColor;
    subLayer2.shadowOpacity=0.8;
    subLayer2.masksToBounds=YES;
    subLayer2.frame=CGRectMake(170, 30, 120, 160);
    [self.view.layer addSublayer:subLayer2];
    //使用CALayer显示图片
    CALayer *imageLayer=[CALayer layer];
    imageLayer.contents=(id)[[UIImage imageNamed:@"android"] CGImage];
    imageLayer.frame=subLayer2.bounds;
    [subLayer2 addSublayer:imageLayer];
    
    //自定义CALayer的绘制内容
    CALayer *customDrawn=[CALayer layer];
    customDrawn.delegate = self;
    customDrawn.backgroundColor=[UIColor greenColor].CGColor;
    customDrawn.frame=CGRectMake(30, 220, 260, 210);
    customDrawn.cornerRadius=20 ;
    customDrawn.borderColor=[UIColor blackColor].CGColor;
    customDrawn.borderWidth=2;
    //设置阴影
    customDrawn.shadowOffset=CGSizeMake(0, 3);
    customDrawn.shadowRadius=5;
    customDrawn.shadowColor=[UIColor blackColor].CGColor;
    customDrawn.shadowOpacity=0.8;
    customDrawn.masksToBounds=YES;
    [self.view.layer addSublayer:customDrawn];
    [customDrawn setNeedsDisplay];
    
}

void CGContextAddRoundRect(CGContextRef context,CGRect rect,CGFloat radius){
    float x1=rect.origin.x;
    float y1=rect.origin.y;
    float x2=x1+rect.size.width;
    float y2=y1;
    float x3=x2;
    float y3=y1+rect.size.height;
    float x4=x1;
    float y4=y3;
    CGContextMoveToPoint(context, x1, y1+radius);
    CGContextAddArcToPoint(context, x1, y1, x1+radius, y1, radius);
    
    CGContextAddArcToPoint(context, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(context, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(context, x4, y4, x4, y4-radius, radius);
    
    CGContextClosePath(context);
    
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    UIColor *bgColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"heart.gif"]];
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    CGContextFillEllipseInRect(ctx, CGRectMake(20, 20, 100, 100));
    CGContextAddRoundRect(ctx, CGRectMake(160, 20, 40, 60), 5);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    //CGContextSetRGBStrokeColor(ctx, 1, 1, 0, 1);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
