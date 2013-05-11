//
//  BookElement.m
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "BookElement.h"

@implementation BookElement
@synthesize subElements = _subElements;
@synthesize articles = _articles;
@synthesize date = _date;
@synthesize title = _title;

-(id)initWithSubElements:(NSMutableArray*)subElements articles:(NSMutableArray*)articles date:(NSString*)date title:(NSString*)title {
    self = [super init];
    if (self) {
        _subElements = subElements;
        _articles = articles;
        _date = date;
        _title = title;
    }
    return (self);
}
@end
