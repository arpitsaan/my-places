//
//  MPLocationManager.h
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString *const kNotificationUserLocationUpdateStarted;
extern NSString *const kNotificationUserLocationUpdatedSuccessfully;
extern NSString *const kNotificationUserLocationUpdateFailed;

@interface MPLocationManager : NSObject

+ (MPLocationManager *)sharedInstance;

- (BOOL)isLocationPermissionGiven;

- (BOOL)isLastLocationSaved;

- (CLLocation *)getLastKnownLocation;

- (void)refreshLocation;

@end
