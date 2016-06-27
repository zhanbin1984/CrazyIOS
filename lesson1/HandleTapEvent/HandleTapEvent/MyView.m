//
//  MyView.m
//  HandleTapEvent
//
//  Created by 游时钰 on 16/6/16.
//  Copyright (c) 2016年 kl. All rights reserved.
//

#import "MyView.h"

@implementation MyView


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super hitTest:point withEvent:event];
}

//判断点击的区域是否在当前view内
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //NSLog(@"self.frame=%@",NSStringFromCGRect(self.bounds));
    if (CGRectContainsPoint(CGRectMake(0, 0, 100, 100), point)) {
        //NSLog(@"点击在myview上");
        return YES;
    }
    return NO;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"MyView----touchesBegan");
}

-(instancetype)init
{
    self=[super init];
    if (self) {
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}


-(void)singleTap:(UIGestureRecognizer *)recognizer
{
    
    //NSLog(@"%@----singleTap",recognizer.view);
}

@end
