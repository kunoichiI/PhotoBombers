//
//  WMYExtraView.m
//  Photo Bombers
//
//  Created by Mingyuan Wang on 7/2/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//

#import "WMYExtraView.h"
#import "WMYPhotoController.h"

#import <SAMCategories/NSDate+SAMAdditions.h>
@interface WMYExtraView ()
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIButton *usernameButton;
@property (nonatomic) UIImageView *likeImageView;
@property (nonatomic) UIButton *timeButton;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *commentsButton;
@property (nonatomic) UIImageView *commentIcon;
@end


@implementation WMYExtraView
 

- (void) setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    UIImage *background = [UIImage imageWithContentsOfFile:@"shadow"];   // background image for any button
   
    // set the avatar, username, time, number of likes and number of comments.
    NSString *string = _photo[@"caption"][@"from"][@"profile_picture"];;   //avatar picture
    NSURL *avatarURL = [NSURL URLWithString:string];
    self.avatarImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:avatarURL]];
    
    NSString *userbuttonText = _photo[@"caption"][@"from"][@"username"];    // username, set usernameButton properties
    [self.usernameButton setBackgroundImage:background forState:UIControlStateNormal];
    [self.usernameButton setBackgroundImage:background forState:UIControlStateHighlighted];
    [self.usernameButton setTitle:userbuttonText forState:UIControlStateNormal];
    [self.usernameButton setTitle:userbuttonText forState:UIControlStateHighlighted];
 
    NSDate *createdAt = [NSDate dateWithTimeIntervalSince1970:[_photo[@"created_time"]doubleValue]];  // time
    [self.timeButton setBackgroundImage:background forState:UIControlStateNormal];
    [self.timeButton setBackgroundImage:background forState:UIControlStateHighlighted];
    [self.timeButton setTitle:[createdAt sam_briefTimeInWords] forState:UIControlStateHighlighted];
    [self.timeButton setTitle:[createdAt sam_briefTimeInWords] forState:UIControlStateNormal];
    
    self.likeImageView.image = [UIImage imageNamed:@"like"];  // heart of likes :)
   
    NSString *numberOfLikes = [NSString stringWithFormat:@"%@", _photo[@"likes"][@"count"]]; // show number of likes
    NSString *like = @"like";
    NSString *number = [NSString stringWithFormat:@"%@ %@",numberOfLikes, like];
    
    [self.likesButton setBackgroundImage:background forState:UIControlStateNormal];
    [self.likesButton setBackgroundImage:background forState:UIControlStateHighlighted];
    [self.likesButton setTitle:number forState:UIControlStateNormal];
    [self.likesButton setTitle:number forState:UIControlStateHighlighted];
    
    self.commentIcon.image = [UIImage imageNamed:@"pink comment"]; // show comment icon
    
    NSString *comments = [NSString stringWithFormat:@"%@", _photo[@"comments"][@"count"]]; // show number of comments
    [self.commentsButton setBackgroundImage:background forState:UIControlStateNormal];
    [self.commentsButton setBackgroundImage:background forState:UIControlStateHighlighted];
    [self.commentsButton setTitle:comments forState:UIControlStateHighlighted];
    [self.commentsButton setTitle:comments forState:UIControlStateNormal];
    
}

#pragma mark - Actions
- (void)openUser: (id)sender {
    // open link in safari to user profile
    NSString *userPage = [NSString stringWithFormat:@"http://instagram.com/%@", self.usernameButton.titleLabel.text];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:userPage]];
    
}

- (void)openPhoto: (id)sender {
    // open link in safari to the photo page
    NSString *launchURL = _photo[@"link"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:launchURL]];
}

#pragma mark - UIView
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.usernameButton];
        [self addSubview:self.timeButton];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.likesButton];
        [self addSubview:self.likeImageView];
        [self addSubview:self.commentsButton];
        [self addSubview:self.commentIcon];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(320.0f, 400.0f);
}

#pragma mark - UIControl
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 0.0, 32.0, 32.0)];
        _avatarImageView.layer.cornerRadius = 16.0;
        _avatarImageView.layer.borderColor = [UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0].CGColor;
        _avatarImageView.layer.borderWidth = 1.0f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        _avatarImageView.userInteractionEnabled = NO;
        
    }
    return _avatarImageView;
}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0f, 380.0f, 32.0f, 32.0f)];
        _likeImageView.layer.cornerRadius = 8.0;
        _likeImageView.layer.borderColor = [UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0].CGColor;
        _likeImageView.layer.borderWidth = 1.0;
        _likeImageView.layer.masksToBounds = YES;
        _likeImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _likeImageView.userInteractionEnabled = NO;
    }
    return _likeImageView;
}

- (UIImageView *)commentIcon {
    if (!_commentIcon) {
        _commentIcon = [[UIImageView alloc]initWithFrame:CGRectMake(235.0f, 380.0f, 32.0f, 32.0f)];
        _commentIcon.layer.cornerRadius = 8.0;
        _commentIcon.layer.borderColor = [UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0].CGColor;
        _commentIcon.layer.borderWidth = 1.0;
        _commentIcon.layer.masksToBounds = YES;
        _commentIcon.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _commentIcon.userInteractionEnabled = NO;
    }
    return _commentIcon;
}

- (UIButton *)commentsButton {
    if (!_commentsButton) {
        _commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentsButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commentsButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [_commentsButton setFrame:CGRectMake(255.0, 380.0f, 32.0f, 32.0f)];
        
        UIColor *textColor = [UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0];
        [_commentsButton setTitleColor:textColor forState:UIControlStateNormal];
        [_commentsButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        _commentsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _commentsButton;
}

- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [UIButton buttonWithType:UIButtonTypeCustom ];
        _likesButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_likesButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [_likesButton setFrame:CGRectMake(11.0f, 380.0f, 80.0f, 32.0f)];
        
        UIColor *textColor = [UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0];
        [_likesButton setTitleColor:textColor forState:UIControlStateNormal];
        [_likesButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        _likesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        
    }
    return _likesButton;
}

- (UIButton *)usernameButton {
    if (!_usernameButton) {
        _usernameButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _usernameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_usernameButton addTarget:self action:@selector(openUser:) forControlEvents:UIControlEventTouchUpInside];
        [_usernameButton setFrame:CGRectMake(47.0f, 0.0f, 200.0f, 32.0f)];
        
        UIColor *textColor = [UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0];
        [_usernameButton setTitleColor:textColor forState:UIControlStateNormal];
        [_usernameButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        
        _usernameButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _usernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _usernameButton;
}

- (UIButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [[UIButton alloc]initWithFrame:CGRectMake(275.0, 0.0, 40.0, 32.0)];
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        [_timeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_timeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_timeButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}










@end
