//
//  SecodeViewController.m
//  TT
//
//  Created by xin song on 2018/7/11.
//  Copyright © 2018年 xin song. All rights reserved.
//

#import "SecodeViewController.h"

@interface SecodeViewController ()

@end

@implementation SecodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *v = [[UIButton alloc]initWithFrame:CGRectMake(200, 400, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [v addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:v];
}

- (void)pop {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
