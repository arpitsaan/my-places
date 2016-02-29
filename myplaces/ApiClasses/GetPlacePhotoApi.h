//
//  GetPlacePhotoApi.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceDetail.h"

@protocol GetPlacePhotoApiDelegate <NSObject>

@optional
- (void)didFetchPlacePhotoSuccessfully;

@optional
- (void)didFailToFetchPlacePhotoWithError:(NSError *)error;

@end

@interface GetPlacePhotoApi : NSObject

@property(nonatomic, readonly) UIImage *placePhoto;

- (void)fetchPlacePhotoWithPlace:(PlaceDetail *)placeDetail delegate:(id<GetPlacePhotoApiDelegate>) delegate;

@end
