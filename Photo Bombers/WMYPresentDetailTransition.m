//
//  WMYPresentDetailTransition.m
//  Photo Bombers
//
//  Created by Mingyuan Wang on 6/26/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//

#import "WMYPresentDetailTransition.h"

@implementation WMYPresentDetailTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    detail.view.alpha = 0.0;
    
    CGRect frame = containerView.bounds;
    frame.origin.y += 20;
    frame.size.height-= 20;
    detail.view.frame = frame;
    [containerView addSubview:detail.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}



@end
