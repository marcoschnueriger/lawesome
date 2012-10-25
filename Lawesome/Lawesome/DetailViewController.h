//
//  DetailViewController.h
//  Lawesome
//
//  Created by Marco Schnüriger on 25.10.12.
//  Copyright (c) 2012 2am Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
