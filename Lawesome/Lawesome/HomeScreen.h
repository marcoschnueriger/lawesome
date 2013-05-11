//
//  HomeScreen.h
//  Lawesome
//
//  Created by Marco Schnüriger on 30.10.12.
//  Copyright (c) 2012 2am Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreen : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate>
- (IBAction)BookModePressed:(id)sender;
- (IBAction)FavoritesPressed:(id)sender;
- (IBAction)BrowseModePressed:(id)sender;
- (IBAction)HelpPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;

@end
