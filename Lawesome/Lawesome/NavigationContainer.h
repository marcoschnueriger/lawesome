//
//  NavigationContainer.h
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationContainer : NSObject

@property (strong, nonatomic) NSMutableArray *elements;
@property (strong, nonatomic) NSMutableArray *books;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *link;

-(id)initWithElements:(NSMutableArray*)elements books:(NSMutableArray*)books title:(NSString*)title date:(NSString*)date link:(NSString*)link;
@end
