//
//  Database.h
//  AbcTester
//
//  Created by anatolij on 28.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface Database : NSObject 
{
	FMDatabase *database;
}

@property(retain) FMDatabase *database;

@end
