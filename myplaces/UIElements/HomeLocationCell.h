//
//  HomeLocationCell.h
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, HomeLocationCellState) {
    HomeLocationCellStateDetecting,
    HomeLocationCellStateError,
    HomeLocationCellStateDetectedSuccessfully,
    HomeLocationCellStateNoPermission
};

@interface HomeLocationCell : UITableViewCell

@property(nonatomic, strong) CLLocation *currentLocation;

- (void)setCellState:(HomeLocationCellState)state animated:(BOOL)animated;

+ (CGFloat)getHeightWithState:(HomeLocationCellState)state;

@end
