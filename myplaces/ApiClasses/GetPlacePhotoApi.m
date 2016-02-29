//
//  GetPlacePhotoApi.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "GetPlacePhotoApi.h"

@interface GetPlacePhotoApi () <NSURLSessionDelegate>
@property (nonatomic, weak)id<GetPlacePhotoApiDelegate> delegate;
@property (nonatomic) BOOL isRunning;
@property (nonatomic, strong) NSString *imgReference;
@end

@implementation GetPlacePhotoApi
- (void)fetchPlacePhotoWithPlace:(PlaceDetail *)placeDetail delegate:(id<GetPlacePhotoApiDelegate>) delegate {
    
    if (self.isRunning) {
        return;
    }
    
    self.imgReference = placeDetail.referenceId;
    
    [self doApiCall];
}

- (NSURL *)getAPIUrl {
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=%@",
                           self.imgReference,
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

            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([self.delegate respondsToSelector:@selector(didFetchPlacePhotoSuccessfully)]) {
                    [self.delegate didFetchPlacePhotoSuccessfully];
                }
            });
            
        }
        else if (error.code != kCFURLErrorCancelled) {
            dispatch_async(dispatch_get_main_queue(), ^{

            if ([self.delegate respondsToSelector:@selector(didFailToFetchPlacePhotoWithError:)]) {
                [self.delegate didFailToFetchPlacePhotoWithError:error];
            }
            });
        }
    }];
    
    [postDataTask resume];
    
}

@end