//
//  WMYDetailViewController.m
//  Photo Bombers
//
//  Created by Mingyuan Wang on 6/26/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//

#import "WMYDetailViewController.h"
#import "WMYPhotoController.h"
#import "WMYExtraView.h"

@interface WMYDetailViewController ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) WMYExtraView *extraView;
@end

@implementation WMYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
    self.view.clipsToBounds = YES;
    
    self.extraView = [[WMYExtraView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 400.0)];
    self.extraView.alpha = 0.0;
    self.extraView.photo = self.photo;
    
    [self.view addSubview:self.extraView];    // add extraView to the image
   
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, -320, 320.0f, 320.0f)];
    self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    [self.view addSubview:self.imageView];
    
    [WMYPhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipe.numberOfTouchesRequired = 1;
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
   
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGPoint point = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:point];
    [self.animator addBehavior:snap];
    
    self.extraView.center = point;
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:kNilOptions animations:^{
        self.extraView.alpha = 1.0;
    } completion:nil];
}



- (void)close {
    [self.animator removeAllBehaviors];
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
    [self.animator addBehavior:snap];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
