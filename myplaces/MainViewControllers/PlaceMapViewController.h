//
//  PlaceMapViewController.h
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPBaseViewController.h"
#import "PlaceDetail.h"

@interface PlaceMapViewController : MPBaseViewController

- (instancetype)initWithPlace:(PlaceDetail *)placeObj;

@end
