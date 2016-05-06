//
//  Favourite_Page.h
//  Restuarant
//
//  Created by R on 08/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLFile.h"
#import "Rest_details.h"

//Ads
#import "GoogleMobileAdsHelper.h"
// IN APP
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"
@import GoogleMobileAds;

@interface Favourite_Page : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,GADInterstitialDelegate>
{
     NSMutableArray *arr_favourity;
    
    
    double str_latitude;
    double str_longitude;
}

// Property For Show ADDs Show
@property(nonatomic, strong) GADInterstitial *interstitial;

// View for ADDs Display
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

- (IBAction)BACK:(id)sender;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;

@property (strong, nonatomic) IBOutlet UITableView *tbldata;

@property (weak, nonatomic) IBOutlet UIImageView *Img_Title;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Title;

@end
