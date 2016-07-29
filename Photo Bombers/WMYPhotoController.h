//
//  WMYPhotoController.h
//  Photo Bombers
//
//  Created by Mingyuan Wang on 6/26/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMYPhotoController : NSObject
+ (void) imageForPhoto: (NSDictionary *) photo size:(NSString *) size completion:(void (^) (UIImage *image))completion;


@end
