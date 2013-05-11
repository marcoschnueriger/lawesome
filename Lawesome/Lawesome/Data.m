//
//  Data.m
//  Lawesome
//
//  Created by Marco Schnüriger on 14.03.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import "Data.h"
static Data *sharedData;
@implementation Data
@synthesize title;
@synthesize tableElements;
@synthesize firstPage;
@synthesize lastLink;
-(id)init {
    self = [super init];
    if (self) {
        sharedData = self;
    }
    return (self);
}

+(Data*)sharedData {
    return sharedData;
}
@end
