//
//  MPCommonFunctions.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPCommonFunctions.h"

@implementation MPCommonFunctions

+ (void)fetchImageWithUrl:(NSURL *)url onSuccess:(void (^)(UIImage *image))success onFailure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        NSError *error;
        NSData *imageData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        UIImage *downloadedImage = [UIImage imageWithData:imageData];
        
        if (error || downloadedImage == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                success(downloadedImage);
            });
        }
    });
}

@end
