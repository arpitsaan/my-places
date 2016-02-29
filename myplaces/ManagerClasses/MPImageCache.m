//
//  MPImageCache.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPImageCache.h"

@interface MPImageCache ()
@property(nonatomic, strong) NSCache *imageCache;
@end

@implementation MPImageCache

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

+ (MPImageCache *)sharedInstance {
    static MPImageCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPImageCache alloc] init];
    });
    
    return sharedInstance;
}

- (void)cacheImage:(UIImage*)image forKey:(NSString*)key {
    [self.imageCache setObject:image forKey:key];
}

- (UIImage*)getCachedImageForKey:(NSString*)key {
    return [self.imageCache objectForKey:key];
}

@end
