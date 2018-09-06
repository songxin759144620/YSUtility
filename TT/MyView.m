//
//  MyView.m
//  TT
//
//  Created by xin song on 2018/8/22.
//  Copyright © 2018年 xin song. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__begin");
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__cancel");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__end");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"__touch");
}

@end
