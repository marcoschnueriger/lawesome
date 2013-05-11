//
//  HomeScreen.m
//  Lawesome
//
//  Created by Marco Schnüriger on 30.10.12.
//  Copyright (c) 2012 2am Development. All rights reserved.
//

#import "HomeScreen.h"
#import "FavoriteScreen.h"
#import "BrowseMode.h"
#import "HelpScreen.h"
#import "Data.h"
#import "Network.h"

@interface HomeScreen ()

@end

@implementation HomeScreen
@synthesize searchBar;
@synthesize searchDisplayController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showDownloadView)];
    // add searchbar
    searchDisplayController.delegate = self;
    searchBar.delegate = self;
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.leftBarButtonItem = searchBarItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showDownloadView{
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)BookModePressed:(id)sender {
    
}

- (IBAction)FavoritesPressed:(id)sender {
    FavoriteScreen *favScreen;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5) {
            favScreen = [[FavoriteScreen alloc]initWithNibName:@"FavoriteScreen_iPhone5" bundle:nil];
        } else {
            favScreen = [[FavoriteScreen alloc]initWithNibName:@"FavoriteScreen_iPhone" bundle:nil];
        }
    } else {
        favScreen = [[FavoriteScreen alloc]initWithNibName:@"FavoriteScreen_iPad" bundle:nil];
    }
    
    [self.navigationController pushViewController:favScreen animated:YES];
}

- (IBAction)BrowseModePressed:(id)sender {
    BrowseMode *browseMode;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5) {
            browseMode = [[BrowseMode alloc]initWithNibName:@"BrowseMode_iPhone5" bundle:nil];
        } else {
            browseMode = [[BrowseMode alloc]initWithNibName:@"BrowseMode_iPhone" bundle:nil];
        }
    } else {
        browseMode = [[BrowseMode alloc]initWithNibName:@"BrowseMode_iPad" bundle:nil];
    }
    [Data sharedData].firstPage = YES;
    [self.navigationController pushViewController:browseMode animated:YES];
}

- (IBAction)HelpPressed:(id)sender {
    HelpScreen *helpScreen;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5) {
            helpScreen = [[HelpScreen alloc]initWithNibName:@"HelpScreen_iPhone5" bundle:nil];
        } else {
            helpScreen = [[HelpScreen alloc]initWithNibName:@"HelpScreen_iPhone" bundle:nil];
        }
    } else {
        helpScreen = [[HelpScreen alloc]initWithNibName:@"HelpScreen_iPad" bundle:nil];
    }
    
    [self.navigationController pushViewController:helpScreen animated:YES];
}
- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
}
@end
