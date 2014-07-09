//
//  AppEngine.m
//  Pandora's Box
//

#import "AppEngine.h"
#import "Constants_pandora.h"

@implementation AppEngine

@synthesize languages       = _languages;
@synthesize currentLang     = _currentLang;
@synthesize currentBundle   = _currentBundle;
@synthesize gCurrentLocation;
@synthesize gMeasureUnit    = _gMeasureUnit;
@synthesize gUDID           = _gUDID;
@synthesize gLocationList   = _gLocationList;
@synthesize gShowMapType    = _gShowMapType;
@synthesize gSelectedDPInfo = _gSelectedDPInfo;

#pragma mark singleton

+ (id)getInstance
{
    static AppEngine * instance = nil;
    if (!instance)
    {
        instance = [[AppEngine alloc] init];
    }
    return instance;
}

#pragma mark getters/setters

- (void)setCurrentLang:(NSString *)lang
{
    _currentLang = lang;
    
    _currentBundle = [[NSBundle alloc] initWithPath:[[NSBundle mainBundle] pathForResource:self.currentLang ofType:@"lproj"]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLang forKey:kUserDefaultsCurrentLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark init

- (id)init
{
    if (self = [super init])
    {
        self.languages = kLanguageCodes;
        NSString * lang = [[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultsCurrentLanguageKey];
        self.currentLang = lang ? lang : kDefaultLanguage;
        
        self.gUDID = [[UIDevice currentDevice].identifierForVendor UUIDString];
        _gLocationList= [[NSMutableDictionary alloc] init];
        
        _gSelectedDPInfo = [[DataPointInfo alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark BLL general

- (void)setValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)valueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

#pragma mark -
#pragma mark - Network Status

- (BOOL)isValidWiFiStatus
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == NotReachable)
    {
        //No internet
        
        return NO;
    }
    else if (status == ReachableViaWiFi)
    {
        //WiFi
        
        return  YES;
    }
    else if (status == ReachableViaWWAN)
    {
        //3G
        //3G activation: text "Enable 3G downloads" it should be possible to activate a downloading of content through 3G net. Standard setting should be deactivated. If activated, the user should be asked for permission before downloading of every single content...
        return NO;
    }
    
    return NO;
}

- (NetworkStatus)getNetworkStatus
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    return status;
}


@end

@implementation SocialInfo

@synthesize mId         = _mId;
@synthesize mName       = _mName;
@synthesize mEmail      = _mEmail;
@synthesize mPhotoUrl   = _mPhotoUrl;

@end

@implementation UserInfo

@synthesize mId         = _mId;
@synthesize mName       = _mName;
@synthesize mEmail      = _mEmail;

@end

@implementation DataPointInfo

@synthesize mId         = _mId;
@synthesize mLat        = _mLat;
@synthesize mLng        = _mLng;
@synthesize mDPoints    = _mDPoints;
@synthesize mCreatedAt  = _mCreatedAt;

@end

@implementation LocationInfo

@synthesize mLat           = _mLat;
@synthesize mLng          = _mLng;
@synthesize mLocationType               = _mLocationType;
@synthesize mTitle              = _mTitle;
@synthesize mAddress            = _mAddress;
@synthesize mContent            = _mContent;
@synthesize mLocationId =_mLocationId;
@synthesize mPhoto=_mPhoto;

@end

