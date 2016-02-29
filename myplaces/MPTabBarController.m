//
//  MPTabBarController.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "MPTabBarController.h"
#import "MPNavigationController.h"
#import "MPConstants.h"
#import "HomeViewController.h"
#import "FavoritesViewController.h"

@interface MPTabBarController ()

@end

@implementation MPTabBarController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupDefaults];
        [self setupTabBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupDefaults{
    [self.tabBar setClipsToBounds:NO];
    [self.tabBar setBarStyle:UIBarStyleDefault];
}

- (void)setupTabBar{
    
    //View Controllers
    MPNavigationController *homeVC = [self homeViewController];
    MPNavigationController *favoritesVC = [self favoritesViewController];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    for(int i = 0; i<kTabIndexCount; i++) [vcArray addObject: [NSNull null]];
    
    [vcArray replaceObjectAtIndex:kTabIndexHome withObject:homeVC];
    [vcArray replaceObjectAtIndex:kTabIndexFavorites withObject:favoritesVC];
    [self setViewControllers:vcArray animated:YES];
    
    //Tab Bar Items
    UITabBarItem *homeTB = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:kTabIndexHome];
    [homeVC setTabBarItem:homeTB];
    
    UITabBarItem *favoritesTB = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:kTabIndexFavorites];
    [favoritesVC setTabBarItem:favoritesTB];
}


- (MPNavigationController *)homeViewController{
    HomeViewController *viewController = [[HomeViewController alloc] init];
    MPNavigationController *navigationController = [[MPNavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (MPNavigationController *)favoritesViewController{
    FavoritesViewController *favVC = [[FavoritesViewController alloc] init];
    [favVC.view setBackgroundColor:[UIColor whiteColor]];
    MPNavigationController *navigationController = [[MPNavigationController alloc] initWithRootViewController:favVC];
    return navigationController;
}

@end
