//
//  MPCommonFunctions.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPCommonFunctions : NSObject

+ (void)fetchImageWithUrl:(NSURL *)url onSuccess:(void (^)(UIImage *image))success onFailure:(void (^)(NSError *error))failure;

@end
