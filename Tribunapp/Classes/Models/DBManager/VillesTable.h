//
//  AlarmsTable.h
//  iSleepIn
//
//  Created by admin on 7/2/12.
//  Copyright (c) 2012 AMSc. All rights reserved.
//

#import "Database.h"
#import "TProfile.h"

@interface ProfileTable : Database

-(NSInteger)addItem:(TProfile*)_item;
-(NSInteger)addItemForAddr:(TAddr*)_item;
-(void)update:(TProfile*)_item;
-(void)updateForAddr:(TAddr*)_item;
-(BOOL)exist:(NSInteger)_itemId;
-(BOOL)existForAddr:(NSInteger)_itemId;

-(TProfile*)get:(NSInteger)_itemId;
-(TProfile*)getForAddr:(NSInteger)_itemId;
-(NSMutableArray*)getAll;
-(NSMutableArray*)getAllForAddr;
- (TProfile*)getFullProfile;

@end
