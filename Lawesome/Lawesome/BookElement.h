//
//  BookElement.h
//  Lawesome
//
//  Created by Marco Schnüriger on 07.05.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookElement : NSObject

@property (strong, nonatomic) NSMutableArray *subElements;
@property (strong, nonatomic) NSMutableArray *articles;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *title;
-(id)initWithSubElements:(NSMutableArray*)subElements articles:(NSMutableArray*)articles date:(NSString*)date title:(NSString*)title;
@end
