//
//  OTableCell.m
//  TheProfiles
//
//  Created by HanLongHu on 9/20/12.
//  Copyright (c) 2012 HanLongHu. All rights reserved.
//

#import "HLDataPointTableCell.h"

#import "AppEngine.h"
#import "Constants_pandora.h"

@implementation HLDataPointTableCell

@synthesize delegate;
@synthesize mLblName;
@synthesize mBtnPic;
@synthesize mCInfo= _mCInfo;
@synthesize mFlgSel;
@synthesize mIndexPath = _mIndexPath;

+(id) sharedCell
{
    HLDataPointTableCell* cell = [[[ NSBundle mainBundle ] loadNibNamed:@"HLDataPointTableCell" owner:nil options:nil] objectAtIndex:0] ;
    
    return cell ;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo: (DataPointInfo *)info
{
    [self setMCInfo: info];
    
    [mLblName setText: info.mDPoints];
}


#pragma mark -
#pragma mark - Touch Event

- (IBAction)onTouchBtnCell: (id)sender
{
    if ([(id)delegate respondsToSelector: @selector(didSelectCell :)])
    {
        [delegate didSelectCell: [self mCInfo]];
    }
}

- (IBAction)onTouchBtnPic: (id)sender
{
    self.mCInfo.mExpand = !self.mCInfo.mExpand;
    
    if ([(id)delegate respondsToSelector: @selector(didSelectBtnPic :)])
    {
        [delegate didSelectBtnPic: [self mIndexPath]];
    }
}


@end
