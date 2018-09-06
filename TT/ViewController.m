//
//  ViewController.m
//  V7Test
//
//  Created by 赵鼎 on 2018/7/13.
//  Copyright © 2018年 赵鼎. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()
@property (nonatomic, strong) MyView *myView;
@end

@implementation ViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    _myView = [[MyView alloc]initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width - 100, 200)];
    _myView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_myView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.cancelsTouchesInView = NO;
    [_myView addGestureRecognizer:tap];
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"begin");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"cancel");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"end");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch");
}
@end
