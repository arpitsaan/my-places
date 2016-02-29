//
//  ListPlaceCell.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceDetail.h"

@interface ListPlaceCell : UITableViewCell

@property(nonatomic, strong) PlaceDetail *placeObject;

+ (CGFloat)cellHeight;
@end