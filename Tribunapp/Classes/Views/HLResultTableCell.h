//
//  OTableCell.h
//  TheProfiles
//
//  Created by HanLongHu on 9/20/12.
//  Copyright (c) 2012 HanLongHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataPointInfo;

@protocol HLDataPointTableCellDelegate

@optional;
-(void) didSelectCell: (DataPointInfo *) dpInfo;
-(void) didSelectBtnPic: (NSIndexPath *) indexPath;
-(void) didUnselectCell: (DataPointInfo *) dpInfo;
@end

@interface HLDataPointTableCell : UITableViewCell
{
    IBOutlet UILabel    *mLblName;
    IBOutlet UIButton   *mBtnPic;
    
    BOOL                 mFlgSel;
    
    DataPointInfo       *_mCInfo;
    NSIndexPath         *_mIndexPath;
}

@property (nonatomic, assign) id<HLDataPointTableCellDelegate>   delegate;
@property (strong, nonatomic) IBOutlet UILabel              *mLblName;
@property (strong, nonatomic) IBOutlet UIButton             *mBtnPic;
@property (nonatomic, retain) DataPointInfo                 *mCInfo;
@property (assign)            BOOL                          mFlgSel;
@property (nonatomic, retain) NSIndexPath                   *mIndexPath;

+(id) sharedCell;
- (void)setInfo: (DataPointInfo *)info;

@end
