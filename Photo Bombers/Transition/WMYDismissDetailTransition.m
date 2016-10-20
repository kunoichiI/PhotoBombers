//
//  WMYDismissDetailTransition.m
//  Photo Bombers
//
//  Created by Mingyuan Wang on 6/26/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//

#import "WMYDismissDetailTransition.h"

@implementation WMYDismissDetailTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}





@end
