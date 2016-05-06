//
//  Offer_Page.h
//  Restuarant
//
//  Created by R on 03/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

#import "WebServiceHelper.h"
#import "Reachability.h"
#import "SBJson.h"

#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"

#import "SCLAlertView.h"

//Ads
#import "GoogleMobileAdsHelper.h"
// IN APP
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"
@import GoogleMobileAds;

@interface Offer_Page : UIViewController<UITableViewDataSource,UITableViewDelegate,WebServiceHelperDelegate,GADInterstitialDelegate>

{
    NSMutableArray *arrData;
    
    IBOutlet UIView *Loading;
    
    BOOL IsNetworkWorking;
}

// Property For Show ADDs Show
@property(nonatomic, strong) GADInterstitial *interstitial;

// View for ADDs Display
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

@property (strong, nonatomic) IBOutlet UITableView *tbldata;
- (IBAction)BACK:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *Img_Title;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Title;


@end
