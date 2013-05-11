//
//  BrowseMode.m
//  Lawesome
//
//  Created by Marco Schnüriger on 30.10.12.
//  Copyright (c) 2012 2am Development. All rights reserved.
//

#import "BrowseMode.h"
#import "Network.h"
#import "Data.h"
#import "BookViewMaster.h"

@interface BrowseMode ()

@end
static BrowseMode *sharedBrowseMode;
@implementation BrowseMode
@synthesize tableView;
@synthesize elements;
@synthesize download;
@synthesize sub;
@synthesize page;
@synthesize activityIndicator;
@synthesize activityBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sharedBrowseMode = self;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    sharedBrowseMode = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.backItem.hidesBackButton = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    if ([Data sharedData].firstPage == YES) {
        [Network getEntriesForPage:@""];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

+(BrowseMode*)sharedBrowseMode {
    return sharedBrowseMode;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [elements count];
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // See if there's an existing cell we can reuse
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        // No cell to reuse => create a new one
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    // Customize cell
    NSArray *temp = [elements objectAtIndex:indexPath.row];
    id object = [temp objectAtIndex:0];
    NSString *text = @"";
    NSString *subText = @"";
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *newTemp = [temp objectAtIndex:1];
        subText = [temp objectAtIndex:2];
        text = [newTemp objectAtIndex:indexPath.row];
        
    } else {
        text = [temp objectAtIndex:1];
    }
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = text;
    cell.detailTextLabel.text = subText;
    // TODO: Any other customization
    //       (Possibly look up subviews by tag and populate based on indexPath.)
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *temp = [elements objectAtIndex:indexPath.row];
    NSString *link = (NSString*)[temp objectAtIndex:0];
    if ([link isKindOfClass:[NSMutableArray class]]) {
        NSArray *fail = link;
        link = [fail objectAtIndex:0];
    }
    if ([link rangeOfString:@"#"].location == NSNotFound) {
        if ([link rangeOfString:@"c"].location == NSNotFound) {
            NSLog(@"overview page");
            [Network getEntriesForPage:link];
        } else {
            NSLog(@"download book with link: %@", link);
            //download
            [Network getBookContent:link];
        }
    } else {
        if ([link rangeOfString:@".html"].location == NSNotFound) {
            //sub
            NSLog(@"sub");
            link = [link stringByReplacingOccurrencesOfString:@"#" withString:@""];
            [Network getEntriesForPage:[Data sharedData].lastLink andSub:link];
        } else {
            //sub with other reference
            NSLog(@"sub with other reference");
            NSRange range = [link rangeOfString:@"#" options:NSBackwardsSearch];
            NSRange subRange;
            subRange.location = range.location;
            subRange.location++;
            subRange.length = link.length - range.location;
            subRange.length = subRange.length-1;
            NSString *subLink = [link substringWithRange:subRange];
            NSRange linkRange;
            linkRange.location = 0;
            linkRange.length = range.location;
            link = [link substringWithRange:linkRange];
            [Network getEntriesForPage:link andSub:subLink];
        }
    }
    [Data sharedData].lastLink = link;
}

-(void)nextNavigationPoint:(NSMutableArray*)newElements title:(NSString*)newTitle{
    BrowseMode *mode = [[BrowseMode alloc] initWithNibName:@"BrowseMode_iPhone" bundle:nil];
    mode.elements = newElements;
    mode.title = newTitle;
    [self.navigationController pushViewController:mode animated:YES];
}

-(void)showActivityIndicator {
    NSLog(@"shouldshowindicator");
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.frame =  CGRectMake(126, 195, 50, 50);
    [activityIndicator setColor:[UIColor whiteColor]];
    self.activityBackground = [[UIView alloc] initWithFrame:CGRectMake(110, 190, 80, 60)];
    [self.activityBackground setBackgroundColor:[UIColor blackColor]];
    [self.activityBackground setAlpha:0.7];
    [self.activityIndicator setAlpha:1.0];
    [self.navigationController.view addSubview:activityIndicator];
    [self.navigationController.view addSubview:activityBackground];
    [self.navigationController.view bringSubviewToFront:activityBackground];
    [self.navigationController.view bringSubviewToFront:activityIndicator];
    [activityIndicator startAnimating];
}

-(void)hideActivityIndicator {
    NSLog(@"should hide");
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    [self.activityBackground removeFromSuperview];
}

@end
