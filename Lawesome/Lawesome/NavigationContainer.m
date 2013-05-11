//
//  NavigationContainer.m
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "NavigationContainer.h"

@implementation NavigationContainer
@synthesize link = _link;
@synthesize date = _date;
@synthesize title = _title;
@synthesize elements = _elements;
@synthesize books = _books;

-(id)initWithElements:(NSMutableArray*)elements books:(NSMutableArray*)books title:(NSString*)title date:(NSString*)date link:(NSString*)link {
    self = [super init];
    if (self) {
        _link = link;
        _date = date;
        _title = title;
        _elements = elements;
        _books = books;
    }
    return (self);
}
@end
