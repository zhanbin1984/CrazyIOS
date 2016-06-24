//
//  ViewController.m
//  UIImageTest
//
//  Created by ndcq on 16/6/24.
//  Copyright (c) 2016年 nd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;
- (IBAction)readBundle:(id)sender;
- (IBAction)readNet:(id)sender;
- (IBAction)readPhone:(id)sender;
- (IBAction)butterfly:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readBundle:(id)sender {
    UIImage *image=[UIImage imageNamed:@"doctor_phone"];
    self.iv.image=image;
    
}

- (IBAction)readNet:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url=@"https://www.baidu.com/img/baidu_jgylogo3.gif";
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image=[UIImage imageWithData:data];
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:NO];
    });
    
}

-(void)updateUI:(UIImage *)image
{
    self.iv.image=image;
}

- (IBAction)readPhone:(id)sender {
//    NSString *Path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//                    stringByAppendingPathComponent:@"等待@2x.png"];
    NSString *documentDictory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    UIImage *image=[UIImage imageWithContentsOfFile:[documentDictory stringByAppendingPathComponent:@"等待@2x.png"]];
    //UIImage *image=[UIImage imageWithContentsOfFile:Path];
    self.iv.image=image;
}

- (IBAction)butterfly:(id)sender {
    self.iv.image=[UIImage animatedImageNamed:@"butterfly_f" duration:0.6];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
}

-(void)changePos
{
    CGPoint curPos=self.iv.center;
    int y=arc4random()%10-5;
    if (curPos.x>[UIScreen mainScreen].bounds.size.width) {
        self.iv.center=CGPointMake(100, 100);
        return;
    }
    self.iv.center=CGPointMake(curPos.x+4, curPos.y+y);
}


@end
