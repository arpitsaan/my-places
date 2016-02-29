//
//  ListPlaceCell.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "ListPlaceCell.h"

@implementation ListPlaceCell

- (void)baseInit{
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
        [self baseInit];
        [self setupViews];
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupDefaults];
        [self baseInit];
        [self setupViews];
    }
    return self;
}

- (void)setupDefaults {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

- (void)setupViews{
    [self.imageView setFrame:CGRectMake(15.0f, 15.0f, 40.0f, 40.0f)];
    [self.imageView setBackgroundColor:[UIColor lightGrayColor]];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView.layer setMasksToBounds:YES];
    
    [self.textLabel  setTextAlignment:NSTextAlignmentLeft];
    [self.textLabel setNumberOfLines:1];
    [self.textLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.textLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    
    [self.detailTextLabel setTextAlignment:NSTextAlignmentLeft];
    [self.detailTextLabel setTextColor:[UIColor grayColor]];
    [self.detailTextLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]];
    [self.detailTextLabel setHidden:NO];
}


#pragma mark - Custom Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(15.0f, 15.0f, 40.0f, 40.0f)];
    [self.textLabel setFrame:CGRectMake(AFTER(self.imageView) + 15.0f, Y(self.textLabel), W(self) - W(self.imageView) - 3*15.0f, H(self.textLabel))];
    [self.detailTextLabel setFrame:CGRectMake(X(self.textLabel) + 15.0f, Y(self.textLabel)+H(self.textLabel), W(self) - W(self.imageView) - 3*15.0f, H(self.detailTextLabel))];
    [self setSeparatorInset:UIEdgeInsetsMake(0.0f, 15.0f, 0, 0)];
}

- (void)prepareForReuse{
    [super prepareForReuse];
    
    [self.imageView setImage:nil];
    [self.textLabel setText:@""];
    [self.detailTextLabel setText:@""];
}


- (void)setPlaceObject:(PlaceDetail *)placeObject {
    _placeObject = placeObject;
    
    [self.imageView setImageWithUrl:[NSURL URLWithString:_placeObject.icon]];
    [self.textLabel setText:_placeObject.name];
    [self.detailTextLabel setText:_placeObject.vicinity];
}

+ (CGFloat)cellHeight{
    return 54.0f;
}
@end
