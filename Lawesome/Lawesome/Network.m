//
//  Network.m
//  Lawesome
//
//  Created by Marco Schnüriger on 14.03.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "Network.h"
#import "BrowseMode.h"
#import "SBJson.h"
#import "Data.h"
#import "BookViewMaster.h"
#import "Book.h"
#import "BookElement.h"
#import "NavigationContainer.h"
#import "Article.h"

@implementation Network

+(void)getEntriesForPage:(NSString *)page {
    [[BrowseMode sharedBrowseMode] showActivityIndicator];
    NSString *url = page;
    [Data sharedData].firstPage = YES;
    if ([page isEqualToString:@""]){
        url = @"http://2am-dev.ch/lawesome/test.php";
        [Data sharedData].firstPage = YES;
    } else {
        url = @"http://2am-dev.ch/lawesome/test.php?page=http://www.admin.ch/ch/d/sr/";
        url = [url stringByAppendingString:page];
        [Data sharedData].firstPage = NO;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *res, NSData *data, NSError *error){
        if (error){
        } else {
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSArray *array = [parser objectWithString:string];
            NSString *pageTitle = @"";
            pageTitle = [array objectAtIndex:0];
            [Data sharedData].tableElements = [array objectAtIndex:1];
            [Data sharedData].title = pageTitle;
            if ([Data sharedData].firstPage == YES) {
                [Network performSelectorOnMainThread:@selector(reloadBrowseTable) withObject:nil waitUntilDone:YES];
            } else {
                [Network performSelectorOnMainThread:@selector(nextNavigationPoint) withObject:nil waitUntilDone:YES];
            }
        }
    }];
}

+(void)reloadBrowseTable{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[Data sharedData].tableElements];
    [BrowseMode sharedBrowseMode].elements = array;
    [BrowseMode sharedBrowseMode].title = [Data sharedData].title;
    //[[BrowseMode sharedBrowseMode].activityIndicator stopAnimating];
    //[[BrowseMode sharedBrowseMode].activityIndicator removeFromSuperview];
    [[BrowseMode sharedBrowseMode] hideActivityIndicator];
    //refresh the table
    [[BrowseMode sharedBrowseMode].tableView reloadData];
    [[BrowseMode sharedBrowseMode] reloadInputViews];
}

+(void)nextNavigationPoint{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[Data sharedData].tableElements];
    //[[BrowseMode sharedBrowseMode].activityIndicator stopAnimating];
    //[[BrowseMode sharedBrowseMode].activityIndicator removeFromSuperview];
    [[BrowseMode sharedBrowseMode] hideActivityIndicator];
    [[BrowseMode sharedBrowseMode] nextNavigationPoint:array title:[Data sharedData].title];
    
}

+(void)getEntriesForPage:(NSString *)page andSub:(NSString*)sub{
    [[BrowseMode sharedBrowseMode] showActivityIndicator];
    NSString *url = page;
    url = @"http://2am-dev.ch/lawesome/test.php?page=http://www.admin.ch/ch/d/sr/";
    url = [url stringByAppendingString:page];
    url = [url stringByAppendingFormat:@"&sub=%@", sub];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *res, NSData *data, NSError *error){
        if (error){
            NSLog(error);
        } else {
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSArray *array = [parser objectWithString:string];
            NSString *pageTitle = @"";
            pageTitle = [array objectAtIndex:0];
            [Data sharedData].tableElements = [array objectAtIndex:1];
            [Data sharedData].title = pageTitle;
            if ([Data sharedData].firstPage == YES) {
                [Network performSelectorOnMainThread:@selector(reloadBrowseTable) withObject:nil waitUntilDone:YES];
            } else {
                [Network performSelectorOnMainThread:@selector(nextNavigationPoint) withObject:nil waitUntilDone:YES];
            }
        }
    }];
}

+(void)downloadBook:(NSString*)book {
    
}

+(void)hideActivityView{
    [[BrowseMode sharedBrowseMode].activityIndicator stopAnimating];
}

+(void)getBookContent:(NSString*)book {
    [[BrowseMode sharedBrowseMode] showActivityIndicator];
    NSString *url = [NSString stringWithFormat:@"http://2am-dev.ch/lawesome/test.php?download=%@", book ];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *res, NSData *data, NSError *error){
        if (error){
            NSLog(@"%@",[error description]);
        } else {
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *elements = [parser objectWithString:string];
            //[Network performSelectorOnMainThread:@selector(openBookMaster:) withObject:elements waitUntilDone:YES];
            //[Network performSelector:@selector(openBookMaster:) onThread:[[NSThread alloc] init] withObject:elements waitUntilDone:YES];
            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(openBookMaster:) object:elements];
            [thread start];
        }
    }];
}

+(void)openBookMaster:(NSDictionary*)elements{
    //NSLog([elements description]);
    NSMutableArray *bookElements = [[NSMutableArray alloc] init];
    Book *book = nil;
    if ([[elements valueForKey:@"flag"] isEqual:@"single"]) {
        NSArray *data = [elements valueForKey:@"data"];
        NSString *bookLink = [elements valueForKey:@"link"];
        NSString *bookTitle = [elements valueForKey:@"title"];
        for (int i = 0; i < [data count]; i++) {
            NSMutableArray *subElements = [[NSMutableArray alloc] init];
            NSDictionary *temp = nil;
            NSMutableArray *innerTemps = [[NSMutableArray alloc] init];
            if ([[data objectAtIndex:i ] valueForKey:@"sl"]) {
                NSDictionary *innerTemp = nil;
                if ([[[data objectAtIndex:i] valueForKey:@"sl"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *temp = [[data objectAtIndex:i] valueForKey:@"sl"];
                    NSArray *keys = [temp allKeys];
                    for (int i = 0; i < [keys count]; i++) {
                        innerTemp = [temp valueForKey:[keys objectAtIndex:i]];
                        [innerTemps addObject:innerTemp];
                    }
                }
                
                if ([[[data objectAtIndex:i] valueForKey:@"sl"] isKindOfClass:[NSArray class]]) {
                    NSArray *temp = [[data objectAtIndex:i] valueForKey:@"sl"];
                    //NSLog([[tempArray objectAtIndex:0] description]);
                    for (int i = 0; i < [temp count]; i++) {
                        innerTemp = [temp objectAtIndex:i];
                        [innerTemps addObject:innerTemp];
                    }
                }
                
                for (int i = 0; i < [innerTemps count]; i++) {
                    innerTemp = [innerTemps objectAtIndex:i];
                    NSMutableArray *innerSubElements = [[NSMutableArray alloc] init];
                    if ([innerTemp valueForKey:@"tl"]) {
                        NSDictionary *thirdLevel = nil;
                        if ([[innerTemp valueForKey:@"tl"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *temp = [innerTemp valueForKey:@"tl"];
                            NSArray *keys = [temp allKeys];
                            for (int i = 0; i < [keys count]; i++) {
                                thirdLevel = [temp valueForKey:[keys objectAtIndex:i]];
                                [innerSubElements addObject:thirdLevel];
                            }

                        }
                        if ([[innerTemp valueForKey:@"tl"] isKindOfClass:[NSArray class]]) {
                            NSArray *temp = [innerTemp valueForKey:@"tl"];
                            for (int i = 0; i < [temp count]; i++) {
                                thirdLevel = [temp objectAtIndex:i];
                                [innerSubElements addObject:thirdLevel];
                            }
                        }
                        
                    }
                    BookElement *be = [Network buildBookElementsFromData:innerTemp bookLink:bookLink];
                    NSMutableArray *beSubs = [[NSMutableArray alloc] init];
                    if ([innerSubElements count] != 0) {
                        for (int i = 0; i < [innerSubElements count]; i++) {
                        
                        BookElement *ibe = [Network buildBookElementsFromData:[innerSubElements objectAtIndex:i] bookLink:bookLink];
                            [beSubs addObject:ibe];
                        }
                        be.subElements = beSubs;
                    }
                    [subElements addObject:be];
                }
                BookElement *bookElement = [[BookElement alloc] initWithSubElements:subElements articles:[[NSMutableArray alloc] init] date:nil title:[[data objectAtIndex:i] valueForKey:@"title"]];
                [bookElements addObject:bookElement];
                
            } else {
                temp = [data objectAtIndex:i];
                BookElement *bookElement = [Network buildBookElementsFromData:temp bookLink:bookLink];
                [bookElements addObject:bookElement];
            }

        }
        book = [[Book alloc] initWithElements:bookElements title:bookTitle date:nil link:bookLink];
        
    }
    
    BookViewMaster *bookMaster = [[BookViewMaster alloc] initWithNibName:@"BookViewMaster_iPhone" bundle:nil];
    bookMaster.book = book;
    bookMaster.level = 0;
    [[BrowseMode sharedBrowseMode] hideActivityIndicator];
    [[BrowseMode sharedBrowseMode].navigationController pushViewController:bookMaster animated:YES];
}

+(BookElement*)buildBookElementsFromData:(NSDictionary*)temp bookLink:(NSString*)bookLink{
    NSString *title = [temp valueForKey:@"title"];
    NSMutableArray *texts = [temp valueForKey:@"texts"];
    NSMutableArray *links = [temp valueForKey:@"links"];
    NSMutableArray *articles = [[NSMutableArray alloc] init];
    for (int i = 0; i < [texts count]; i++) {
        NSString *link = [links objectAtIndex:i];
        link = [link stringByReplacingOccurrencesOfString:@"./" withString:@""];
        link = [bookLink stringByAppendingString:link];
        NSDictionary *articleContent = [Network getArticleDataForURL:link];
        NSArray *parts  = [articleContent valueForKey:@"parts"];
        NSMutableArray *lines = [[NSMutableArray alloc] init];
        for (int i = 0; i < [parts count]; i++) {
            [lines addObject:[parts objectAtIndex:i]];
        }
        Article *article = [[Article alloc] initWithTitle:[texts objectAtIndex:i] date:nil lines:lines link:link];
        [articles addObject:article];
    }
    BookElement *be = [[BookElement alloc] initWithSubElements:nil articles:articles date:nil title:title];
    //[bookElements addObject:be];
    return be;
}

+(NSDictionary*)getArticleDataForURL:(NSString*)url{
    NSLog(url);
    url = [@"http://2am-dev.ch/lawesome/test.php?article=" stringByAppendingString:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog([error description]);
    }
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *dict = [parser objectWithString:string];
    return dict;
}

+(void)fetchAllContent{
    
}

@end
