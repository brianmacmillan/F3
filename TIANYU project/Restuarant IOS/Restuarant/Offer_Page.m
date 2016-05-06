//
//  Offer_Page.m
//  Restuarant
//
//  Created by R on 03/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "Offer_Page.h"

@interface Offer_Page ()

@end

@implementation Offer_Page

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self IntializeAdd];
    
    [self SetLanguage];
    
    arrData = [[NSMutableArray alloc]init];
    
    IsNetworkWorking = [self check_network];
    if (IsNetworkWorking)
    {
        [self FrameVersion];
        Loading.hidden = NO;
        Loading.layer.cornerRadius = Loading.frame.size.height/35;
        [self.view addSubview:Loading];
        self.tbldata.hidden =YES;
        
        [self GetData];
    }
    else
        [self CallNetworkNotFoundDialog];
}

-(void)CallNetworkNotFoundDialog{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showWarning:self title:NSLocalizedString(@"Warning Alert Title",@"") subTitle:NSLocalizedString(@"Warning Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"Warning Alert closeButtonTitle",@"") duration:0.0f];
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


#pragma mark - Ads
-(void)IntializeAdd
{
    NSString *adds = [[NSUserDefaults standardUserDefaults]stringForKey:@"ADDS"];
    
    if (adds.length==0 && [Offer_Ads_Show isEqualToString:@"YES"])
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
        self.tbldata.frame = CGRectMake(0,0,320,318);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,401);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,474);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,523);
    else
        self.tbldata.frame = CGRectMake(0,0,768,635);
    
}
//Define Table Hight for  Not-Ads Show
-(void)AdsShow_Table_NO
{
    if (iPhoneVersion == 4)
        self.tbldata.frame = CGRectMake(0,0,320,368);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,451);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,534);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,590);
    else
        self.tbldata.frame = CGRectMake(0,0,768,759);
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
// Call Service [ Offers Details ]
-(void)GetData
{
    WebServiceHelper  *obj_add = [WebServiceHelper new];
    
    [obj_add setCurrentCall:@"offersdetail.php"];
    [obj_add setMethodName:@"offersdetail.php"];
    [obj_add setDelegate:self];
    [obj_add initiateConnection];
}

// Retrive Data From Service
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    if (result)
    {
        NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
        
        NSLog(@" value %@",[resultDic description]);
        
        arrData = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in resultDic)
        {
             NSMutableDictionary *dict_data =[[NSMutableDictionary alloc]init];
            
            NSLog(@"Title :%@",[dict objectForKey:@"title"]);
            NSLog(@"image :%@",[dict objectForKey:@"image"]);
            
            NSString *Str_image_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"image"]];
            Str_image_name = [Str_image_name stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            NSString *url1= [[image_Url stringByAppendingString:@"offers/"]stringByAppendingString:Str_image_name];
            
            [dict_data setValue:[dict objectForKey:@"title"] forKey:@"title"];
            
            [dict_data setValue:url1 forKey:@"image"];
            
            [arrData addObject:dict_data];
        }
        
        
        Loading.hidden = YES;
        self.tbldata.hidden =NO;
        [self.tbldata reloadData];
    }
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
        [alert showCustom:self image:nil color:color title:NSLocalizedString(@"Error Alert Title",@"") subTitle:NSLocalizedString(@"Error Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"Error Alert closeButtonTitle",@"") duration:0.0f];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableView method implementation


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellid";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableDictionary *dict_new = [arrData objectAtIndex:indexPath.row];
    
    UILabel *rest_name =(UILabel*) [cell.contentView viewWithTag:101];
    rest_name.text = [dict_new objectForKey:@"title"];
    
    UIImageView *img_data =(UIImageView *) [cell viewWithTag:102];
    
    [img_data startLoaderWithTintColor:LoadingColor];
    NSString *final = [dict_new objectForKey:@"image"];
    
    
    final = [final stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [img_data sd_setImageWithURL:[NSURL URLWithString:final] placeholderImage:[UIImage imageNamed:@"offer_page_img.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [img_data updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [img_data reveal];
    }];
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select Row :%d",indexPath.row);

}

// Go To Previous Page
- (IBAction)BACK:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)SetLanguage
{
    self.Img_Title.image=[UIImage imageNamed:NSLocalizedString(@"Home_title", nil)];
    
    self.Lbl_Title.text=NSLocalizedString(@"Offer_Title",@"");
}
@end
