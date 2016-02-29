//
//  PlacesListViewController.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "PlacesListViewController.h"
#import "GetNearbyPlacesApi.h"
#import "MPLocationManager.h"
#import "ListPlaceCell.h"
#import "PlaceDetailViewController.h"

@interface PlacesListViewController () <GetNearbyPlacesApiDelegate, UITableViewDataSource, UITableViewDelegate>{
    UITableView *mainTableView;
    UIActivityIndicatorView *loadingIndicator;
}
@property(nonatomic, strong) GetNearbyPlacesApi *nearbyPlacesApiObj;
@property(nonatomic, strong) NSString *typeString;

@end

@implementation PlacesListViewController
- (void)baseInit {
    self.typeString = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [loadingIndicator removeFromSuperview];
}

- (instancetype)initWithTypeString:(NSString *)type {
    self = [super init];
    
    if (self) {
        [self baseInit];
        self.typeString = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaults];
    [self getData];
    [self setupHeader];
    [self createViews];
}

- (void)setupHeader {
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.navigationController.navigationBar addSubview:loadingIndicator];
    [loadingIndicator setHidden:NO];
    [loadingIndicator startAnimating];
    [loadingIndicator hidesWhenStopped];
    [loadingIndicator setFrame:CGRectMake(W(self.view)-W(loadingIndicator)-15.0f, 12.0f, W(loadingIndicator), H(loadingIndicator))];
    [self.navigationItem setTitle:@"Loading places..."];
}

- (void) setupDefaults{

}

- (void)getData {
    self.nearbyPlacesApiObj = [[GetNearbyPlacesApi alloc] init];
    [loadingIndicator startAnimating];
    [self.nearbyPlacesApiObj fetchNearbyPlacesWithType:self.typeString location:[[MPLocationManager sharedInstance] getLastKnownLocation] radius:@(2000) delegate:self];
}

- (void)createViews {
    [self createMainTableView];
}

- (void)createMainTableView {
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W(self.view), H(self.view)-69.0f)];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [self.view addSubview:mainTableView];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlaceDetail *place = [[self.nearbyPlacesApiObj placesArray] objectAtIndex:indexPath.row];
    PlaceDetailViewController *placeVC = [[PlaceDetailViewController alloc] initWithPlace:place];
    [self.navigationController pushViewController:placeVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.nearbyPlacesApiObj placesArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *placeListCell = [tableView dequeueReusableCellWithIdentifier:@"placeListCell"];
    
    if (!placeListCell) {
        placeListCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"placeListCell"];
        [placeListCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    PlaceDetail *placeDetailObj = [self.nearbyPlacesApiObj.placesArray objectAtIndex:indexPath.row];
    [placeListCell.textLabel setText:placeDetailObj.name];
    [placeListCell.detailTextLabel setText:placeDetailObj.vicinity];
    
    return placeListCell;
}

#pragma mark - GetNearbyPlacesApiDelegate
- (void)didFetchNearbyPlacesSuccessfully {
    [loadingIndicator stopAnimating];
    [loadingIndicator setHidden:YES];
    [self.navigationItem setTitle:self.typeString];
    [mainTableView reloadData];
    [self.view setNeedsDisplay];
}

- (void)didFailToFetchNearbyPlacesWithError:(NSError *)error {
    [loadingIndicator stopAnimating];
    [loadingIndicator setHidden:YES];
    [self.navigationItem setTitle:@"Something went wrong"];
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
