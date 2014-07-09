//
//  Contants.h
//  Pandora
//
//  Created by HanLong on 1/3/13.
//  Copyright (c) 2013 hanlonghu. All rights reserved.
//

#ifndef Pandora_Contants_h
#define Pandora_Contants_h

#define IS_IPHONE5 ( (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568) ? YES : NO )

/**************************************************************************************************************/
// user defaults

#define kUserDefaultsCurrentLanguageKey         @"_langKey"

#define APP_FONT_NAME                           @"ProximaNova-Semibold"

/**************************************************************************************************************/
// lang options

#define kDefaultLanguage                        @"en"
#define kLanguageCodes                          [NSArray arrayWithObjects:@"zh_CN", @"en", @"pt", nil]
#define kLanguages                              [NSArray arrayWithObjects:@"中文(简体)", @"English", @"português", nil]

/**************************************************************************************************************/
// Notification

#define NOTIF_DID_LOGIN                         @"NOTIF_DID_LOGIN"
#define NOTIF_DID_LOGOUT                        @"NOTIF_DID_LOGOUT"
#define NOTIF_GOBACK_TO_BEGIN                   @"NOTIF_GOBACK_TO_BEGIN"

#define RECVED_MEASUREMENT_FROM_PERIPHERAL      @"RECVED_MEASUREMENT_FROM_PERIPHERAL"

#define SHOW_TAB_METER                          @"SHOW_TAB_METER"
#define SHOW_TAB_DATAPOINTS                     @"SHOW_TAB_DATAPOINTS"
#define SHOW_TAB_MAP                            @"SHOW_TAB_MAP"

#define MAP_FROM_METER_VIEW                     @"MAP_FROM_METER_VIEW"
#define MAP_FROM_DATAPOINTS_VIEW                @"MAP_FROM_DATAPOINTS_VIEW"
#define MAP_FROM_MAP_TAB                        @"MAP_FROM_MAP_TAB"

/**************************************************************************************************************/
//UUID

#define RADIATION_SERVICE_UUID                  @"00001800-0000-2000-8000-080070e1ccad"
#define RADIATION_SERVICE_CHARACTERISTIC_UUID   @"00002a00-0000-1000-8000-080070e1ccad"

/**************************************************************************************************************/
//Web services

#define PANDORA_WEB_SERVICE                     @"http://54.186.210.113/pandorabox/webservice.php"

#endif //Pandora
