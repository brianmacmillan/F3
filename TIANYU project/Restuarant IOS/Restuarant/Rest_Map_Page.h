//
//  Rest_Map_Page.h
//  Restuarant
//
//  Created by R on 06/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h> 
#import "MKMapView+ARHelpers.h"

#import "CustomAnnotationView.h"
#import "Annotation.h"
#import "Constants.h"
//Ads
#import "GoogleMobileAdsHelper.h"
// IN APP
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"
@import GoogleMobileAds;
@class Annotation;
@interface Rest_Map_Page : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,GADInterstitialDelegate>
{
    CLLocationManager *locationManager;
    MKRoute *rout;
    double user_latitude;
    double user_longitude;
}

// Property For Show ADDs Show
@property(nonatomic, strong) GADInterstitial *interstitial;

// View for ADDs Display
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

@property(strong,nonatomic) NSString *str_title;
@property(strong,nonatomic) NSString *str_Address;

@property(strong,nonatomic) NSString *str_latitude;
@property(strong,nonatomic) NSString *str_longitude;



@property (strong, nonatomic) IBOutlet MKMapView *mymap;
- (IBAction)BACK:(id)sender;
- (IBAction)DO_Rought:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *Lbl_Title;


@end
