//
//  BookViewMaster.h
//  Lawesome
//
//  Created by Marco Schnüriger on 22.03.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@class BookViewDetail;

@interface BookViewMaster : UITableViewController

@property (strong, nonatomic) BookViewDetail *bookViewDetail;
@property (strong, nonatomic) NSMutableArray *objects;
@property (strong, nonatomic) Book *book;
@property (readwrite, assign) int level;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *articlesToPresent;
@property (strong, nonatomic) NSMutableArray *bookElementsToPresent;

//level 0 first level titels
//level 1 second level titels
//level 2 thirst level titels
//level 3 show articles
//level 4 show titles in a multiple chapter book
@end
