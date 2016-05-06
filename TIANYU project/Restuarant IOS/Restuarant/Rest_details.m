//
//  Rest_details.m
//  Restuarant
//
//  Created by R on 01/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "Rest_details.h"

@interface Rest_details ()

@end

@implementation Rest_details

- (void)viewDidLoad {
    [super viewDidLoad];

     [self SetLanguage];
    flag_Ads =0;
    
    if ([Rest_Details_Ads_Show isEqualToString:@"YES"])
    {
        [self createAndLoadInterstitial];
    }
    
    self.main_view.alpha =1.0;
    
    [self.scrl_Food setContentSize:CGSizeMake(315,51)];
    
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.9;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromRight;
    transition.delegate = self;
    [self.scrl_Food.layer addAnimation:transition forKey:nil];
    
    IsNetworkWorking = [self check_network];
    if (IsNetworkWorking)
    {
        [self FrameVersion];
        Loading.hidden = NO;
        Loading.layer.cornerRadius = Loading.frame.size.height/35;
        [self.view addSubview:Loading];
         self.main_view.hidden = YES;
        
        [self GetData];
        count_Down =0;
    }
    else
        [self CallNetworkNotFoundDialog];
    
}

-(void)FrameVersion
{
    if (iPhoneVersion == 4)
    {
        Loading.frame = CGRectMake(100,200,120,120);
    }
    else if (iPhoneVersion == 5)
    {
        Loading.frame = CGRectMake(100,250,120,120);
    }
    else if (iPhoneVersion == 6)
    {
        Loading.frame = CGRectMake(117,280,141,141);
    }
    else if (iPhoneVersion == 61)
    {
        Loading.frame = CGRectMake(115,330,184,184);
    }
    else
    {
        Loading.frame = CGRectMake(239,400,289,289);
    }
}


#pragma mark - Check Internet

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

#pragma mark - Get Data form Webservice

// Call Service [ Restaurant Sub-Detail ]
-(void)GetData
{
    
    WebServiceHelper  *obj_add = [WebServiceHelper new];
    WebServiceHelper  *obj_food = [WebServiceHelper new];
    main =[NSString stringWithFormat:@"restaurantdetail.php?value=%d",self.Rest_id];
    food =[NSString stringWithFormat:@"foodtype.php?value=%d",self.Rest_id];
    [obj_add setCurrentCall:main];
    [obj_food setCurrentCall:food];
    [obj_add setMethodName:main];
    [obj_food setMethodName:food];
    [obj_add setMethodResult:@"Restaurant"];
    [obj_food setMethodResult:@"Foodtype"];
    [obj_add setDelegate:self];
    [obj_food setDelegate:self];
    [obj_add initiateConnection];
    [obj_food initiateConnection];
}

// Retrive Data From Service
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    if (result)
    {
        if ([[editor currentCall] isEqualToString:food])
        {
            int fontsize=0;
            int value=0;
            int btnx = 0;
            int btnheight=0;
            int btnwidth=0;
            
            if (iPhoneVersion==4)
            {
                fontsize=22;
                value=4;
                btnx = 4;
                btnheight = 50;
                btnwidth = 130;
            }
            else if(iPhoneVersion==5)
            {
                fontsize=22;
                value=4;
                btnx = 4;
                btnheight = 50;
                btnwidth = 132;
            }
            else if(iPhoneVersion==6)
            {
                fontsize=25;
                value=5;
                btnx = 5;
                btnheight = 59;
                btnwidth = 155;
            }
            else if(iPhoneVersion==61)
            {
                fontsize=30;
                value=6;
                btnx = 6;
                btnheight = 64;
                btnwidth = 171;
            }
            else
            {
                fontsize=50;
                value=8;
                btnx =8;
                btnheight = 89;
                btnwidth = 320;
            }

            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            NSMutableArray *arrFood = [resultDic objectForKey:@"Foodtype"];
            NSString *str_imgs = [[arrFood objectAtIndex:0]valueForKey:@"food_type"];
            NSArray *arr = [[NSArray alloc]init];
            arr = [str_imgs componentsSeparatedByString:@","];
            
            for (int i=0 ; i< arr.count ; i++)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
                if (i%2 == 0)
                {
        
                    [button setBackgroundImage:[UIImage imageNamed:@"first_food_bg.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [button setBackgroundImage:[UIImage imageNamed:@"second_food_bg.png"] forState:UIControlStateNormal];
                }
        
                [button setTitle:[NSString stringWithFormat:@"%@",[arr objectAtIndex:i]] forState:UIControlStateNormal];
                button.tintColor = [UIColor whiteColor];
                button.titleLabel.font = [UIFont fontWithName: @"Redressed" size: fontsize];
                button.frame = CGRectMake(btnx, 0.0, btnwidth, btnheight);
                [self.scrl_Food addSubview:button];
                
                btnx = btnx + (btnwidth+value);
            }
                
            [self.scrl_Food setContentSize:CGSizeMake(btnx,btnheight+1)];
        }
        else
        {
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            arrdata = [[NSMutableArray alloc]init];
            
            arrdata =[resultDic objectForKey:@"Restaurant"];
            
            //Hotel Title
            self.lbl_title.text = [[arrdata objectAtIndex:0]valueForKey:@"name"];
            
            //Loader Image
            NSString *str_imgs = [[arrdata objectAtIndex:0]valueForKey:@"images"];
            NSArray *arr = [[NSArray alloc]init];
            arr = [str_imgs componentsSeparatedByString:@","];
            
            [self.img_loader startLoaderWithTintColor:LoadingColor];
            array = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < [arr count]; i++)
            {
                NSString *url1= [image_Url stringByAppendingString:[arr objectAtIndex:i]];
                url1 = [url1 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                [array addObject:url1];
                
            }
            
            NSLog([array objectAtIndex:0]);
            [self.img_loader sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"Detail_page_img.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [self.img_loader updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [self.img_loader reveal];
            }];
            pageController.numberOfPages = array.count;
            
            [self LoadImageAnimation];
            
            
            //Available At
            NSString *Str = [[arrdata objectAtIndex:0]valueForKey:@"address"];
            Str = [Str stringByReplacingOccurrencesOfString:@" "withString:@""];
            
            Str = [Str stringByReplacingOccurrencesOfString:@","withString:@", "];
            self.lbl_address.text = [[Str stringByAppendingString:@" - "]stringByAppendingString:[[arrdata objectAtIndex:0]valueForKey:@"zipcode"]];
            
            self.lbl_contact.text = [[arrdata objectAtIndex:0]valueForKey:@"phone_no"];
            
            
            //timing
            //self.lbl_monFri_time.text =[[arrdata objectAtIndex:0]valueForKey:@"time"];
            
            // Total Number of Review
            //self.lbl_total_Review.text = [NSString stringWithFormat:@" %@",[[arrdata objectAtIndex:0]valueForKey:@"totalreview"]];
            
            
            //rating
            float rate = [[[arrdata objectAtIndex:0]valueForKey:@"ratting"]floatValue];
            
            HCSStarRatingView *starRatingView = (HCSStarRatingView *) [self.view viewWithTag:1001];;
            
            
            starRatingView.value = rate;
            starRatingView.maximumValue =5;
            starRatingView.minimumValue = 0;
            starRatingView.spacing =3;
            starRatingView.allowsHalfStars =YES;
            starRatingView.accurateHalfStars =YES;
            starRatingView.emptyStarImage = [UIImage imageNamed:@"rate_2.png"];
            starRatingView.filledStarImage = [UIImage imageNamed:@"rate_1.png"];
            // Food Type
            
            
            // Favourite
            
                [self CheckFavourite];
            
            Loading.hidden=YES;
            self.main_view.hidden = NO;
        }
    }
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
        [alert showCustom:self image:nil color:color title:NSLocalizedString(@"Error Alert Title",@"") subTitle:NSLocalizedString(@"Error Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"Error Alert closeButtonTitle",@"") duration:0.0f];
    }
}

// Check Favourite Or Not [From Database ]
-(void)CheckFavourite
{
    SQLFile *new =[[SQLFile alloc]init];
    
    NSString *querynew =[NSString stringWithFormat:@"select * from Favourite where R_id = %@",[[arrdata objectAtIndex:0]valueForKey:@"id"]];
    NSMutableArray *arr_fav = [new select_favou:querynew];
    
    if (arr_fav.count > 0)
    {
        flag_Favourite =0;
        [self.btn_favourite setImage:[UIImage imageNamed:@"favorites_press.png"] forState:UIControlStateNormal];
    }
    else
    {
        flag_Favourite =1;
        [self.btn_favourite setImage:[UIImage imageNamed:@"favorites_unpress.png"] forState:UIControlStateNormal];
    }
    
}

// Swipe Image [ Left & Right Side ]
-(void)LoadImageAnimation
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [self.img_loader addGestureRecognizer:swipeLeft];
    [self.img_loader addGestureRecognizer:swipeRight];
}

// Swipe direction To Swipe
- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (count_Down == array.count-1)
        {
            count_Down = array.count-1;
        }
        else
        {
            count_Down = count_Down + 1;
            CATransition *transition = nil;
            transition = [CATransition animation];
            transition.duration = 0.9;//kAnimationDuration
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype =kCATransitionFromRight;
            transition.delegate = self;
            [self.img_loader.layer addAnimation:transition forKey:nil];
        }
        
        [self.img_loader sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:count_Down]] placeholderImage:[UIImage imageNamed:@"Detail_page_img.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            [self.img_loader updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.img_loader reveal];
        }];
        pageController.currentPage =count_Down;
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (count_Down == 0)
        {
            count_Down = 0;
        }
        else
        {
            count_Down = count_Down - 1;
            CATransition *transition = nil;
            transition = [CATransition animation];
            transition.duration = 0.9;//kAnimationDuration
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype =kCATransitionFromLeft;
            transition.delegate = self;
            [self.img_loader.layer addAnimation:transition forKey:nil];
        }
        
        [self.img_loader sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:count_Down]] placeholderImage:[UIImage imageNamed:@"Detail_page_img.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            [self.img_loader updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.img_loader reveal];
        }];
        
        pageController.currentPage =count_Down;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Admob Ads

// Method for Load interstitial [ Open ADDs in page ]
- (void)createAndLoadInterstitial
{
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = InterstitialID;
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    // request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"   ];
    [self.interstitial loadRequest:request];
}

-(void)Check_interstitial_And_Load_Book_Table_Page
{
    Book_table_Page *next = [self.storyboard instantiateViewControllerWithIdentifier:@"story_bookTable"];
    next.Rest_mail_id = [[arrdata objectAtIndex:0]valueForKey:@"email"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    [self presentModalViewController:next animated:NO];
}

-(void)Check_interstitial_And_Load_ReviewPage
{
    Review_page *next= [self.storyboard instantiateViewControllerWithIdentifier:@"story_review"];
    next.str_Rest_id = [[[arrdata objectAtIndex:0]valueForKey:@"id"]intValue];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentModalViewController:next animated:NO];
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    if (flag_Ads == 1)
        [self Check_interstitial_And_Load_ReviewPage];
    else if (flag_Ads == 2)
        [self Check_interstitial_And_Load_Book_Table_Page];
    
}


#pragma mark - Social Sharing

//Share With FaceBook
- (void)Facebook
{
    mySLcomposerSheet = [[SLComposeViewController alloc]init];
    mySLcomposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    NSString *Str = [[arrdata objectAtIndex:0]valueForKey:@"address"];
    Str = [Str stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    Str = [Str stringByReplacingOccurrencesOfString:@","withString:@", "];
    
    [mySLcomposerSheet setInitialText:[NSString stringWithFormat:@"%@ - %@",self.lbl_title.text,Str]];
    [mySLcomposerSheet addImage:self.img_loader.image];
    [mySLcomposerSheet addURL:[NSURL URLWithString:GameUrl]];
    [mySLcomposerSheet setAccessibilityElementsHidden:YES];
    [self presentViewController:mySLcomposerSheet animated:YES completion:NULL];
}

//Share With WhatsApp
- (void)Whatsapp
{
    NSString * msg = [[@"Application%20" stringByAppendingString:self.lbl_title.text]stringByAppendingString:GameUrl];
    
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

//Share With Twitter
- (void)Twitter
{
    mySLcomposerSheet = [[SLComposeViewController alloc]init];
    mySLcomposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [mySLcomposerSheet setInitialText:[NSString stringWithFormat:@"%@",self.lbl_title.text]];
    [mySLcomposerSheet addImage:self.img_loader.image];
    [mySLcomposerSheet addURL:[NSURL URLWithString:GameUrl]];
    [mySLcomposerSheet setAccessibilityElementsHidden:YES];
    [self presentViewController:mySLcomposerSheet animated:YES completion:NULL];
}

#pragma mark - Bottom Button Click Events

// Press and Open Call dialer
- (IBAction)DO_VIDEO:(id)sender
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.lbl_contact.text]]];
    
}

// Restuarant Location Map Page Call
- (IBAction)DO_LOCATION:(id)sender
{
    Rest_Map_Page *next = [self.storyboard instantiateViewControllerWithIdentifier:@"story_rest_map"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.9;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:transition forKey:nil];
    next.str_title = self.lbl_title.text;
    next.str_Address = self.lbl_address.text;
    next.str_latitude = [[arrdata objectAtIndex:0]valueForKey:@"latitude"];
    next.str_longitude = [[arrdata objectAtIndex:0]valueForKey:@"longitude"];
    [self presentModalViewController:next animated:NO];
    
}

// Book Table Page Call
- (IBAction)DO_TABLE:(id)sender
{
    //Insretitial
    if (self.interstitial.isReady)
    {
        flag_Ads =2;
        [self.interstitial presentFromRootViewController:self];
    }
    else
    {
        [self Check_interstitial_And_Load_Book_Table_Page];
    }
}

// Review Page Call
- (IBAction)DO_REVIEW:(id)sender
{
    
    //Insretitial
    if (self.interstitial.isReady)
    {
        flag_Ads =1;
        [self.interstitial presentFromRootViewController:self];
    }
    else
    {
        [self Check_interstitial_And_Load_ReviewPage];
    }
}

// Go To Previous Page
- (IBAction)DO_BACK:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// Share Hotel Dialoag Open
- (IBAction)DO_SHARE:(id)sender
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    
    [alert addButton:@"Facebook" target:self selector:@selector(Facebook)];
    [alert addButton:@"Whats app" target:self selector:@selector(Whatsapp)];
    [alert addButton:@"Twitter" target:self selector:@selector(Twitter)];
    
    UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
    NSString *Str = [[arrdata objectAtIndex:0]valueForKey:@"address"];
    Str = [Str stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    Str = [Str stringByReplacingOccurrencesOfString:@","withString:@", "];
    [alert setTitleFontFamily:@"Superclarendon" withSize:14.0f];
    [alert showCustom:self image:nil color:color title:self.lbl_title.text subTitle:Str closeButtonTitle:NSLocalizedString(@"Social Cancel", @"") duration:0.0f];
    
}

// Store Data To DataBase For Favourite
- (IBAction)DO_Favourite:(id)sender
{
    
    
    NSString *Str_id = [[arrdata objectAtIndex:0]valueForKey:@"id"];
    NSString *Str_name = [[arrdata objectAtIndex:0]valueForKey:@"name"];
    NSString *Str_add = [[arrdata objectAtIndex:0]valueForKey:@"address"];
    NSString *Str_lati = [[arrdata objectAtIndex:0]valueForKey:@"latitude"];
    NSString *Str_longi = [[arrdata objectAtIndex:0]valueForKey:@"longitude"];
    
    if (flag_Favourite ==1)
    {
        //Insretitial
        if (self.interstitial.isReady)
        {
            [self.interstitial presentFromRootViewController:self];
        }
        
        flag_Favourite =0;
        [self.btn_favourite setImage:[UIImage imageNamed:@"favorites_press.png"] forState:UIControlStateNormal];
        SQLFile *new=[[SQLFile alloc]init];
        NSString *passingstr=[NSString stringWithFormat:@"insert into Favourite values(null,'%@','%@','%@','%@','%@')",Str_id,Str_name,Str_add,Str_lati,Str_longi];
        if ([new operationdb:passingstr]==YES)
        {
            
        }
    }
    else
    {
        flag_Favourite =1;
        [self.btn_favourite setImage:[UIImage imageNamed:@"favorites_unpress.png"] forState:UIControlStateNormal];
        
        SQLFile *new=[[SQLFile alloc]init];
        NSString *passingstr=[NSString stringWithFormat:@"DELETE FROM Favourite WHERE R_id ='%@'",Str_id];
        
        if ([new operationdb:passingstr]==YES)
        {
        }

    }
}
#pragma mark - SetLanguage
-(void)SetLanguage
{
    //self.lbl_rev.text=NSLocalizedString(@"Total Review", @"");
    //self.Lbl_Availableat.text=NSLocalizedString(@"Detail_AVAILABLE AT", @"");
    // self.Lbl_Timing.text=NSLocalizedString(@"Detail_TIMING", @"");
}
@end
