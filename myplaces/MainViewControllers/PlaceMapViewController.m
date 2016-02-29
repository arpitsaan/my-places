//
//  PlaceMapViewController.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "PlaceMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface PlaceMapViewController ()
@property (nonatomic, strong) PlaceDetail *placeObj;
@end

@implementation PlaceMapViewController
- (instancetype)initWithPlace:(PlaceDetail *)placeObj {
    self = [super init];
    
    if (self) {
        self.placeObj = placeObj;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaults];
    [self setupHeader];
    [self createMapView];
}

- (void)setupDefaults{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupHeader {
    [self.navigationItem setTitle:self.placeObj.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createMapView {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.placeObj.lat.doubleValue longitude:self.placeObj.lng.doubleValue zoom:14.0f];
    GMSMapView  *googleMapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    [googleMapView setMyLocationEnabled:YES];
    
    GMSMarker *placeMarker = [[GMSMarker alloc] init];
    placeMarker.position = CLLocationCoordinate2DMake(self.placeObj.lat.doubleValue, self.placeObj.lng.doubleValue);
    placeMarker.title = self.placeObj.name;
    placeMarker.snippet = self.placeObj.vicinity;
    placeMarker.map = googleMapView;
    
    [self.view addSubview:googleMapView];
}
@end
