//
//  MPLocationManager.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPLocationManager.h"
#import <UIKit/UIKit.h>

NSString *const kDefaultsKeyUserLocationLat = @"kDefaultsKeyUserLocationLat";
NSString *const kDefaultsKeyUserLocationLong = @"kDefaultsKeyUserLocationLong";
NSString *const kNotificationUserLocationUpdateStarted = @"kNotificationUserLocationUpdateStarted";
NSString *const kNotificationUserLocationUpdatedSuccessfully = @"kNotificationUserLocationUpdatedSuccessfully";
NSString *const kNotificationUserLocationUpdateFailed = @"kNotificationUserLocationUpdateFailed";

NSString *const kStringLocationNotDetected = @"Location not detected";
NSString *const kStringLocationServicesOff = @"Location services are turned off on your device. Please go to settings and enable location services to use this feature or manually select a location.";
NSString *const kStringLocationPermissionDenied = @"Please allow location access to My Places.";

@interface MPLocationManager () <CLLocationManagerDelegate, UIAlertViewDelegate>{
    NSUserDefaults *prefs;
    CLLocationManager *locationManager;
}
@end

@implementation MPLocationManager

- (void)baseInit {
    //user defaults
    prefs = [NSUserDefaults standardUserDefaults];
    
    //location manager
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self baseInit];
    }
    
    return self;
}

#pragma mark - Helpers
- (void)saveLocationInPrefs:(CLLocation *)location postNotification:(BOOL)postNotification{
    [prefs setObject:@(location.coordinate.latitude) forKey:kDefaultsKeyUserLocationLat];
    [prefs setObject:@(location.coordinate.longitude) forKey:kDefaultsKeyUserLocationLong];
    [prefs synchronize];
    
    if (postNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLocationUpdatedSuccessfully object:nil];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self checkLocationPermissionAndContinue];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%@", [locations lastObject]);
    [self saveLocationInPrefs:[locations lastObject] postNotification:YES];
    
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLocationUpdateFailed object:nil];
    [locationManager stopUpdatingLocation];
}


#pragma mark - Helpers
- (void)checkLocationPermissionAndContinue {
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        //Location permission has been denied
        [self showGoToSettingsPopup];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLocationUpdateFailed object:nil];
        
    }else {
        if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [locationManager requestWhenInUseAuthorization];
        }
        
        [locationManager startUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLocationUpdateStarted object:nil];
    }
}

- (void)showGoToSettingsPopup {
    UIAlertView *permAlert;
    permAlert = [[UIAlertView alloc]
                 initWithTitle:kStringLocationNotDetected
                 message:kStringLocationPermissionDenied
                 delegate:self
                 cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                 otherButtonTitles:NSLocalizedString(@"Take me there", nil), nil];
    permAlert.tag = 100;
    [permAlert show];
}

#pragma mark - UIALertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView.tag == 100){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - Exposed Methods
+ (MPLocationManager *)sharedInstance {
    static MPLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPLocationManager alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)isLocationPermissionGiven {
    return (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) && [CLLocationManager locationServicesEnabled]);
}

- (BOOL)isLastLocationSaved {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsKeyUserLocationLat]) {
        return YES;
    }
    return NO;
}

- (CLLocation *)getLastKnownLocation {
    CLLocation *locationToReturn = [[CLLocation alloc] init];
    
    if ([self isLastLocationSaved]) {
        double latitude = [prefs doubleForKey:kDefaultsKeyUserLocationLat];
        double longitute = [prefs doubleForKey:kDefaultsKeyUserLocationLong];
        CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitute];
        locationToReturn = tempLocation;
    }
    
    return locationToReturn;
}

- (void)refreshLocation {
    [self checkLocationPermissionAndContinue];
}


@end
