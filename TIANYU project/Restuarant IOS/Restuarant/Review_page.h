//
//  Review_page.h
//  Restuarant
//
//  Created by R on 05/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebServiceHelper.h"
#import "SBJson.h"
#import "SCLAlertView.h"
#import "Reachability.h"

#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"
#import "HCSStarRatingView.h"
#import "SCLAlertView.h"

//Ads
#import "GoogleMobileAdsHelper.h"
// IN APP
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"

@import GoogleMobileAds;
@interface Review_page : UIViewController<UITableViewDelegate,UITableViewDataSource,WebServiceHelperDelegate,UITextFieldDelegate,GADInterstitialDelegate>
{
    
    BOOL IsNetworkWorking;
    
    NSMutableArray *arrData;
    
    NSString *Fill_User;
    NSString *Submit_Rate;
    
    NSString *str_user_Rating;
    
    IBOutlet UIView *Loading;
}

// Property For Show ADDs Show
@property(nonatomic, strong) GADInterstitial *interstitial;

// View for ADDs Display
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

@property(nonatomic)int str_Rest_id;


// Navigation
- (IBAction)BACK:(id)sender;
- (IBAction)DO_ADD_Review:(id)sender;

// Review details
@property (strong, nonatomic) IBOutlet UIView *View_table;
@property (strong, nonatomic) IBOutlet UITableView *tbldata;

//user Click To Show Alert on cell
@property (strong, nonatomic) IBOutlet UIView *View_Read_Review;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Read_user_name;

@property (strong, nonatomic) IBOutlet UITextView *txt_Read_comments;
- (IBAction)DO_OK:(id)sender;


// Dialoag Box
@property (strong, nonatomic) IBOutlet UIView *View_dialoag;

    //View Rating Dialoag
    @property (strong, nonatomic) IBOutlet UIView *View_Rating;
    @property (strong, nonatomic) IBOutlet HCSStarRatingView *Rating;
    @property (strong, nonatomic) IBOutlet UITextView *txt_comments;

    - (IBAction)DO_SUBMIT:(id)sender;
    - (IBAction)DO_CANCEL:(id)sender;

    // View Fill Detail Dailoag
    @property (strong, nonatomic) IBOutlet UIView *View_FillDetail;
    @property (strong, nonatomic) IBOutlet UITextField *txt_name;
    @property (strong, nonatomic) IBOutlet UITextField *txt_emal_id;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;

@property (weak, nonatomic) IBOutlet UILabel *lbl_mailid;

    @property (strong, nonatomic) IBOutlet UIImageView *Error_Name;
    @property (strong, nonatomic) IBOutlet UIImageView *Error_mail;
    - (IBAction)DO_txt_Name:(id)sender;
    - (IBAction)DO_txt_Email_id:(id)sender;
    - (IBAction)DO_Submit_UserDetail:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *Lbl_Title;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_yourexprience;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Dialog_submit;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Dialog_cancel;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Dialog2_Submit;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Dialog2_Cancel;

@property (weak, nonatomic) IBOutlet UILabel *Lbl_ok;

@end
