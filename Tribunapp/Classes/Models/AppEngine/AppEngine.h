//
//  AppEngine.h
//  Pandora's Box
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Reachability.h"

#define Engine  [AppEngine getInstance]

#define LocalizedString(key) \
    [[Engine currentBundle] localizedStringForKey:(key) value:@"" table:nil]

#define isPhone5    [[UIScreen mainScreen] bounds].size.height > 480 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

@class DataPointInfo;

@interface AppEngine : NSObject
{
   // localization
    NSArray                 * _languages;
    NSString                * _currentLang;
    NSBundle                * _currentBundle;
    
    CLLocationCoordinate2D  gCurrentLocation;
    NSString                * _gMeasureUnit;
    
    NSString                * _gUDID;
    NSMutableDictionary     * _gLocationList;
    
    NSString                * _gShowMapType;
    DataPointInfo           * _gSelectedDPInfo;
}

@property (nonatomic, retain) NSArray               * languages;
@property (nonatomic, retain) NSString              * currentLang;
@property (nonatomic, retain, readonly) NSBundle    * currentBundle;
@property (nonatomic) CLLocationCoordinate2D        gCurrentLocation;
@property (nonatomic, retain) NSString              * gMeasureUnit;
@property (nonatomic, retain) NSString              * gUDID;
@property (nonatomic, retain) NSMutableDictionary   * gLocationList;
@property (nonatomic, retain) NSString              * gShowMapType;
@property (nonatomic, retain) DataPointInfo         * gSelectedDPInfo;

#pragma mark singleton
+ (id)getInstance;

#pragma mark
- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;
- (BOOL)isValidWiFiStatus;
- (NetworkStatus)getNetworkStatus;

@end

@interface SocialInfo : NSObject
{
    NSString    *_mId;
    NSString    *_mName;
    NSString    *_mEmail;
    NSString    *_mPhotoUrl;
}

@property (nonatomic, retain) NSString    *mId;
@property (nonatomic, retain) NSString    *mName;
@property (nonatomic, retain) NSString    *mEmail;
@property (nonatomic, retain) NSString    *mPhotoUrl;

@end

@interface UserInfo : NSObject
{
    NSString    *_mId;
    NSString    *_mName;
    NSString    *_mEail;
}

@property (nonatomic, retain) NSString    *mId;
@property (nonatomic, retain) NSString    *mName;
@property (nonatomic, retain) NSString    *mEmail;

@end

@interface DataPointInfo : NSObject
{
    NSString    *_mId;
    NSString    *_mLat;
    NSString    *_mLng;
    NSString    *_mDPoints;
    NSString    *_mCreatedAt;
}

@property (nonatomic, retain) NSString  *mId;
@property (nonatomic, retain) NSString  *mLat;
@property (nonatomic, retain) NSString  *mLng;
@property (nonatomic, retain) NSString  *mDPoints;
@property (nonatomic, retain) NSString  *mCreatedAt;
@property (nonatomic)         BOOL       mExpand;

@end

@interface LocationInfo : NSObject
{
    NSString    *_mLat;
    NSString    *_mLng;
    NSString    *_mAddress;
    NSString    *_mContent;
    NSString    *_mTitle;
    NSString    *_mLocationType;
    NSString    *_mLocationId;
    NSString    *_mPhoto;
}

@property (nonatomic, retain) NSString    *mLat;
@property (nonatomic, retain) NSString    *mLng;
@property (nonatomic, retain) NSString    *mAddress;
@property (nonatomic, retain) NSString    *mContent;
@property (nonatomic, retain) NSString    *mTitle;
@property (nonatomic, retain) NSString    *mLocationType;
@property (nonatomic, retain) NSString    *mLocationId;
@property (nonatomic, retain) NSString    *mPhoto;

@end

