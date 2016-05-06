//
//  Favourite_Page.m
//  Restuarant
//
//  Created by R on 08/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "Favourite_Page.h"

@interface Favourite_Page ()<LocationDelegate> {
    
    BOOL _didAcquireLocation;
}
@end

@implementation Favourite_Page


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetLanguage];
    [self IntializeAdd];

}


#pragma mark UserUpdated Location

-(void)appDelegate:(AppDelegate *)appDelegate locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location Failed");
    
}

-(void)appDelegate:(AppDelegate *)appDelegate locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    
    if(!_didAcquireLocation) {
        _didAcquireLocation = YES;
        
    }
}

-(void)appDelegate:(AppDelegate *)appDelegate sensorError:(CLLocationManager *)manager {
    NSLog(@"Location Failed");
}

#pragma mark - Ads
-(void)IntializeAdd
{
    NSString *adds = [[NSUserDefaults standardUserDefaults]stringForKey:@"ADDS"];
    
    if (adds.length==0 && [favourite_Ads_Show isEqualToString:@"YES"])
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
        self.tbldata.frame = CGRectMake(0,0,320,326);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,410);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,482);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,531);
    else
        self.tbldata.frame = CGRectMake(0,0,768,651);
    
}
//Define Table Hight for  Not-Ads Show
-(void)AdsShow_Table_NO
{
    if (iPhoneVersion == 4)
        self.tbldata.frame = CGRectMake(0,0,320,376);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,460);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,542);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,598);
    else
        self.tbldata.frame = CGRectMake(0,0,768,775);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getdata];
}


// Retrive Data From Database When User Press Favourite
-(void)getdata
{
    SQLFile *new =[[SQLFile alloc]init];
    
    NSString *querynew =[NSString stringWithFormat:@"select * from Favourite"];
    
    arr_favourity =[new select_favou:querynew];
    
    for (int i=0; i<[arr_favourity count]; i++) {
        
        NSMutableDictionary *temp = [arr_favourity objectAtIndex:i];
        
        CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[temp objectForKey:@"R_lati"] doubleValue] longitude:[[temp objectForKey:@"R_longi"]doubleValue]];
        
        AppDelegate* instance = [AppDelegate instance];
        
        CLLocationDistance distance = [locA distanceFromLocation:instance.myLocation];
        
        NSLog(@"Calculated Miles %@", [NSString stringWithFormat:@"%.1fmi",(distance/1609.344)]);
        
        [temp setValue:[NSString stringWithFormat:@"%0.02f",(distance/1609.344)] forKey:@"Miles"];
        
        [arr_favourity replaceObjectAtIndex:i withObject:temp];
    }

    [self.tbldata reloadData];
    
}

#pragma mark - UITableView method implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_favourity.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dict_category =[arr_favourity objectAtIndex:indexPath.row];
    
    UIImageView *img_data =(UIImageView *) [cell viewWithTag:100];
    if (indexPath.row%3 == 0)
    {
        [img_data setImage:[UIImage imageNamed:@"Fav_cell_3.png"]];
    }
    else
    {
        if (indexPath.row%2 == 0)
        {
           [img_data setImage:[UIImage imageNamed:@"Fav_cell_2.png"]];
        }
        else
        {
            [img_data setImage:[UIImage imageNamed:@"Fav_cell_1.png"]];
        }
    }
    
    
    
    UILabel *Hotel_name =(UILabel*) [cell.contentView viewWithTag:101];
    Hotel_name.text = [dict_category objectForKey:@"R_name"];
    
    UILabel *Hotel_add =(UILabel*) [cell.contentView viewWithTag:102];
    Hotel_add.textColor = [UIColor darkGrayColor];
    Hotel_add.text = [dict_category objectForKey:@"R_add"];
    
    NSString *strTitle = [dict_category objectForKey:@"R_name"];
    NSString *firstLetter = [[strTitle substringToIndex:1] uppercaseString];
    
    UILabel *rest_Km =(UILabel*) [cell.contentView viewWithTag:103];
    rest_Km.textColor = [UIColor darkGrayColor];
    rest_Km.text = [NSString stringWithFormat:@"%@ %@",[dict_category objectForKey:@"Miles"],NSLocalizedString(@"distance",@"")];
    
    UILabel *Hotel_tag =(UILabel*) [cell.contentView viewWithTag:104];
    Hotel_tag.text = [firstLetter uppercaseString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *dict_category =[arr_favourity objectAtIndex:indexPath.row];
 
    Rest_details *next = [self.storyboard instantiateViewControllerWithIdentifier:@"story_rest_details"];
    next.Rest_id = [[dict_category objectForKey:@"R_id"]intValue];
    [self.navigationController pushViewController:next animated:YES];
    
    //Insretitial
    if (self.interstitial.isReady)
    {
        [self.interstitial presentFromRootViewController:self];
    }
}

// Go To Previous Page
- (IBAction)BACK:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)SetLanguage
{
    self.Img_Title.image=[UIImage imageNamed:NSLocalizedString(@"Home_title", nil)];
    
    self.Lbl_Title.text=NSLocalizedString(@"Favourite_Title",@"");
}
@end
