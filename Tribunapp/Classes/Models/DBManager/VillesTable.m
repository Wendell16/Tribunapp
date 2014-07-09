//
//  AlarmsTable.m
//  iSleepIn
//
//  Created by admin on 7/2/12.
//  Copyright (c) 2012 AMSc. All rights reserved.
//

#import "ProfileTable.h"

@implementation ProfileTable

-(NSInteger)addItem:(TProfile*)_item
{
    NSInteger lastId = 0;
    if ([self.database open]) 
	{
		[self.database beginTransaction];
		
        [self.database executeUpdate:@"insert into Profile (name, background, bg_img_path) values (?,?,?)",
             _item.name,
             [NSNumber numberWithInt:_item.background],
             _item.bgImagePath];
		
		[self.database commit];
        
        lastId= [self.database lastInsertRowId];
		
		[self.database close];
	}
    
    return lastId;
}

-(NSInteger)addItemForAddr:(TAddr*)_item
{
    NSInteger lastId = 0;
    if ([self.database open])
	{
		[self.database beginTransaction];
		
        [self.database executeUpdate:@"insert into Address (lat, log, address, type, street1, street2, city, state, zip, title) values (?,?,?,?,?,?,?,?,?,?)",
         [NSNumber numberWithDouble: _item.lat],
         [NSNumber numberWithDouble: _item.log],
         _item.addr,
         [NSNumber numberWithInt:_item.type],
         _item.street1,
         _item.street2,
         _item.city,
         _item.state,
         _item.zip,
         _item.title];
		
		[self.database commit];
        
        lastId= [self.database lastInsertRowId];
		
		[self.database close];
	}
    
    return lastId;
}

-(void)update:(TProfile*)_item
{
    if ([self.database open]) 
    {
        [self.database beginTransaction];
        
        [self.database executeUpdate:@"update Profile set "
                                    "name=?, "
                                    "background=?, "
                                    "bg_img_path=? "
                                    "where id=?",
         _item.name,
         [NSNumber numberWithInt:_item.background],
         _item.bgImagePath,
         [NSNumber numberWithInt:_item.itemId]];
        
        [self.database commit];
        
        [self.database close];
    }
}

-(void)updateForAddr:(TAddr*)_item
{
    if ([self.database open])
    {
        [self.database beginTransaction];
        
        [self.database executeUpdate:@"update Address set "
         "lat=?, "
         "log=?, "
         "address=?, "
         "street1=?, "
         "street2=?, "
         "city=?, "
         "state=?, "
         "zip=?, "
         "title=? "
         "where type=?",
         [NSNumber numberWithDouble: _item.lat],
         [NSNumber numberWithDouble: _item.log],
         _item.addr,
         _item.street1,
         _item.street2,
         _item.city,
         _item.state,
         _item.zip,
         _item.title,
         [NSNumber numberWithInt:_item.type]];
        
        [self.database commit];
        
        [self.database close];
    }
}

-(BOOL)exist:(NSInteger)_itemId
{
    BOOL result = NO;
    
    if ([self.database open]) 
	{
		FMResultSet *rs = [self.database executeQuery:@"select * from Profile where id=?", [NSNumber numberWithInt:_itemId]];
		
		if([rs next]) 
            result = YES;
		
		[rs close];
		[self.database close];
	}
    
    return result;
}

-(BOOL)existForAddr:(NSInteger)type
{
    BOOL result = NO;
    
    if ([self.database open])
	{
		FMResultSet *rs = [self.database executeQuery:@"select * from Address where type=?", [NSNumber numberWithInt:type]];
		
		if([rs next])
            result = YES;
		
		[rs close];
		[self.database close];
	}
    
    return result;
}


-(void)remove:(TProfile*)_item
{
    if ([self.database open]) 
    {
        [self.database beginTransaction];
        [self.database executeUpdate:@"delete from Profile where id=?", [NSNumber numberWithInt:_item.itemId] ];
        [self.database commit];
        [self.database close];
    } 
}

-(void)removeForAddr:(TAddr*)_item
{
    if ([self.database open])
    {
        [self.database beginTransaction];
        [self.database executeUpdate:@"delete from Address where id=?", [NSNumber numberWithInt:_item.itemId] ];
        [self.database commit];
        [self.database close];
    }
}

- (TProfile*)getFullProfile
{
    TProfile *result = [[TProfile alloc] init];
    
    NSMutableArray *profile = [self getAll];
    if ([profile count] < 1)
        return  nil;
    
    TProfile *tmp = [profile objectAtIndex: 0];
    result.itemId = tmp.itemId;
    result.name = tmp.name;
    result.background = tmp.background;
    result.arrAddr = [self getAllForAddr];
    result.bgImagePath = tmp.bgImagePath;
    
    return result;
}

-(TProfile*)get:(NSInteger)_itemId
{
    TProfile *result = nil;
    
    if ([self.database open]) 
	{
		FMResultSet *rs = [self.database executeQuery:@"select "
                           "id, "
						   "name, "
						   "background, "
                           "bg_img_path "
                           "from Profile "
						   "where id=?", [NSNumber numberWithInt:_itemId]];
		
		if([rs next]) 
		{
			result = [[TProfile alloc] init];
			result.itemId = [rs intForColumn:@"id"];
			result.name = [rs stringForColumn:@"name"];
            result.background = [rs intForColumn:@"background"];
            result.bgImagePath = [rs stringForColumn:@"bg_img_path"];
		}
		
		[rs close];
		[self.database close];
	}
    
    return result;
}

-(TAddr*)getForAddr:(NSInteger)_itemId
{
    TAddr *result = nil;
    
    if ([self.database open])
	{
		FMResultSet *rs = [self.database executeQuery:@"select "
						   "lat, "
                           "log, "
                           "address, "
						   "type, "
                           "street1, "
                           "street2, "
                           "city, "
                           "state, "
                           "zip, "
                           "title "
                           "from Address "
						   "where id=?", [NSNumber numberWithInt:_itemId]];
		
		if([rs next])
		{
			result = [[TAddr alloc] init];
			result.itemId = [rs intForColumn:@"id"];
            result.lat = [rs doubleForColumn: @"lat"];
            result.log = [rs doubleForColumn: @"log"];
			result.addr = [rs stringForColumn:@"address"];
            result.type = [rs intForColumn:@"type"];
            result.street1 = [rs stringForColumn: @"street1"];
            result.street2 = [rs stringForColumn: @"street2"];
            result.city = [rs stringForColumn: @"city"];
            result.state = [rs stringForColumn: @"state"];
            result.zip = [rs stringForColumn: @"zip"];
            result.title = [rs stringForColumn: @"title"];
		}
		
		[rs close];
		[self.database close];
	}
    
    return result;
}

-(NSMutableArray*)getAll
{
    NSMutableArray *results = [NSMutableArray array];
    
    if ([self.database open]) 
	{
		FMResultSet *rs = [self.database executeQuery:@"select " 
						   "id, "
						   "name, "
						   "background, "
                           "bg_img_path "
                           "from Profile"];
		
		while([rs next]) 
		{
			TProfile *tempResult = [[TProfile alloc] init];
			tempResult.itemId = [rs intForColumn:@"id"];
			tempResult.name = [rs stringForColumn:@"name"];
            tempResult.background = [rs intForColumn:@"background"];
            tempResult.bgImagePath = [rs stringForColumn:@"bg_img_path"];
			[results addObject:tempResult];

		}
		
		[rs close];
		[self.database close];
	}
    
    return results;
}

-(NSMutableArray*)getAllForAddr
{
    NSMutableArray *results = [NSMutableArray array];
    
    if ([self.database open])
	{
		FMResultSet *rs = [self.database executeQuery:@"select "
                           "id, "
						   "lat, "
                           "log, "
                           "address, "
						   "type, "
                           "street1, "
                           "street2, "
                           "city, "
                           "state, "
                           "zip, "
                           "title "
                           "from Address"];
		
		while([rs next])
		{
			TAddr *tempResult = [[TAddr alloc] init];
			tempResult.itemId = [rs intForColumn:@"id"];
            tempResult.lat = [rs doubleForColumn: @"lat"];
            tempResult.log = [rs doubleForColumn: @"log"];
			tempResult.addr = [rs stringForColumn:@"address"];
            tempResult.type = [rs intForColumn:@"type"];
            tempResult.street1 = [rs stringForColumn: @"street1"];
            tempResult.street2 = [rs stringForColumn: @"street2"];
            tempResult.city = [rs stringForColumn: @"city"];
            tempResult.state = [rs stringForColumn: @"state"];
            tempResult.zip = [rs stringForColumn: @"zip"];
            tempResult.title = [rs stringForColumn: @"title"];
			[results addObject:tempResult];

		}
		
		[rs close];
		[self.database close];
	}
    
    return results;
}


@end
