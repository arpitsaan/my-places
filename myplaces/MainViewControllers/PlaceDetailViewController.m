//
//  PlaceDetailViewController.m
//  myplaces
//
//  Created by Arpit Agarwal on 29/02/16.
//  Copyright © 2016 saanspit. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "AppDelegate.h"
#import "CDPlaceDetails.h"
#import "PlacePhotoCell.h"
#import "PlaceMapViewController.h"

@interface PlaceDetailViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *mainTableView;
    NSMutableArray *detailKeysArray;
    NSMutableArray *detailValuesArray;
}
@property(nonatomic, strong) PlaceDetail *placeObj;
@end

@implementation PlaceDetailViewController

- (instancetype)initWithPlace:(PlaceDetail *)placeDetail {
    self = [super init];
    
    if (self) {
        self.placeObj = placeDetail;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupData];
    [self setupDefaults];
    [self setupHeader];
    [self createViews];
}

- (void)setupData {
    detailKeysArray = [[NSMutableArray alloc] initWithObjects:@"Name" ,@"Vicinity", @"Place Id", nil];
    detailValuesArray = [[NSMutableArray alloc] initWithObjects:self.placeObj.name, self.placeObj.vicinity, self.placeObj.placeId, nil];
}

- (void)setupDefaults {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupHeader{
    [self.navigationItem setTitle:self.placeObj.name];
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addToFavoritesPressed)];
    
    self.navigationItem.rightBarButtonItem = addButtonItem;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        PlacePhotoCell *photoCell = [tableView dequeueReusableCellWithIdentifier:@"PlacePhotoCell"];
        if (!photoCell) {
            photoCell = [[PlacePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlacePhotoCell" placeDetailsObj:self.placeObj];
        }
        return photoCell;
    }
    
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeOnMapCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeeOnMapCell"];
        }
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"See on Map"];
        [cell.textLabel setTextColor:[UIColor lightGrayColor]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        return cell;
    }
    
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
        }
        [cell.textLabel setText:[detailKeysArray objectAtIndex:indexPath.row-2]];
        [cell.detailTextLabel setText:[detailValuesArray objectAtIndex:indexPath.row-2]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        PlaceMapViewController *mapVC = [[PlaceMapViewController alloc] initWithPlace:self.placeObj];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
    }
    
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2+[detailKeysArray count];
}

#pragma mark - Selectors
- (void)addToFavoritesPressed {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSEntityDescription *entityDesc = [NSEntityDescription  entityForName:@"CDPlaceDetails" inManagedObjectContext:[delegate managedObjectContext]];
    CDPlaceDetails *placeDetailsObj = [[CDPlaceDetails alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:[delegate managedObjectContext]];

    [placeDetailsObj setWithPlaceDetailObj:self.placeObj];
    
    [delegate saveContext];
    
    NSString *message = [NSString stringWithFormat:@"%@ added as a favorite place. See it in your favorites tab.", self.placeObj.name];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added to Favorites!" message:message delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideAddButton {
    [self.navigationItem setRightBarButtonItem:nil];
}

@end
