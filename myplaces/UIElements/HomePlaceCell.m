//
//  HomePlaceCell.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "HomePlaceCell.h"

@implementation HomePlaceCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupDefaults];
    }
    
    return self;
}

- (void)setupDefaults {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

@end
