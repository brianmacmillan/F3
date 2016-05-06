//
//  ViewController.m
//  Restuarant
//
//  Created by R on 01/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <LocationDelegate> {
    
    BOOL _didAcquireLocation;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self SetLanguage];
    
    AppDelegate* delegate = [AppDelegate instance];
    delegate.locationDelegate = self;
    [delegate findMyCurrentLocation];
    self.arrData = [[NSMutableArray alloc]init];
    [self.arrData removeAllObjects];
    [self IntializeAdd];
    startIndex = 0;
    [self FrameVersion];
   // [self StartLocationService];
    
    self.Error_Name.hidden=YES;
    self.Error_mail.hidden=YES;
    
    View_menu.hidden =YES;
    View_dialoag.hidden = YES;
    self.ViewmapDetails.hidden = YES;
    
    [self.txt_search setDelegate:self];
    [self.txt_search setReturnKeyType:UIReturnKeyDone];
    flag =0;
    flag_Map = 1;
    flag_menu =0;
    
    
    View_Map.hidden =YES;
    self.myMap.delegate =self;
    self.myMap.mapType = MKMapTypeStandard;
    
    self.myMap.showsUserLocation = YES;
    
    arr_img = [[NSArray alloc]
             initWithObjects:@"rate_1.png", @"rate_2.png",nil];
    
    IsNetworkWorking = [self check_network];
    if (IsNetworkWorking)
    {
        [self LoadingPage];
        NSLog(@"%@",self.str_search);
        
    }else
    {
        [self CallNetworkNotFoundDialog];
    }
    
    self.navigationController.navigationBar.hidden=YES;
}

#pragma mark - Load More Data In TableView

-(void)addLoadMoreButton{
    
    if (iPhoneVersion == 4 || iPhoneVersion == 5)
        FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,320, 60)];
    else if (iPhoneVersion == 6)
        FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,375, 65)];
    else if (iPhoneVersion == 61)
        FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,414, 70)];
    else
        FooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,768, 110)];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhoneVersion == 4 || iPhoneVersion == 5)
       button.frame = CGRectMake(35, 5, 250, 50);
    else if (iPhoneVersion == 6)
        button.frame = CGRectMake(38, 5, 300, 60);
    else if (iPhoneVersion == 61)
        button.frame = CGRectMake(50, 7, 314, 63);
    else
        button.frame = CGRectMake(134, 10, 500, 100);
    
    [button setBackgroundImage:[UIImage imageNamed:@"load_more"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonLoadMoreTouched) forControlEvents:UIControlEventTouchUpInside];

    UILabel *lbl1 = [[UILabel alloc] init];
    if (iPhoneVersion == 4 || iPhoneVersion == 5){
        lbl1.frame = CGRectMake(35, 5, 250, 50);
        lbl1.font = [UIFont boldSystemFontOfSize:15];
    }else if (iPhoneVersion == 6){
        lbl1.frame = CGRectMake(58, 5, 280, 60);
        lbl1.font = [UIFont boldSystemFontOfSize:20];
    }else if (iPhoneVersion == 61){
        lbl1.frame = CGRectMake(60, 7, 314, 63);
        lbl1.font = [UIFont boldSystemFontOfSize:20];
    }else{
        lbl1.frame = CGRectMake(134, 10, 500, 100);
        lbl1.font = [UIFont boldSystemFontOfSize:25];
    }
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.textColor=[UIColor whiteColor];
    lbl1.userInteractionEnabled=NO;
    
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.text=@"Load More";
    
    [FooterView addSubview:button];
    [FooterView addSubview:lbl1];
    self.tbldata.tableFooterView = FooterView;
}

-(void)buttonLoadMoreTouched
{
    startIndex=startIndex+No_OF_data;
    [self GetData];
}

#pragma mark - Ads 
-(void)IntializeAdd
{
    /// IN APP Purchage /////////////////////////////////////
    
    if([SKPaymentQueue canMakePayments])
    {
        NSLog(@"@Parental-Controls are Enable");
    
        _products = nil;
        [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            if (success) {
                _products = products;
                // got the products here
            }
        }];
    }
    else
    {
        NSLog(@"@Parental-Controls are Disable");
    }
    
    NSString *adds = [[NSUserDefaults standardUserDefaults]stringForKey:@"ADDS"];
    
    if (adds.length==0 && [Home_Ads_Show isEqualToString:@"YES"])
    {
        NSLog(@"%@",adds);
        [[NSUserDefaults standardUserDefaults]
         setObject:@"" forKey:@"ADDS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.RemoveAds.hidden=NO;
        self.Lbl_Removeadd.hidden=NO;
        [self AdsShow_Table_YES];
        
        self.bannerView.hidden=NO;
        
        [self createAndLoadInterstitial];
        
        self.bannerView.adUnitID = AddsID;
        self.bannerView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        [self.bannerView loadRequest:request];
        
    }else
    {
        self.RemoveAds.hidden=YES;
        self.Lbl_Removeadd.hidden=YES;
        [self AdsShow_Table_NO];
        self.bannerView.hidden=YES;
        self.bannerView.backgroundColor=[UIColor clearColor];
    }
}

#pragma mark UserUpdated Location

-(void)appDelegate:(AppDelegate *)appDelegate locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.arrData removeAllObjects];
    NSLog(@"Location Failed");
  //  [self GetData];
}

-(void)appDelegate:(AppDelegate *)appDelegate locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    
    if(!_didAcquireLocation) {
        _didAcquireLocation = YES;
        [self.arrData removeAllObjects];
        [self GetData];
    }
}

-(void)appDelegate:(AppDelegate *)appDelegate sensorError:(CLLocationManager *)manager {
    NSLog(@"Location Failed");
}

//Define Table Hight for Ads Show
-(void)AdsShow_Table_YES
{
    if (iPhoneVersion == 4)
        self.tbldata.frame = CGRectMake(0,0,320,329);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,417);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,489);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,538);
    else
        self.tbldata.frame = CGRectMake(0,0,768,659);
}

//Define Table Hight for  Not-Ads Show
-(void)AdsShow_Table_NO
{
    if (iPhoneVersion == 4)
        self.tbldata.frame = CGRectMake(0,0,320,379);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,467);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,549);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,605);
    else
        self.tbldata.frame = CGRectMake(0,0,768,783);
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

#pragma mark - CheckNetworkConnection

// Check out Network-Connection
-(BOOL)check_network
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
        return NO;
    else
        return YES;
    
}

-(void)CallNetworkNotFoundDialog{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showWarning:self title:NSLocalizedString(@"Warning Alert Title",@"") subTitle:NSLocalizedString(@"Warning Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"Warning Alert closeButtonTitle",@"") duration:0.0f];
}

#pragma mark - CLLocationManagerDelegate

-(void)StartLocationService{
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Get Data From Webservice

-(void)LoadingPage
{
   // [self UpdateUserLocation];
    [self FrameVersion];
    Loading.hidden = NO;
    Loading.layer.cornerRadius = Loading.frame.size.height/35;
    [self.view addSubview:Loading];
}

// All Restaurant Detail [ service Call ]

-(void)GetData
{
    AppDelegate* instance = [AppDelegate instance];
    NSString *Ns_Lattitude = [[NSString alloc] initWithFormat:@"%f", instance.myLocation.coordinate.latitude];
    NSString *Ns_Longitude = [[NSString alloc] initWithFormat:@"%f", instance.myLocation.coordinate.longitude];
    
    NSString *temp_URL;
    if ([self.str_search length]>0)
    {
        self.tbldata.tableFooterView.hidden = YES;
        temp_URL = [NSString stringWithFormat:@"nearbyrestaurant.php?lat=%@&long=%@&search=%@",Ns_Lattitude,Ns_Longitude,self.str_search];
        NSLog(@"%@",self.str_search);
    
    }else{
        
        temp_URL = [NSString stringWithFormat:@"nearbyrestaurant.php?lat=%@&long=%@&no=%d&to=%d",Ns_Lattitude,Ns_Longitude,startIndex,No_OF_data];
    }
    temp_URL = [temp_URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"%@",temp_URL);
    WebServiceHelper  *obj_add = [WebServiceHelper new];
    
    [obj_add setCurrentCall:temp_URL];
    [obj_add setMethodName:temp_URL];
    [obj_add setMethodResult:@"Restaurant"];
    [obj_add setDelegate:self];
    [obj_add initiateConnection];
}

// [ service Reply ]

-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    if (result)
    {
        if ([[editor currentCall] isEqualToString:Fill_User])
        {
            NSMutableArray *arr_dict = [[editor ReturnStr] JSONValue];
            
            NSMutableDictionary * Dict = [[NSMutableDictionary alloc]init];
            
            Dict = [arr_dict objectAtIndex:0];
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *userid = [user stringForKey:@"USER_ID"];
            
            NSLog(@"User id %@",userid);
            if (![userid intValue]>0)
            {
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                
                NSString *user_id = [Dict objectForKey:@"id"];
                
                NSLog(@"UserID :%@",user_id);
                
                [user setObject:user_id forKey:@"USER_ID"];
                [user synchronize];
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                
                [alert showSuccess:NSLocalizedString(@"UserCreated Alert Title",@"") subTitle:NSLocalizedString(@"UserCreated Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"UserCreated Alert closeButtonTitle",@"") duration:0.0f];
            }
            else
            {
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                
                [alert showSuccess:NSLocalizedString(@"UserUpdated Alert Title",@"") subTitle:NSLocalizedString(@"UserUpdated Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"UserUpdated Alert closeButtonTitle",@"") duration:0.0f];
            }
        }
        else
        {
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            [self getSortedArray:resultDic];
            
            [self.txt_search setDelegate:self];
            [self.txt_search setReturnKeyType:UIReturnKeyDone];
            self.txt_search.text = @"";
        }
    }
    else
    {
        Loading.hidden = YES;
        [self CallAlertView:NSLocalizedString(@"Error Alert Title",@"") second:NSLocalizedString(@"Error Alert SubTitle",@"") third:NSLocalizedString(@"Error Alert closeButtonTitle",@"")];
    }
}

//Set Sort Order Data [ miles wise  ]

-(void)getSortedArray:(NSMutableDictionary *)resultDic
{
    NSMutableArray *TempArray = [resultDic objectForKey:@"Restaurant"];
    if (![TempArray count] > 0) {
        Loading.hidden = YES;
        [self CallAlertView:NSLocalizedString(@"Error Alert Title",@"") second:NSLocalizedString(@"Error Alert SubTitle",@"") third:NSLocalizedString(@"Error Alert closeButtonTitle",@"")];
        Loading.hidden = YES;
        [self.tbldata reloadData];
        
    }else{
        
        for (int i=0; i<[TempArray count]; i++) {
            NSMutableDictionary *temp = [TempArray objectAtIndex:i];
            NSLog(@"%@",temp);
            [self.arrData addObject:temp];
        }
        
        if ([TempArray count]<8) {
            self.tbldata.tableFooterView.hidden = YES;
        }else{
            [self addLoadMoreButton];
        }
        
        Loading.hidden = YES;
        [self.tbldata reloadData];
    }
}

// Assigning Order for Sort
NSInteger cardSortDesc(id card1, id card2, NSString *keyForSorting)
{
    double v1 = [[card1 objectForKey:keyForSorting] doubleValue];
    double v2 = [[card2 objectForKey:keyForSorting] doubleValue];
    
    if (v1 > v2)
        return NSOrderedDescending;
    else if (v1 < v2)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

// Search Category Data [ service Call ]
-(void)Searchdata
{
    IsNetworkWorking = [self check_network];
    if (IsNetworkWorking)
    {
        [self LoadingPage];
        WebServiceHelper  *obj_add = [WebServiceHelper new];
        NSString *main =[NSString stringWithFormat:@"restaurantdetail.php?search=%@",self.str_search];
        [obj_add setCurrentCall:main];
        [obj_add setMethodName:main];
        [obj_add setMethodResult:@"Restaurant"];
        [obj_add setDelegate:self];
        [obj_add initiateConnection];
        
    }
    else
    {
        [self CallNetworkNotFoundDialog];
    }
}

// Textfield To Search [ service Call ]
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    
    IsNetworkWorking = [self check_network];
    if (IsNetworkWorking)
    {
        [self.arrData removeAllObjects];
        [self LoadingPage];
        startIndex=0;
        self.str_search =self.txt_search.text;
        NSLog(@"%@",self.txt_search.text);
        [self GetData];
    }
    else
    {
        [self CallNetworkNotFoundDialog];
    }

    [self.txt_search resignFirstResponder];
    return YES;
}

#pragma mark - AlertView & Set Frame method

// Alert Dialoag
-(void)CallAlertView:(NSString *)Title second:(NSString *)SubTitle third:(NSString *)ButtonName;
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
    
    [alert showCustom:self image:nil color:color title:Title subTitle:SubTitle closeButtonTitle:ButtonName duration:0.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)FrameVersion
{
    if (iPhoneVersion == 4)
    {
        Loading.frame = CGRectMake(100,200,120,120);
        View_Map.frame =CGRectMake(0,62,320,418);
    }
    else if (iPhoneVersion == 5)
    {
        Loading.frame = CGRectMake(100,250,120,120);
        View_Map.frame =CGRectMake(0,62,320,506);
    }
    else if (iPhoneVersion == 6)
    {
        Loading.frame = CGRectMake(117,280,141,141);
        View_Map.frame =CGRectMake(0,72,376,594);
    }
    else if (iPhoneVersion == 61)
    {
        Loading.frame = CGRectMake(115,330,184,184);
        View_Map.frame =CGRectMake(0,80,414,655);
    }
    else
    {
        Loading.frame = CGRectMake(239,400,289,289);
        View_Map.frame =CGRectMake(0,148,768,876);
    }
}


#pragma mark - UITableView method implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellid";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

   NSMutableDictionary *temp =[self.arrData objectAtIndex:indexPath.row];
    
    UIImageView *img_cell =(UIImageView *) [cell viewWithTag:100];
    if (indexPath.row == 0)
    {
        [img_cell setImage:[UIImage imageNamed:@"first_cell.png"]];
    }
    else
    {
        [img_cell setImage:[UIImage imageNamed:@"second_cell.png"]];
    }
    
    //Hotel_name
    UILabel *rest_name =(UILabel*) [cell.contentView viewWithTag:102];
    rest_name.text = [temp objectForKey:@"name"];

    //Hotel_Address
    UILabel *rest_address =(UILabel*) [cell.contentView viewWithTag:105];
    rest_address.textColor = [UIColor darkGrayColor];
    rest_address.text = [NSString stringWithFormat:@"%@ -%@",[temp objectForKey:@"address"],[temp objectForKey:@"zipcode"]];

    HCSStarRatingView *starRatingView = (HCSStarRatingView *) [cell viewWithTag:1001];;
    
    float Rate = [[temp objectForKey:@"ratting"]floatValue];
    
    starRatingView.value = Rate;
    starRatingView.maximumValue =5;
    starRatingView.minimumValue = 0;
    starRatingView.spacing =3;
    starRatingView.allowsHalfStars =YES;
    starRatingView.accurateHalfStars =YES;
    starRatingView.emptyStarImage = [UIImage imageNamed:@"rate_2.png"];
    starRatingView.filledStarImage = [UIImage imageNamed:@"rate_1.png"];
    
    //Hotel_thumbnil
    UIImageView *img_data =(UIImageView *) [cell viewWithTag:101];
    [img_data startLoaderWithTintColor:LoadingColor];
    
    NSString *Str_image_name = [NSString stringWithFormat:@"%@",[temp objectForKey:@"thumbnailimage"]];
    Str_image_name = [Str_image_name stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *url1= [image_Url stringByAppendingString:Str_image_name];
    [img_data sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"home_page_cell_img"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [img_data updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [img_data reveal];
    }];
    
    //Hotel Distances
    UILabel *rest_Km =(UILabel*) [cell.contentView viewWithTag:106];
    rest_Km.textColor = [UIColor darkGrayColor];
    rest_Km.text = [NSString stringWithFormat:@"%@ %@",[temp objectForKey:@"distance"],NSLocalizedString(@"distance",@"")];
    NSLog(@"%@",[temp objectForKey:@"distance"]);
    
    //Hotel Type
    UIImageView *img_veg =(UIImageView *) [cell viewWithTag:103];
    UIImageView *img_nonVeg =(UIImageView *) [cell viewWithTag:104];
    NSString *VegType = [temp objectForKey:@"vegtype"];
    if ([VegType isEqualToString:@"Veg"])
    {
        img_veg.hidden = YES;
        img_nonVeg.hidden = NO;
        img_nonVeg.image = [UIImage imageNamed:@"veg_icon.png"];
    }
    else if ([VegType isEqualToString:@"Nonveg"])
    {
        img_veg.hidden = YES;
        img_nonVeg.hidden = NO;
        img_nonVeg.image = [UIImage imageNamed:@"nonveg_icon.png"];
    }
    else
    {
        img_veg.hidden = NO;
        img_nonVeg .hidden = NO;
        img_veg.image = [UIImage imageNamed:@"veg_icon.png"];
        img_nonVeg.image = [UIImage imageNamed:@"nonveg_icon.png"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dict_data = [self.arrData objectAtIndex:indexPath.row];
    
    NSLog(@"select ID :%@",[dict_data objectForKey:@"id"]);
    //story_rest_details
    
    Rest_details *next = [self.storyboard instantiateViewControllerWithIdentifier:@"story_rest_details"];
    next.Rest_id = [[dict_data objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - ViewController Button Click Events

// Show Map

- (IBAction)DO_MORE:(id)sender
{
    if (flag == 0)
    {
        //Insretitial
        if (self.interstitial.isReady)
        {
            [self.interstitial presentFromRootViewController:self];
        }
        annotationTag = 0;
        for (int i=0 ; i< self.arrData.count; i++)
        {
            NSMutableDictionary *dict_data = [self.arrData objectAtIndex:i];
            
            double lat = [[dict_data objectForKey:@"latitude"] doubleValue];
            double longt = [[dict_data objectForKey:@"longitude"] doubleValue];
            
            ann_Name = [dict_data objectForKey:@"name"];
            ann_Address = [dict_data objectForKey:@"address"];
            
            annotationTag =[[dict_data objectForKey:@"id"]intValue];
            
            NSLog(@" For Loop : %d",annotationTag);
            
            CLLocationCoordinate2D loc;
            loc.longitude = longt;
            loc.latitude = lat;
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = loc;
            
            annotationPoint.title = [dict_data objectForKey:@"id"];
            [self.myMap addAnnotation:annotationPoint];
        }
        
        // Set Default Zomm to Resturant Location
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in self.myMap.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.0, 0.0);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
        [self.myMap setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(40, 10, 10, 10) animated:YES];
        
        [self Rottet];
        View_Map.hidden =NO;
        [self.view addSubview:View_Map];
        flag =1 ;
    }
    else
    {
        [self RottetLeft];
        View_Map.hidden =YES;
        
        flag =0;
    }
}


// Menu Open & Close

- (IBAction)DO_MENU:(id)sender
{
    // [self FrameVersion];
    
    if (flag_menu == 0)
    {
        [self.view addSubview:View_menu];
        flag_menu =1;
        View_menu.hidden = NO;
        if (iPhoneVersion == 4)
        {
            View_menu.frame  = CGRectMake(-155, 62, 155,418);
        }
        else if (iPhoneVersion == 5)
        {
            View_menu.frame =CGRectMake(-182,62,182,506);
        }
        else if (iPhoneVersion == 6)
        {
            View_menu.frame =CGRectMake(-182,72,182,596);
        }
        else if (iPhoneVersion == 61)
        {
            View_menu.frame =CGRectMake(-201,79,201,655);
        }
        else
        {
            View_menu.frame =CGRectMake(-374,148,374,913);
        }
        
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            if (iPhoneVersion == 4)
            {
                View_menu.frame  = CGRectMake(0, 62, 155,418);
            }
            else if (iPhoneVersion == 5)
            {
                View_menu.frame =CGRectMake(0,62,182,506);
            }
            else if (iPhoneVersion == 6)
            {
                View_menu.frame =CGRectMake(0,72,182,596);
            }
            else if (iPhoneVersion == 61)
            {
                View_menu.frame =CGRectMake(0,79,201,655);
            }
            else
            {
                View_menu.frame =CGRectMake(0,148,374,913);
            }
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        if (iPhoneVersion == 4)
        {
            View_menu.frame  = CGRectMake(0, 62, 155,418);
        }
        else if (iPhoneVersion == 5)
        {
            View_menu.frame =CGRectMake(0,62,182,506);
        }
        else if (iPhoneVersion == 6)
        {
            View_menu.frame =CGRectMake(0,72,182,596);
        }
        else if (iPhoneVersion == 61)
        {
            View_menu.frame =CGRectMake(0,79,201,655);
        }
        else
        {
            View_menu.frame =CGRectMake(0,148,374,913);
        }
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            if (iPhoneVersion == 4)
            {
                View_menu.frame  = CGRectMake(-155, 62, 155,418);
            }
            else if (iPhoneVersion == 5)
            {
                View_menu.frame =CGRectMake(-182,62,182,506);
            }
            else if (iPhoneVersion == 6)
            {
                View_menu.frame =CGRectMake(-182,72,182,596);
            }
            else if (iPhoneVersion == 61)
            {
                View_menu.frame =CGRectMake(-201,79,201,655);
            }
            else
            {
                View_menu.frame =CGRectMake(-374,148,374,913);
            }
        } completion:^(BOOL finished) {
            View_menu.hidden = YES;
            
        }];
        
        flag_menu =0;
    }
}

// Set Animation For Rottation [ Right ]
-(void)Rottet
{
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

// Set Animation For Rottation [ Left ]
-(void)RottetLeft
{
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

- (IBAction)DO_ShowMAPDetails:(id)sender
{
    Rest_details *next = [self.storyboard instantiateViewControllerWithIdentifier:@"story_rest_details"];
    
    
    next.Rest_id = self.btn_DisplayDetails.tag;
    [self.navigationController pushViewController:next animated:YES];
}

// View Custom Anntation [Display View ]

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    NSInteger indexOfTheObject = [mapView.annotations indexOfObject:view.annotation];
    
    MKPointAnnotation *temp = view.annotation;
    NSString *tempStr = temp.title;
    NSLog(@"%@",temp.title);
    temp.title = NULL;
    
    for (id currentAnnotation in self.myMap.annotations) {
        if ([currentAnnotation isKindOfClass:[MKPointAnnotation class]]) {
            [self.myMap deselectAnnotation:currentAnnotation animated:YES];
        }
    }
    
    if (indexOfTheObject < self.arrData.count)
    {
        flag_Map =1;
        NSMutableDictionary *dict_data;
        for (int i = 0; i<[self.arrData count]; i++) {
            NSMutableDictionary *temp = [self.arrData objectAtIndex:i];
            if ([[temp objectForKey:@"id"] isEqualToString:tempStr]) {
                dict_data = temp;
                break;
            }
        }
        
        self.btn_DisplayDetails.tag =[tempStr intValue];
        self.lbl_HotelName.text = [dict_data objectForKey:@"name"];
        self.lbl_HotelAddress.text = [dict_data objectForKey:@"address"];
        
    }
    else
    {
        flag_Map =0;
    }
    
    if (flag_Map == 1)
    {
        self.ViewmapDetails.hidden = NO;
        self.ViewmapDetails.transform = CGAffineTransformMakeScale(1.01, 0.01);
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            self.ViewmapDetails.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished){
            
        }];
        
        flag_Map = 0;
    }
    else
    {
        self.ViewmapDetails.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.ViewmapDetails.transform = CGAffineTransformMakeScale(1.01, 0.01);
        } completion:^(BOOL finished){
            self.ViewmapDetails.hidden = YES;
        }];
        
        flag_Map =1;
    }
}

#pragma mark - Menu Button Click Events

// Home Page Call

- (IBAction)DO_HOME:(id)sender
{
    startIndex=0;
    [self.arrData removeAllObjects];
    self.str_search = @"";
    [self GetData];
    if (flag_menu ==  0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.View_details.alpha = 0.50;
            View_Map.alpha = 0.50;
            View_menu.hidden =NO;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.View_details.alpha = 1;
            View_Map.alpha = 1;
            View_menu.hidden =YES;
            flag_menu=0;
        }];
    }
}

// Category Page Call

- (IBAction)DO_CATEGORY:(id)sender
{

    Category_page *next= [self.storyboard instantiateViewControllerWithIdentifier:@"story_category"];
    
    [self.navigationController pushViewController:next animated:YES];
}

// Favourite Page Call
- (IBAction)DO_FAVOURITES:(id)sender
{
    Favourite_Page *next = [self.storyboard instantiateViewControllerWithIdentifier:@"story_favourite"];
    [self.navigationController pushViewController:next animated:YES];
}

// Special Offer Page Call
- (IBAction)DO_PROMOTIONS:(id)sender
{
    Offer_Page *next= [self.storyboard instantiateViewControllerWithIdentifier:@"story_Offer"];
    
    [self.navigationController pushViewController:next animated:YES];
}

// Terms Page Call
- (IBAction)DO_TERMS:(id)sender
{
    Tearms *sec=[self.storyboard instantiateViewControllerWithIdentifier:@"Story_third"];
    
    [self.navigationController pushViewController:sec animated:YES];
}

// About-Us Page Call
- (IBAction)DO_ABOUT_US:(id)sender
{
    About *sec=[self.storyboard instantiateViewControllerWithIdentifier:@"Story_second"];
    
    [self.navigationController pushViewController:sec animated:YES];
}

// Share Application Dialoag Open
- (IBAction)DO_SOCIAL:(id)sender
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    
    [alert addButton:@"Facebook" target:self selector:@selector(Facebook)];
    [alert addButton:@"Whats app" target:self selector:@selector(Whatsapp)];
    [alert addButton:@"Twitter" target:self selector:@selector(Twitter)];
    
    UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
    
    [alert showCustom:self image:nil color:color title:nil subTitle:NSLocalizedString(@"Social Title", @"") closeButtonTitle:NSLocalizedString(@"Social Cancel", @"") duration:0.0f];
}

// Open User Profile Dialoag
- (IBAction)DO_PROFILE:(id)sender
{
    [self FrameVersion];
    [self.view addSubview:View_dialoag];
    View_dialoag.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.View_details.alpha = 1;
        View_Map.alpha = 1;
        
        View_menu.hidden =YES;
        flag_menu=0;
    }];
    
    View_dialoag.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        View_dialoag.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
    }];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *userid = [prefs stringForKey:@"USER_ID"];
    
    NSString *username = [prefs stringForKey:@"username"];
    NSString *useremail = [prefs stringForKey:@"usermail"];
    
    NSLog(@"id :%@",userid);
    NSLog(@"id :%@",username);
    NSLog(@"id :%@",useremail);
    
    if ([userid length]>0)
    {
        [self.img_Dialoag setImage:[UIImage imageNamed:@"update_profile_dialoag.png"]];
        self.Lbl_Updateprofile.text=NSLocalizedString(@"Dialog_updateprofile",@"");

        self.Error_Name.hidden=YES;
        self.Error_mail.hidden=YES;
        self.txt_name.text = username;
        self.txt_emal_id.text = useremail;
        
    }
    else
    {
        [self.img_Dialoag setImage:[UIImage imageNamed:@"create_profile_dialoag.png"]];
        self.Lbl_Updateprofile.text=NSLocalizedString(@"Dialog_createprofile",@"");
        self.txt_name.text = @"";
        self.txt_emal_id.text = @"";
    }
}

///// IN - APP ///////////////////////////
- (IBAction)DO_InAppPurchege:(id)sender
{
    SKProduct *skProduct = _products[0];
    NSLog(@"Found product: %@ %@ %0.2f",
          skProduct.productIdentifier,
          skProduct.localizedTitle,
          skProduct.price.floatValue);

    NSString *temp = [NSString stringWithFormat:NSLocalizedString(@"AppPurchase Des", @""),skProduct.localizedTitle,skProduct.price.floatValue];
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    
    [alert addButton:NSLocalizedString(@"AppPurchase Restore", @"") target:self selector:@selector(Restore)];
    [alert addButton:NSLocalizedString(@"AppPurchase Purchase", @"") target:self selector:@selector(Purchase)];
    
    UIColor *color = [UIColor colorWithRed:174.0/255.0 green:202.0/255.0 blue:71.0/255.0 alpha:1.0];
    
    [alert showCustom:self image:nil color:color title:NSLocalizedString(@"AppPurchase Title", @"") subTitle:temp closeButtonTitle:NSLocalizedString(@"AppPurchase Cancel", @"") duration:0.0f];
}


#pragma mark - For IN APP Purchase

- (void)Restore
{
    NSLog(@"Restore");
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (void)Purchase
{
    SKProduct *product = _products[0];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            // product is purchased now
            [[NSUserDefaults standardUserDefaults]
             setObject:@"OFF" forKey:@"ADDS"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            *stop = YES;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}


#pragma mark - Social Sharing

// Share With FaceBook
- (void)Facebook
{
    NSLog(@"Facebook button tapped");
    
    mySLcomposerSheet = [[SLComposeViewController alloc]init];
    mySLcomposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [mySLcomposerSheet setInitialText:[NSString stringWithFormat:GameName]];
    [mySLcomposerSheet addURL:[NSURL URLWithString:GameUrl]];
    [mySLcomposerSheet setAccessibilityElementsHidden:YES];
    [self presentViewController:mySLcomposerSheet animated:YES completion:NULL];
}

// Share With Whatsapp
- (void)Whatsapp
{
    NSLog(@"Whatsapp button tapped");
    
    NSString * msg = [[@"Application%20" stringByAppendingString:GameName]stringByAppendingString:GameUrl];
    
    msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    msg = [msg stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    msg = [msg stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    msg = [msg stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    msg = [msg stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    msg = [msg stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    
    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
    NSURL * whatsappURL = [NSURL URLWithString:urlWhats];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL])
    {
        [[UIApplication sharedApplication] openURL: whatsappURL];
        
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WhatsApp Alert Title",@"") message:NSLocalizedString(@"WhatsApp Alert SubTitle",@"") delegate:self cancelButtonTitle:NSLocalizedString(@"WhatsApp Alert closeButtonTitle",@"") otherButtonTitles:nil];
        [alert show];
    }
}

// Share With Twitter
- (void)Twitter
{
    NSLog(@"Twitter button tapped");
    
    
    mySLcomposerSheet = [[SLComposeViewController alloc]init];
    mySLcomposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [mySLcomposerSheet setInitialText:[NSString stringWithFormat:GameName]];
    [mySLcomposerSheet addURL:[NSURL URLWithString:GameUrl]];
    [mySLcomposerSheet setAccessibilityElementsHidden:YES];
    [self presentViewController:mySLcomposerSheet animated:YES completion:NULL];
}


#pragma mark - Create Update User Profile

// Create User Profile
-(void)UserCreate
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:self.txt_name.text forKey:@"username"];
    [prefs setObject:self.txt_emal_id.text forKey:@"usermail"];
    [prefs synchronize];
    
    WebServiceHelper  *obj = [WebServiceHelper new];
    Fill_User =[NSString stringWithFormat:@"adduser.php?username=%@&&email=%@",self.txt_name.text,self.txt_emal_id.text];
    [obj setCurrentCall:Fill_User];
    [obj setMethodName:Fill_User];
    [obj setDelegate:self];
    [obj initiateConnection];
}

// User-Name -> Did end Editing  : [User Profile]
- (IBAction)DO_txt_Name:(id)sender
{
    [self validationCheckForName];
}

// User-Mail -> Did end Editing  : [User Profile]
- (IBAction)DO_txt_Email_id:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
}



// Check Validation For User Name
-(void)validationCheckForName
{
    if ([self.txt_name.text isEqualToString:@""])
    {
        self.Error_Name.hidden=NO;
    }
    else
    {
        self.Error_Name.hidden=YES;
    }
}

// Check Validation For User Mail
-(void)validationCheckFormail
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([emailTest evaluateWithObject:self.txt_emal_id.text] == YES )
    {
        self.Error_mail.hidden=YES;
    }
    else
    {
        self.Error_mail.hidden=NO;
    }
}


// Submit For User Update Details

- (IBAction)DO_Submit_UserDetail:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //Valid email address
    if ([emailTest evaluateWithObject:self.txt_emal_id.text] != YES)
    {
        self.Error_mail.hidden=YES;
        [self validationCheckForName];
    }
    else
    {
        
        NSString *str_name = self.txt_name.text;
        str_name = [str_name stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString *str_email = self.txt_emal_id.text;
        str_email = [str_email stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        [prefs setObject:str_name forKey:@"username"];
        [prefs setObject:str_email forKey:@"usermail"];
        [prefs synchronize];
        
        NSString *userid = [prefs stringForKey:@"USER_ID"];
        
        NSString *username = [prefs stringForKey:@"username"];
        NSString *useremail = [prefs stringForKey:@"usermail"];
        
        NSLog(@"id :%@",userid);
        NSLog(@"id :%@",username);
        NSLog(@"id :%@",useremail);
        WebServiceHelper  *obj = [WebServiceHelper new];
        
       
        if ([userid length]>0)
        {
             Fill_User =[NSString stringWithFormat:@"updateuser.php?username=%@&&email=%@",str_name,str_email];
        }else{
             Fill_User =[NSString stringWithFormat:@"adduser.php?username=%@&&email=%@",str_name,str_email];
        }
        
        [obj setCurrentCall:Fill_User];
        [obj setMethodName:Fill_User];
        [obj setDelegate:self];
        [obj initiateConnection];
        
        
        View_dialoag.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            View_dialoag.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished){
            View_dialoag.hidden = YES;
        }];
    }
}

// Cancel To Hide User Profile 
- (IBAction)DO_Cancel_Action:(id)sender
{
   View_dialoag.hidden = YES;
}

-(void)SetLanguage
{
    self.txt_search.placeholder=NSLocalizedString(@"Search TextField", @"");
    self.lbl_name.text=NSLocalizedString(@"Name",@"");
    self.lbl_email.text=NSLocalizedString(@"E_mail", @"");
    self.txt_name.placeholder=NSLocalizedString(@"Txt_Name",@"");
    self.txt_emal_id.placeholder=NSLocalizedString(@"Txt_E_mail",@"");
    
    self.Lbl_Home.text=NSLocalizedString(@"Menu_Home",@"");
    self.Lbl_Categories.text=NSLocalizedString(@"Menu_Categories",@"");
    self.Lbl_Favourites.text=NSLocalizedString(@"Menu_Favourites",@"");
    self.Lbl_Specialoffer.text=NSLocalizedString(@"Menu_Special Offers",@"");
    self.Lbl_Aboutus.text=NSLocalizedString(@"Menu_About Us",@"");
    self.Lbl_Social.text=NSLocalizedString(@"Menu_Social Sharing",@"");
    self.Lbl_Tearmscondition.text=NSLocalizedString(@"Menu_Terms&Conditions",@"");
    self.Lbl_Profile.text=NSLocalizedString(@"Menu_Profile",@"");
    self.Lbl_Removeadd.text=NSLocalizedString(@"Menu_Remove Ads",@"");
    self.Lbl_Dialogsubmit.text=NSLocalizedString(@"Dialog_submit",@"");
    
    self.Lbl_Dialogcancel.text=NSLocalizedString(@"Dialog_cancel",@"");
    
    self.Img_title.image=[UIImage imageNamed:NSLocalizedString(@"Home_title", nil)];
}
@end
