//
//  Rest_Map_Page.m
//  Restuarant
//
//  Created by R on 06/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "Rest_Map_Page.h"

@interface Rest_Map_Page ()

@end

@implementation Rest_Map_Page

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self IntializeAdd];
    [self SetLanguage];
    
    [self.mymap setShowsUserLocation:YES];
        
    self.mymap.delegate =self;
    self.mymap.mapType = MKMapTypeStandard;
    
   // [locationManager requestAlwaysAuthorization];
    [self userCurrentLocation];
    
}

#pragma mark - Ads
-(void)IntializeAdd
{
    NSString *adds = [[NSUserDefaults standardUserDefaults]stringForKey:@"ADDS"];
    
    if (adds.length==0 && [Map_Detail_Ads_Show isEqualToString:@"YES"])
    {
        NSLog(@"%@",adds);
        [[NSUserDefaults standardUserDefaults]
         setObject:@"" forKey:@"ADDS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [self AdsShow_Table_YES];
        
        self.bannerView.hidden=NO;
        
        [self createAndLoadInterstitial];
        
        self.bannerView.adUnitID = AddsID;
        self.bannerView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        
        //        request.testDevices = @[
        //                                @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
        //                                ];
        [self.bannerView loadRequest:request];
    }else{
        
        [self AdsShow_Table_NO];
        self.bannerView.hidden=YES;
        self.bannerView.backgroundColor=[UIColor clearColor];
    }
}

//Define Table Hight for Ads Show
-(void)AdsShow_Table_YES
{
    if (iPhoneVersion == 4)
        self.mymap.frame = CGRectMake(0,52,320,378);
    else if (iPhoneVersion == 5)
        self.mymap.frame = CGRectMake(0,52,320,466);
    else if (iPhoneVersion == 6)
        self.mymap.frame = CGRectMake(0,60,376,547);
    else if (iPhoneVersion == 61)
        self.mymap.frame = CGRectMake(0,66,414,603);
    else
        self.mymap.frame = CGRectMake(0,124,768,776);
    
}
//Define Table Hight for  Not-Ads Show
-(void)AdsShow_Table_NO
{
    if (iPhoneVersion == 4)
        self.mymap.frame = CGRectMake(0,52,320,428);
    else if (iPhoneVersion == 5)
        self.mymap.frame = CGRectMake(0,52,320,516);
    else if (iPhoneVersion == 6)
        self.mymap.frame = CGRectMake(0,60,376,607);
    else if (iPhoneVersion == 61)
        self.mymap.frame = CGRectMake(0,66,414,670);
    else
        self.mymap.frame = CGRectMake(0,124,768,900);
}
// Method for Load interstitial [ Open ADDs in page ]
- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = InterstitialID;
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    // request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"   ];
    [self.interstitial loadRequest:request];
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    NSLog(@"interstitialDidDismissScreen");
    
}


- (MKMapView *)mapView
{
    if(self.mymap == nil){
        self.mymap = [[MKMapView alloc] initWithFrame:self.view.bounds];
        self.mymap.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self.mymap;
}

#pragma mark  Update User Location
-(void)userCurrentLocation
{
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = [self.str_latitude floatValue];
    centerCoordinate.longitude= [self.str_longitude floatValue];
    
    [self.mymap ARStartUpdatingLocationWithUpdate:^(NSError *error, CLLocation *location) {
        
        
        
        
        [self.mymap removeAnnotations:self.mymap.annotations];
        
        user_latitude = location.coordinate.latitude;
        user_longitude = location.coordinate.longitude;
        
        
        MKPointAnnotation *myan =[[MKPointAnnotation alloc]init];
        myan.title = @"My Location";
        myan.coordinate = location.coordinate;
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:centerCoordinate];
        [annotation setTitle:self.str_title]; //You can set the subtitle too
        [annotation setSubtitle:self.str_Address];
        [self.mymap addAnnotation:annotation];
        
      //  [self.mymap addAnnotation:myan];
        
        
        // Set Default Zomm to Resturant Location
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in self.mymap.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.0, 0.0);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
        [self.mymap setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(40, 10, 10, 10) animated:YES];
        
    }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




// Define The Rought Bitween Source To Destination
- (IBAction)DO_Rought:(id)sender
{
    [self.mymap removeOverlay:rout.polyline];
    
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(user_latitude, user_longitude) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    
    MKMapItem *srcMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    [srcMapItem setName:@""];
    
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake([self.str_latitude doubleValue],[self.str_longitude doubleValue]) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    
    MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    [distMapItem setName:@""];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcMapItem];
    [request setDestination:distMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        NSLog(@"response = %@",response);
        NSArray *arrRoutes = [response routes];
        [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            rout = obj;
            
            MKPolyline *line = [rout polyline];
            [self.mymap addOverlay:line];
            NSLog(@"Rout Name : %@",rout.name);
            NSLog(@"Total Distance (in Meters) :%f",rout.distance);
            
            NSArray *steps = [rout steps];
            
            NSLog(@"Total Steps : %lu",(unsigned long)[steps count]);
            
            [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"Rout Instruction : %@",[obj instructions]);
            //    [arrDuration addObject:[obj instructions]];
            //    [arrDuration addObject:[NSString stringWithFormat:@"Rout Distance : %f",[obj distance]]];
                NSLog(@"Rout Distance : %f",[obj distance]);
           //     [tbl_Route reloadData];
            }];
        }];
    }];
}

// if overlay then Change Line Width to Show
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
}

// Go To Previous Page
- (IBAction)BACK:(id)sender
{
    [self.mymap ARStopUpdatingLocation];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    [self dismissModalViewControllerAnimated:NO];
}
-(void)SetLanguage
{
    
    self.Lbl_Title.text=NSLocalizedString(@"Map_Title",@"");
}

@end
