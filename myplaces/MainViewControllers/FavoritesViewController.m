//
//  FavoritesViewController.m
//  myplaces
//
//  Created by Arpit Agarwal on 28/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "FavoritesViewController.h"
#import "CDPlaceDetails.h"
#import "PlaceDetail.h"
#import "AppDelegate.h"
#import "PlaceDetailViewController.h"

@interface FavoritesViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *mainTableView;
}
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, strong) NSArray *favoritePlacesArray;
@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDefaults];
    [self setupHeader];
    [self createViews];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)setupHeader{
    [self.navigationItem setTitle:@"My Favorite Places"];
}

- (void)reloadTable {
    [mainTableView reloadData];
}

- (void)setupDefaults {
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
    PlaceDetail *place = [self.favoritePlacesArray objectAtIndex:indexPath.row];
    PlaceDetailViewController *placeVC = [[PlaceDetailViewController alloc] initWithPlace:place];
    [self.navigationController pushViewController:placeVC animated:YES];
    [placeVC hideAddButton];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favoritePlacesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *placeListCell = [tableView dequeueReusableCellWithIdentifier:@"placeListCell"];
    
    if (!placeListCell) {
        placeListCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"placeListCell"];
        [placeListCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    PlaceDetail *placeDetailObj = [self.favoritePlacesArray objectAtIndex:indexPath.row];
    [placeListCell.textLabel setText:placeDetailObj.name];
    [placeListCell.detailTextLabel setText:placeDetailObj.vicinity];
    
    return placeListCell;
}

#pragma mark - Data
- (void)refreshData{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDPlaceDetails"
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (CDPlaceDetails *cdPlaceDetails in fetchedObjects) {
        PlaceDetail *details = [cdPlaceDetails getPlaceDetailObj];
        [tempArray addObject:details];
    }
    
    self.favoritePlacesArray = [NSArray arrayWithArray:tempArray];
    [self reloadTable];
}

#pragma mark - Misc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
