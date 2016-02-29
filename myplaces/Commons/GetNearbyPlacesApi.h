//
//  GetNearbyPlacesApi.h
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PlaceDetail.h"

@protocol GetNearbyPlacesApiDelegate <NSObject>

@optional
- (void)didFetchNearbyPlacesSuccessfully;

@optional
- (void)didFailToFetchNearbyPlacesWithError:(NSError *)error;

@end

@interface GetNearbyPlacesApi : NSObject

@property (nonatomic, readonly) NSArray *placesArray;

- (void)fetchNearbyPlacesWithType:(NSString *)type location:(CLLocation *)location radius:(NSNumber *)radius delegate:(id<GetNearbyPlacesApiDelegate>)delegate;

@end
