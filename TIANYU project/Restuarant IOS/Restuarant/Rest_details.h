//
//  Rest_details.h
//  Restuarant
//
//  Created by R on 01/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

#import "Rest_Map_Page.h"
#import "Book_table_Page.h"
#import "Review_page.h"

#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"

#import "HCSStarRatingView.h"

#import "WebServiceHelper.h"
#import "SBJson.h"
#import "Reachability.h"
#import "SCLAlertView.h"
#import "SQLFile.h"

//Ads
#import "GoogleMobileAdsHelper.h"
// IN APP
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"


@interface Rest_details : UIViewController<WebServiceHelperDelegate,GADInterstitialDelegate>
{
    BOOL IsNetworkWorking;
    
    SLComposeViewController *mySLcomposerSheet;
    
    int flag_Ads;
    int flag_Favourite;
    int count_Down;
    
    NSString *food;
    NSString *main;
    
    NSArray *arr_img;
    NSMutableArray *array;
    
    NSMutableArray *arrdata;
    
    IBOutlet UIPageControl *pageController;
    
    IBOutlet UIView *Loading;
}
// Property For Show ADDs Show
@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic)int Rest_id;


@property (strong, nonatomic) IBOutlet UIView *main_view;



//NAVIGATION
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
- (IBAction)DO_BACK:(id)sender;
- (IBAction)DO_Favourite:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_favourite;

// Image Loader
@property (strong, nonatomic) IBOutlet UIImageView *img_loader;

// Number of Food
@property (strong, nonatomic) IBOutlet UIScrollView *scrl_Food;

// location at
@property (strong, nonatomic) IBOutlet UILabel *lbl_address;
@property (strong, nonatomic) IBOutlet UILabel *lbl_contact;

// Total Number of Review
//@property (strong, nonatomic) IBOutlet UILabel *lbl_total_Review;
//@property (weak, nonatomic) IBOutlet UILabel *lbl_rev;
// Timing
//@property (strong, nonatomic) IBOutlet UILabel *lbl_monFri_time;

// Bottom
- (IBAction)DO_VIDEO:(id)sender;
- (IBAction)DO_LOCATION:(id)sender;
- (IBAction)DO_TABLE:(id)sender;
- (IBAction)DO_SHARE:(id)sender;
- (IBAction)DO_REVIEW:(id)sender;

//Lable
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Availableat;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Timing;


@end
