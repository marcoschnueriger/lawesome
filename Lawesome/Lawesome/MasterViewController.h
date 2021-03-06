//
//  MasterViewController.h
//  Lawesome
//
//  Created by Marco Schnüriger on 25.10.12.
//  Copyright (c) 2012 2am Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    NSArray *array;
    NSMutableArray *navigationSourceLinks;
    NSMutableArray *currentLinks;
    NSMutableArray *currentTexts;
    int navigationlevel;
    NSOperationQueue *webQueue;
    NSString *lastUrl;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
