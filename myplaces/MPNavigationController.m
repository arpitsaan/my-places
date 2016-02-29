//
//  MPNavigationController.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPNavigationController.h"

@interface MPNavigationController ()

@end

@implementation MPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTheme];
}

- (void)setNavBarTheme {
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
