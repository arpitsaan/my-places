//
//  UIImageView+UrlImage.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "UIImageView+UrlImage.h"
#import "MPImageCache.h"

@implementation UIImageView (UrlImage)

- (void)setImageWithUrl:(NSURL *)url {
    UIImage* image = [[MPImageCache sharedInstance] getCachedImageForKey:url.absoluteString];
    if (image) {
        [self setImage:image];
    }else{
        [MPCommonFunctions fetchImageWithUrl:url onSuccess:^(UIImage *image) {
            [self setImage:image];
            [[MPImageCache sharedInstance] cacheImage:image forKey:url.absoluteString];
        } onFailure:^(NSError *error) {
        }];
    }
}

@end
