//
//  Database.m
//  AbcTester
//
//  Created by anatolij on 28.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Database.h"


@implementation Database

static NSString* const DATABASE_NAME = @"SecretaryDatabase.sqlite";

@synthesize database;

-(id)init
{
    self = [super init];
	if(self)
	{
		NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];   
		NSString *fullPathToDB= [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
		
		if(![[NSFileManager defaultManager] fileExistsAtPath:fullPathToDB])
		{
			NSError *error = nil;
			NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
			BOOL success = [[NSFileManager defaultManager] copyItemAtPath:defaultDBPath toPath:fullPathToDB error:&error];
			if (!success) 
			{
				NSAssert1(NO, @"Error '%@'.", [error localizedDescription]);
			}
		}
		
		self.database = [FMDatabase databaseWithPath:fullPathToDB];
	}
	
	return self;
}

-(void)dealloc
{
	self.database = nil;	
}

@end
