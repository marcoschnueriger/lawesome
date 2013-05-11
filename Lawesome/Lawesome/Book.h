//
//  Book.h
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (strong, nonatomic) NSMutableArray *elements;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *link;

-(id)initWithElements:(NSMutableArray*)elements title:(NSString*)title date:(NSString*)date link:(NSString*)link;
@end
