//
//  BrowseMode.h
//  Lawesome
//
//  Created by Marco Schnüriger on 30.10.12.
//  Copyright (c) 2012 2am Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseMode : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *elements;
@property (strong, nonatomic) NSString *download;
@property (strong, nonatomic) NSString *page;
@property (strong, nonatomic) NSString *sub;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIView *activityBackground;
+(BrowseMode*)sharedBrowseMode;
-(void)nextNavigationPoint:(NSMutableArray*)newElements title:(NSString*)newTitle;
-(void)showActivityIndicator;
-(void)hideActivityIndicator;
@end
