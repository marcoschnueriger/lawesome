//
//  BookViewMaster.m
//  Lawesome
//
//  Created by Marco Schnüriger on 22.03.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "BookViewMaster.h"
#import "BookViewDetail.h"
#import "BookElement.h"
#import "Article.h"

@interface BookViewMaster ()

@end

@implementation BookViewMaster
@synthesize objects = _objects;
@synthesize bookViewDetail;
@synthesize book;
@synthesize title;
@synthesize bookElementsToPresent;
@synthesize articlesToPresent;
@synthesize level;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.backItem.hidesBackButton = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int value = 0;
    if (level == 0) {
        value =  [book.elements count];
    }
    
    if (level == 1) {
        value = [bookElementsToPresent count];
    }
    if (level == 2) {
        value = [bookElementsToPresent count];
    }
    if (level == 3) {
        value = [articlesToPresent count];
    }
    if (level == 4) {
        value = 0;
    }
    return value;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    NSString *string = @"";
    if (level == 0) {
        BookElement *be = book.elements[indexPath.row];
        string = be.title;
    }
    if (level == 1) {
        BookElement *be = bookElementsToPresent[indexPath.row];
        string = be.title;
    }
    if (level == 2) {
        BookElement *be = bookElementsToPresent[indexPath.row];
        string = be.title;
    }
    if (level == 3) {
        Article *art = articlesToPresent[indexPath.row];
        string = art.title;
    }
    cell.textLabel.text = string;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookViewMaster *master = [[BookViewMaster alloc] initWithNibName:@"BookViewMaster_iPhone" bundle:nil];
    if ( level == 0 ) {
        master.level = 1;
        BookElement *element = [book.elements objectAtIndex:indexPath.row];
        if ([element.subElements count] != 0) {
            master.bookElementsToPresent = element.subElements;
            [self.navigationController pushViewController:master animated:YES];
        } else {
            master.level = 4;
        }
    }
    
    if ( level == 1 ) {
        master.level = 2;
    }
    
    if ( level == 2 ) {
        master.level = 3;
    }
    
    if ( level == 3 ) {
        
    }
    
    if (level == 4 ) {
        bookViewDetail = [[BookViewDetail alloc] initWithNibName:@"BookViewDetail_iPhone" bundle:nil];
        [self.navigationController pushViewController:bookViewDetail animated:YES];
    }
}

@end
