//
//  CDPlaceDetails+CoreDataProperties.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDPlaceDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDPlaceDetails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *lat;
@property (nullable, nonatomic, retain) NSNumber *lng;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *placeId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *referenceId;
@property (nullable, nonatomic, retain) NSString *vicinity;

@end

NS_ASSUME_NONNULL_END
