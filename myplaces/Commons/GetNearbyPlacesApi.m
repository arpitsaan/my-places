//
//  GetNearbyPlacesApi.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "GetNearbyPlacesApi.h"

@interface GetNearbyPlacesApi () <NSURLSessionDelegate>
@property (nonatomic, weak)id<GetNearbyPlacesApiDelegate> delegate;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSString *placeType;
@property (nonatomic, strong) NSNumber *radius;

@property (nonatomic) BOOL isRunning;
@end

@implementation GetNearbyPlacesApi

- (void)fetchNearbyPlacesWithType:(NSString *)type location:(CLLocation *)location radius:(NSNumber *)radius delegate:(id<GetNearbyPlacesApiDelegate>)delegate {

    _placesArray = [[NSArray alloc] init];
    
    if (self.isRunning) {
        return;
    }
    
    self.placeType = type;
    self.currentLocation = location;
    self.delegate = delegate;
    self.radius = radius;
    
    [self doApiCall];
}

- (NSURL *)getAPIUrl {
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%@&type=%@&key=%@",
                           @(self.currentLocation.coordinate.latitude), @(self.currentLocation.coordinate.longitude),
                           self.radius,
                           self.placeType.lowercaseString,
                           kMPKeyBrowserGooglePlacesApi];
    
    return [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)doApiCall {
    self.isRunning = YES;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getAPIUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        self.isRunning = NO;
        
        if (!error) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];;
            for (NSDictionary *placeItem in [responseDictionary valueForKeyPath:@"results"]) {
                PlaceDetail *placeDetail = [[PlaceDetail alloc] init];
                placeDetail.lat = [placeItem valueForKeyPath:@"geometry.location.lat"];
                placeDetail.lng = [placeItem valueForKeyPath:@"geometry.location.lng"];
                placeDetail.icon = [placeItem valueForKeyPath:@"icon"];
                placeDetail.placeId = [placeItem valueForKeyPath:@"place_id"];
                placeDetail.name = [placeItem valueForKeyPath:@"name"];
                placeDetail.referenceId = [placeItem valueForKeyPath:@"reference"];
                placeDetail.vicinity = [placeItem valueForKeyPath:@"vicinity"];
                
                [tempArray addObject:placeDetail];
            }
            
            _placesArray = [NSArray arrayWithArray:tempArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([self.delegate respondsToSelector:@selector(didFetchNearbyPlacesSuccessfully)]) {
                    [self.delegate didFetchNearbyPlacesSuccessfully];
                }
            });
            
        }
        else if (error.code != kCFURLErrorCancelled) {
            if ([self.delegate respondsToSelector:@selector(didFailToFetchNearbyPlacesWithError:)]) {
                [self.delegate didFailToFetchNearbyPlacesWithError:error];
            }
        }
    }];
    
    [postDataTask resume];

}

@end
