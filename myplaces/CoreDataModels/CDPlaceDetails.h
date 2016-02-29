//
//  CDPlaceDetails.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PlaceDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDPlaceDetails : NSManagedObject

- (void)setWithPlaceDetailObj:(PlaceDetail *)placeDetailObj;

- (PlaceDetail *)getPlaceDetailObj;

@end

NS_ASSUME_NONNULL_END

#import "CDPlaceDetails+CoreDataProperties.h"
