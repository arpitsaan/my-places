//
//  CDPlaceDetails.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "CDPlaceDetails.h"

@implementation CDPlaceDetails

- (void)setWithPlaceDetailObj:(PlaceDetail *)placeDetailObj {
    self.icon = placeDetailObj.icon;
    self.name = placeDetailObj.name;
    self.placeId = placeDetailObj.placeId;
    self.referenceId = placeDetailObj.referenceId;
    self.vicinity = placeDetailObj.vicinity;
    self.lat = placeDetailObj.lat;
    self.lng = placeDetailObj.lng;
}

- (PlaceDetail *)getPlaceDetailObj {
    PlaceDetail *placeDetailObj = [[PlaceDetail alloc] init];
    placeDetailObj.icon = self.icon;
    placeDetailObj.name = self.name;
    placeDetailObj.placeId = self.placeId;
    placeDetailObj.referenceId = self.referenceId;
    placeDetailObj.vicinity = self.vicinity;
    placeDetailObj.lat = self.lat;
    placeDetailObj.lng = self.lng;
    
    return placeDetailObj;
}
@end
