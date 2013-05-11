//
//  Article.m
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "Article.h"

@implementation Article
@synthesize lines = _lines;
@synthesize date = _date;
@synthesize title = _title;
@synthesize link = _link;

-(id)initWithTitle:(NSString*)title date:(NSString*)date lines:(NSMutableArray*)lines link:(NSString*)link{
    self = [super init];
    if (self) {
        _lines = lines;
        _date = date;
        _title = title;
        _link = link;
    }
    return (self);
}
@end
