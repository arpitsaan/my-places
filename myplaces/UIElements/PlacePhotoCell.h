//
//  PlacePhotoCell.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceDetail.h"

@interface PlacePhotoCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier placeDetailsObj:(PlaceDetail *)placeDetailObject;

@end
