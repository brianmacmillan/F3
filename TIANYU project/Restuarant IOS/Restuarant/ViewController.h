//
//  ViewController.h
//  Restuarant
//
//  Created by R on 01/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 
#import <MapKit/MapKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Social/Social.h>

#import "WebServiceHelper.h"
#import "SBJson.h"
#import "SCLAlertView.h"
#import "Reachability.h"
#import "AAPullToRefresh.h"
#import "HCSStarRatingView.h"

#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"

#import "Category_page.h"
#import "Favourite_Page.h"
#import "Rest_details.h"
#import "Offer_Page.h"
#import "Tearms.h"
#import "About.h"
#import "MKMapView+ARHelpers.h"

//Ads
#import "GoogleMobileAdsHelper.h"
// IN APP
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"

@import GoogleMobileAds;

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate   ,WebServiceHelperDelegate,CLLocationManagerDelegate,UITextFieldDelegate,GADInterstitialDelegate>
{
    SLComposeViewController *mySLcomposerSheet;
    
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
    
    NSString *Fill_User;
    int annotationTag;
    int flag_Map;
    int flag_menu;
    
    NSString *ann_Name;
    NSString *ann_Address;
    
    UIButton * disclosureButton;
    
    int flag;
    NSMutableArray *store_mile;
    NSArray *sort_miles;
    NSArray *arr_img;
    
    
    IBOutlet UIView *View_menu;
    IBOutlet UIView *View_dialoag,*View_Map;
    IBOutlet UIView *Loading;
    
    BOOL IsNetworkWorking;
    NSArray *_products;
    int startIndex;
    UIView *FooterView;
}
// Property For Show ADDs Show
@property(nonatomic, strong) GADInterstitial *interstitial;

// View for ADDs Display
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet NSMutableArray *arrData;
//Map Property
@property (strong, nonatomic) IBOutlet MKMapView *myMap;
@property (strong, nonatomic) IBOutlet UIView *ViewmapDetails;
@property (strong, nonatomic) IBOutlet UILabel *lbl_HotelName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_HotelAddress;
@property (strong, nonatomic) IBOutlet UIButton *btn_DisplayDetails;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;

- (IBAction)DO_ShowMAPDetails:(id)sender;

@property(strong,nonatomic)NSString *str_search;


//Profile Dialoag
@property (strong, nonatomic) IBOutlet UIImageView *img_Dialoag;

@property (strong, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_emal_id;
@property (strong, nonatomic) IBOutlet UIImageView *Error_Name;
@property (strong, nonatomic) IBOutlet UIImageView *Error_mail;
- (IBAction)DO_txt_Name:(id)sender;
- (IBAction)DO_txt_Email_id:(id)sender;
- (IBAction)DO_Submit_UserDetail:(id)sender;
- (IBAction)DO_Cancel_Action:(id)sender;

//NAVIGATION Action
- (IBAction)DO_MENU:(id)sender;
- (IBAction)DO_MORE:(id)sender;

//DETAIL PAGE
@property (strong, nonatomic) IBOutlet UIView *View_details;

// search Data
@property (strong, nonatomic) IBOutlet UITextField *txt_search;


// Load Data
@property (strong, nonatomic) IBOutlet UITableView *tbldata;

//menu Property & Action

- (IBAction)DO_HOME:(id)sender;
- (IBAction)DO_CATEGORY:(id)sender;
- (IBAction)DO_FAVOURITES:(id)sender;
- (IBAction)DO_PROMOTIONS:(id)sender;
- (IBAction)DO_ABOUT_US:(id)sender;
- (IBAction)DO_SOCIAL:(id)sender;
- (IBAction)DO_TERMS:(id)sender;
- (IBAction)DO_PROFILE:(id)sender;

//  IN APP
- (void)productPurchased:(NSNotification *)notification;

- (IBAction)DO_InAppPurchege:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *RemoveAds;
//Menu Lable
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Home;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Categories;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Favourites;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Specialoffer;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Aboutus;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Social;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Tearmscondition;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Profile;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Removeadd;
//Dialog Lable
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Updateprofile;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Dialogsubmit;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Dialogcancel;
//Title Images
@property (weak, nonatomic) IBOutlet UIImageView *Img_title;

@end

