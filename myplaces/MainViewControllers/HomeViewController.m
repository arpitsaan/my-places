//
//  HomeViewController.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "HomeViewController.h"
#import "PlaceDetail.h"
#import "HomePlaceCell.h"
#import "HomeLocationCell.h"
#import "MPLocationManager.h"
#import "PlacesListViewController.h"

typedef NS_ENUM(NSInteger, SectionType){
    SectionTypeLocation = 0,
    SectionTypePlaces = 1,
    
    SectionTypeCount = 2
};

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *mainTableView;
    HomeLocationCellState cellStateToSet;
    
    UIActivityIndicatorView *locationLoader;
}
@property(nonatomic, strong) NSArray *placeTypesArray;
@end

@implementation HomeViewController


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self performSelector:@selector(detectLocation) withObject:nil afterDelay:3.5f];
}

- (void)detectLocation {
    [[MPLocationManager sharedInstance] refreshLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaults];
    [self setupData];
    [self createViews];
    [self registerForNofications];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)registerForNofications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdateStarted) name:kNotificationUserLocationUpdateStarted object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdateSuccessful) name:kNotificationUserLocationUpdatedSuccessfully object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdateFailed) name:kNotificationUserLocationUpdateFailed object:nil];
}

- (void)setupDefaults {
    [self.navigationItem setTitle:@"Locating you..."];
    cellStateToSet = HomeLocationCellStateDetecting;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


#pragma mark - Data
- (void)setupData {
    self.placeTypesArray = [self getPlaceTypesArray];
}

- (NSArray *)getPlaceTypesArray {
        //    https://developers.google.com/places/supported_types
    return [NSArray arrayWithObjects:@"­Atm", @"Hospital", @"School", @"Gym", @"Cafe", nil];
}


#pragma mark - View Methods
- (void)createViews {
    [self setupHeader];
    [self createMainTableView];
}

- (void)setupHeader {
    locationLoader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.navigationItem.titleView addSubview:locationLoader];
    [locationLoader setCenter:CGPointMake(W(self.view) - W(locationLoader) - 15.0f, H(self.navigationItem.titleView)/2)];
    [locationLoader setHidesWhenStopped:YES];
}

- (void)createMainTableView {
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W(self.view), H(self.view)-69.0f) style:UITableViewStylePlain];
    
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:mainTableView];
}

#pragma mark - UITableViewDelegate , UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == SectionTypePlaces) {
        PlacesListViewController *placesListVC = [[PlacesListViewController alloc] initWithTypeString:[self.placeTypesArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:placesListVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (cellStateToSet!=HomeLocationCellStateDetectedSuccessfully) {
        return 1;
    }
    return SectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case SectionTypeLocation:
            return 1;
            break;
            
        case SectionTypePlaces:
            return [self.placeTypesArray count];
            break;
            
        default:
            break;
    }
    
    //failsafe
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            
        case SectionTypeLocation:{
            HomeLocationCell *locationCell = [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
            
            if (!locationCell) {
                locationCell = [[HomeLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"locationCell"];
            }
            
            if ([self getHomeLocationCellState] == HomeLocationCellStateDetectedSuccessfully) {
                [locationCell setCurrentLocation:[[MPLocationManager sharedInstance] getLastKnownLocation]];
            }
            
            [locationCell setCellState:[self getHomeLocationCellState] animated:YES];
            
            return locationCell;
        }
            break;
         
        case SectionTypePlaces: {
            HomePlaceCell *placeCell = [tableView dequeueReusableCellWithIdentifier:@"HomePlaceCell"];
            
            if (!placeCell) {
                placeCell = [[HomePlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePlaceCell"];
            }

            NSString *placeTypeString = [self.placeTypesArray objectAtIndex:indexPath.row];
            [placeCell.textLabel setText:placeTypeString];
            
            return placeCell;
        }
            break;
            
        default:
            break;
    }
    
    //failsafe
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case SectionTypeLocation:{
            return [HomeLocationCell getHeightWithState:[self getHomeLocationCellState]];
        }
            break;
            
        case SectionTypePlaces: {
            return 50.0f;
        }
            break;
            
        default:
            break;
    }
    
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == SectionTypePlaces) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, W(tableView), 44.0f)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 15.0f, W(tableView), 20.0f)];
        [label setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
        [label setTextColor:[UIColor lightGrayColor]];
        [label setText:@"Explore places by type"];
        [label setBackgroundColor:[UIColor whiteColor]];
        [view addSubview:label];
        return view;
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == SectionTypePlaces) {
        return 44.0f;
    }
    return 0.0f;
}

- (HomeLocationCellState)getHomeLocationCellState {
    return cellStateToSet;
}

#pragma mark - Helpers
- (void)refreshTable {
    [mainTableView reloadData];
}

#pragma mark - MPLocationManager Notifications
- (void)locationUpdateStarted {
    [locationLoader startAnimating];
    [self.navigationItem setTitle:@"Locating you..."];
    cellStateToSet = HomeLocationCellStateDetecting;
    [self refreshTable];
}

- (void)locationUpdateSuccessful {
    cellStateToSet = HomeLocationCellStateDetectedSuccessfully;
    [locationLoader stopAnimating];
    [self.navigationItem setTitle:@"Discover places near you"];
    [self refreshTable];
}

- (void)locationUpdateFailed {
    cellStateToSet = HomeLocationCellStateError;

    [locationLoader stopAnimating];
    [self.navigationItem setTitle:@"Location unavailable"];
    
    [self refreshTable];
}

#pragma mark - Misc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
