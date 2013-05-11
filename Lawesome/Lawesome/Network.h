//
//  Network.h
//  Lawesome
//
//  Created by Marco Schnüriger on 14.03.13.
//  Copyright (c) 2013 2am Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject

+(void)getEntriesForPage:(NSString*)page;
+(void)getEntriesForPage:(NSString *)page andSub:(NSString*)sub;
+(void)getBookContent:(NSString*)book;
@end
