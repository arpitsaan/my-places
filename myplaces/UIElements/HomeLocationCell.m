//
//  HomeLocationCell.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "HomeLocationCell.h"
#import <GoogleMaps/GoogleMaps.h>

@interface HomeLocationCell (){
    UIView *detectingLocationView;
    UIView *myLocationView;
    UIView *errorView;
    UIView *noPermissionView;
    
    //detecting location
    UIView *dotView;
    UIView *animationCircle;
    
    //map view
    GMSMapView *googleMapView;
}
@property(nonatomic) HomeLocationCellState cellState;
@end

@implementation HomeLocationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupDefaults];
        [self createViews];
    }
    
    return self;
}

- (void)setupDefaults{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)createViews {
    [self createDetectingLocationView];
    [self createMyLocationView];
    [self createErrorView];
    [self createNoPermissionView];
}

- (void)createDetectingLocationView {
    [detectingLocationView removeFromSuperview];
    detectingLocationView = nil;
    
    detectingLocationView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:detectingLocationView];
    
    dotView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 8.0f, 8.0f)];
    [dotView setBackgroundColor:[UIColor orangeColor]];
    [dotView.layer setCornerRadius:4.0f];
    [dotView.layer setMasksToBounds:YES];
    [dotView setCenter:CGPointMake(W(self)/2, H(self)/2)];
    [detectingLocationView addSubview:dotView];
    
    animationCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [animationCircle.layer setCornerRadius:20.0f/2];
    [animationCircle.layer setMasksToBounds:YES];
    [animationCircle setBackgroundColor:[UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:0.2f]];
    [animationCircle setCenter:dotView.center];
    [animationCircle.layer setBorderColor:[[UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:0.8f] CGColor]];
    [animationCircle.layer setBorderWidth:0.05f];
    [detectingLocationView addSubview:animationCircle];
    
    [self animatePulse:animationCircle];
}

- (void)createMyLocationView{
    [myLocationView removeFromSuperview];
    myLocationView = nil;
    
    myLocationView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:myLocationView];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude zoom:14.0f];
    googleMapView = [GMSMapView mapWithFrame:self.bounds camera:camera];
    [googleMapView setMyLocationEnabled:YES];
    [myLocationView setUserInteractionEnabled:NO];
    
    [myLocationView addSubview:googleMapView];
}

- (void)createErrorView{
    
}

- (void)createNoPermissionView{
    
}

- (void)animatePulse:(UIView *)view{
    [view setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
    
    [UIView animateWithDuration:1.8f delay:0.2f options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionRepeat animations:^{
        [view setTransform:CGAffineTransformMakeScale(8.0f, 8.0f)];
        [view setAlpha:0.0f];
    } completion:^(BOOL finished) {
    }];
}

- (void)setCellState:(HomeLocationCellState)state animated:(BOOL)animated {
    _cellState = state;
    
    UIView *viewToShow;
    switch (_cellState) {
        case HomeLocationCellStateDetectedSuccessfully: {
            viewToShow = myLocationView;
        }
            break;
            
        case HomeLocationCellStateDetecting: {
            viewToShow = detectingLocationView;
        }
            break;
            
        case HomeLocationCellStateError: {
            viewToShow = errorView;
        }
            break;
            
        case HomeLocationCellStateNoPermission: {
            viewToShow = noPermissionView;
        }
            break;
            
        default:
            break;
    }
    
    [detectingLocationView setHidden:YES];
    [myLocationView setHidden:YES];
    [errorView setHidden:YES];
    [noPermissionView setHidden:YES];
    
    [viewToShow setHidden:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //detecting location view
    [detectingLocationView setFrame:CGRectMake(0, 0, W(self), H(self))];
    [detectingLocationView setCenter:self.center];
    [dotView setCenter:CGPointMake(W(self)/2, H(self)/2)];
    [animationCircle setCenter:CGPointMake(W(self)/2, H(self)/2)];
    
    //google maps
    [myLocationView setFrame:self.bounds];
    [googleMapView setFrame:self.bounds];
}

- (void)setCurrentLocation:(CLLocation *)currentLocation{
    _currentLocation = currentLocation;
    [self createMyLocationView];
}

+ (CGFloat)getHeightWithState:(HomeLocationCellState)state {
    CGFloat height = 0.0f;
    switch (state) {
        case HomeLocationCellStateDetectedSuccessfully:{
            height = 200.0f;
        }
            break;
            
        case HomeLocationCellStateNoPermission: {
            
        }
            break;
            
        case HomeLocationCellStateDetecting:{
            height = 200.0f;
        }
            break;
            
        case HomeLocationCellStateError: {
            
        }
            break;
            
        default:
            break;
    }

    return height;
}

@end
