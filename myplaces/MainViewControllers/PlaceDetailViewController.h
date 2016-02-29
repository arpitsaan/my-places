//
//  PlaceDetailViewController.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPBaseViewController.h"
#import "PlaceDetail.h"

@interface PlaceDetailViewController : MPBaseViewController

- (instancetype)initWithPlace:(PlaceDetail *)placeDetail;

- (void)hideAddButton;

@end
