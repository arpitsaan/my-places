//
//  MPImageCache.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPImageCache : NSObject

/**
 *  In Memory Caching of Images
 *
 *  @return singleton instance of this class
 */
+ (MPImageCache *)sharedInstance;

- (void)cacheImage:(UIImage*)image forKey:(NSString*)key;

- (UIImage*)getCachedImageForKey:(NSString*)key;

@end
