//
//  WMYPhotosViewController.m
//  Photo Bombers
//
//  Created by Mingyuan Wang on 6/24/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//


#import "WMYPhotosViewController.h"
#import "WMYPhotoCell.h"
#import "WMYDetailViewController.h"
#import "WMYPresentDetailTransition.h"
#import "WMYDismissDetailTransition.h"
#import "WMYAnimator.h"

#import <SSkeychain/SSKeychain.h>
#import <SimpleAuth/SimpleAuth.h>

@interface WMYPhotosViewController ()  <UIViewControllerTransitioningDelegate, UICollectionViewDelegate, UINavigationControllerDelegate>
@property(nonatomic) NSString *accessToken;
@property(nonatomic) NSArray *photos;

@end

@implementation WMYPhotosViewController {
    NSString *_tag;
}

- (instancetype) init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.title = @"Instagram Browser";

    [self.collectionView registerClass:[WMYPhotoCell class] forCellWithReuseIdentifier:@"photo"];
    
    self.navigationController.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [SSKeychain setPassword:@"instagramToken" forService:@"InstagramService" account:@"com.photobombers.keychain"];
    
    if (self.accessToken == nil) {
        [SimpleAuth authorize:@"instagram" options: @{@"scope":@[@"likes"] } completion:^(NSDictionary *responseObject, NSError *error) {
            self.accessToken = responseObject[@"credentials"][@"token"];
            [SSKeychain passwordForService:@"InstagramService" account:@"com.photobombers.keychain"];
            [self refresh];
            
        }];
    } else {
        [self refresh];
        
    }
    
    
}

- (UISearchBar *)setSearchbar {
    self.searchBar.placeholder = @"Input your keyword to explore pictures on Instagram!";
    self.searchBar.frame  = CGRectMake(0, 0, 320, 44);
    return self.searchBar;
}


#pragma mark - helper method
- (void) refresh {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/photobomb/media/recent?access_token=%@", self.accessToken];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:kNilOptions error:nil];
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    [task resume];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WMYPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.photo = self.photos[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *photo = self.photos[indexPath.row];
    WMYDetailViewController *viewController = [[WMYDetailViewController alloc]init];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    viewController.photo = photo;
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}





#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[WMYAnimator alloc]init];
    }
    return nil;
}



#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[WMYAnimator alloc]init];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[WMYDismissDetailTransition alloc] init];
}

@end
