//
//  PlacePhotoCell.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "PlacePhotoCell.h"
#import "GetPlacePhotoApi.h"

@interface PlacePhotoCell ()<GetPlacePhotoApiDelegate>{
    UIImageView* mainImageView;
    UIActivityIndicatorView *loader;
}
@property(nonatomic, strong) GetPlacePhotoApi *placePhotoApi;
@property(nonatomic, strong) PlaceDetail *placeDetailsObj;
@end

@implementation PlacePhotoCell
- (void)baseInit {
    self.placePhotoApi = [[GetPlacePhotoApi alloc] init];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier placeDetailsObj:(PlaceDetail *)placeDetailObject {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self baseInit];
        self.placeDetailsObj = placeDetailObject;
        
        [self createViews];
        [self getPhoto];
    }
    return self;
}

- (void)createViews{
    //image view
    mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [mainImageView setContentMode:UIViewContentModeScaleAspectFill];
    [mainImageView setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.8]];
    [mainImageView setClipsToBounds:YES];
    [self addSubview:mainImageView];
    
    [self setClipsToBounds:YES];
    
    //loader
    loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [self addSubview:loader];
    [loader setHidesWhenStopped:YES];
}

- (void)getPhoto {
    [loader startAnimating];
    [mainImageView setImageWithUrl:[NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2015/11/26/08/29/palace-1063473_960_720.jpg"]];
    [self.placePhotoApi fetchPlacePhotoWithPlace:self.placeDetailsObj delegate:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [loader setCenter:CGPointMake(W(self)/2, H(self)/2)];
    [mainImageView setFrame:CGRectMake(0, 0, W(self), H(self))];
}


#pragma mark - GetPlacePhotoApiObject
- (void)didFetchPlacePhotoSuccessfully {
    
}

- (void)didFailToFetchPlacePhotoWithError:(NSError *)error {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
