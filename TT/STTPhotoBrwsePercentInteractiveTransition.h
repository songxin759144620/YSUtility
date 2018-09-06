//
//  STTPhotoBrwsePercentInteractiveTransition.h
//  NativeEastNews
//
//  Created by xin song on 2018/7/11.
//  Copyright © 2018年 Gaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STTPhotoBrwsePercentInteractiveTransition : UIPercentDrivenInteractiveTransition<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;
- (instancetype)initWithVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
