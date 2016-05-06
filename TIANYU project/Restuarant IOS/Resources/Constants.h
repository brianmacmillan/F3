//
//  Constants.h
//
//  Created by Tianyu Ren 01/04/16.


#ifndef CustomTableView_Constants_h
#define CustomTableView_Constants_h

#define LoadingColor [UIColor colorWithRed:237.0/255.0 green:112.0/255.0 blue:0.0/255.0 alpha:1.0]

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define IS_DEVICE_RUNNING_IOS_7_AND_ABOVE() ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
#define iPhoneVersion ([[UIScreen mainScreen] bounds].size.height == 568 ? 5 : ([[UIScreen mainScreen] bounds].size.height == 480 ? 4 : ([[UIScreen mainScreen] bounds].size.height == 667 ? 6 : ([[UIScreen mainScreen] bounds].size.height == 736 ? 61 : 999))))


#define InApp_purchase_ID @"com.tianyu.Restaurant"


#define SERVER_URL @"http://172.16.213.158:8888/"
#define image_Url @"http://172.16.213.158:8888/uploads/"

/*
#define SERVER_URL @"http://restaurantfinder.freaktemplate.com/"
#define image_Url @"http://restaurantfinder.freaktemplate.com/uploads/"
*/


#define GameName @"RESTAURANT FINDER"

#define GameUrl @"https://itunes.apple.com/in/app/itunes-u/id490217893?mt=8"

#define AddsID @"ca-app-pub-3730886167471578/1777635245"
#define InterstitialID @"ca-app-pub-3730886167471578/6207834846"

#define Home_Ads_Show @"NO"  // Banner & terstitial

#define Rest_Details_Ads_Show @"NO"  // terstitial

#define Review_Ads_Show @"NO" // Banner & terstitial

#define Offer_Ads_Show @"NO" // Banner

#define Category_Ads_Show @"NO" // Banner & terstitial

#define favourite_Ads_Show @"NO" // Banner & terstitial

#define Map_Detail_Ads_Show @"NO" // Banner




#define No_OF_data 8

















#endif
