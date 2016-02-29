//
//  PlaceDetail.h
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceDetail : NSObject

@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *placeId;
@property(nonatomic, strong) NSString *referenceId;
@property(nonatomic, strong) NSString *vicinity;
@property(nonatomic, strong) NSNumber *lat;
@property(nonatomic, strong) NSNumber *lng;

@end
