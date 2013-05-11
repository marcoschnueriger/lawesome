//
//  Article.h
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSMutableArray *lines;
@property (strong, nonatomic) NSString *link;

-(id)initWithTitle:(NSString*)title date:(NSString*)date lines:(NSMutableArray*)lines link:(NSString*)link;
@end
