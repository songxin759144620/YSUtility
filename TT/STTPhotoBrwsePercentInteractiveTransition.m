//
//  STTPhotoBrwsePercentInteractiveTransition.m
//  NativeEastNews
//
//  Created by xin song on 2018/7/11.
//  Copyright © 2018年 Gaoxin. All rights reserved.
//


#import "STTPhotoBrwsePercentInteractiveTransition.h"

@interface STTPhotoBrwsePercentInteractiveTransition() {
    UIView *_blackBgView;
}
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) UIViewController *weakVC;
@end

@implementation STTPhotoBrwsePercentInteractiveTransition
- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //2
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, 0, [[UIScreen mainScreen]bounds].size.height);
    
    //3
    [[transitionContext containerView]addSubview:toVC.view];
    
    //4
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalRect;
    } completion:^(BOOL finished) {
        //5
        [transitionContext completeTransition:YES];
    }];
}

- (instancetype)initWithVC:(UIViewController *)vc {
    self = [super init];
    if(self){
        _weakVC = vc;
    }
    return self;
}

- (void)setGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    if (!_gestureRecognizer) {
        _gestureRecognizer = gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];
    
    CGFloat scale = 1 - (translation.y / [UIScreen mainScreen].bounds.size.height);
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    
    return scale;
}

- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat scrale = [self percentForGesture:gestureRecognizer];
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
//            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            [self updateInterPercent:[self percentForGesture:gestureRecognizer]];
            
            break;
        case UIGestureRecognizerStateEnded:
            
            if (scrale > 0.95f){
                
//                [self cancelInteractiveTransition];
                [self interPercentCancel];
            }
            else{
//                [self finishInteractiveTransition];
                [self interPercentFinish:scrale];
            }
            break;
        default:
//            [self cancelInteractiveTransition];
            [self interPercentCancel];
            break;
    }
}

- (void)beginInterPercent{

    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //有渐变的黑色背景
    _blackBgView = [[UIView alloc] initWithFrame:containerView.bounds];
    _blackBgView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:_blackBgView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:fromView];
}

- (void)updateInterPercent:(CGFloat)scale{
    _blackBgView.alpha = scale * scale * scale;
}

- (void)interPercentCancel{
    NSLog(@"取消");
    
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:fromView];
    
    [_blackBgView removeFromSuperview];
    _blackBgView = nil;
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}
//完成
- (void)interPercentFinish:(CGFloat)scale{
    NSLog(@"完成");
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = scale;
    [containerView addSubview:bgView];
    
    //过渡的图片
//    UIImageView *transitionImgView = [_weakVC currentImage];
//    transitionImgView.clipsToBounds = YES;
//    [containerView addSubview:transitionImgView];
//
//    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//
//        CGRect rect ;
//        if (scale > 0.8) {
//
//        }else if (scale < 0.4){
//            rect = (CGRect){transitionImgView.centerX,700,transitionImgView.width,transitionImgView.height};
//        }else{
//
//        }
//        transitionImgView.frame = rect;
//        bgView.alpha = 0;
//
//    }completion:^(BOOL finished) {
//
//        [_blackBgView removeFromSuperview];
//        _blackBgView = nil;
//
//        [bgView removeFromSuperview];
//        [transitionImgView removeFromSuperview];
//
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    NSLog(@"--------startInteractiveTransition--------");
    
    [self beginInterPercent];
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

@end
