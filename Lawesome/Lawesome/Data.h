//
//  Data.h
//  Lawesome
//
//  Created by Marco Schnüriger on 14.03.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *tableElements;
@property (assign, readwrite) BOOL firstPage;
@property (strong, nonatomic) NSString *lastLink;
+(Data*)sharedData;
@end
