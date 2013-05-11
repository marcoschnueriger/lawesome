//
//  Book.m
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "Book.h"

@implementation Book
@synthesize elements = _elements;
@synthesize title = _title;
@synthesize date = _date;
@synthesize link = _link;

-(id)initWithElements:(NSMutableArray*)elements title:(NSString*)title date:(NSString*)date link:(NSString*)link {
    self = [super init];
    if (self) {
        _elements = elements;
        _title = title;
        _date = date;
        _link = link;
    }
    return (self);
}
@end
