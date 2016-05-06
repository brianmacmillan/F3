//
//  Review_page.m
//  Restuarant
//
//  Created by R on 05/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "Review_page.h"

@interface Review_page ()

@end

@implementation Review_page

- (void)viewDidLoad {
    [super viewDidLoad];
     [self SetLanguage];
    [self IntializeAdd];
   
    //Insretitial
    if (self.interstitial.isReady)
    {
        [self.interstitial presentFromRootViewController:self];
    }
    
    self.View_table.hidden =YES;
    self.View_Read_Review.hidden =YES;
    
    arrData = [[NSMutableArray alloc]init];
    self.View_dialoag.hidden=YES;
    self.View_table.alpha = 1.0;
    
    [self GetData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FrameVersion
{
    if (iPhoneVersion == 4)
    {
        Loading.frame = CGRectMake(100,200,120,120);
        _View_dialoag.frame =CGRectMake(0,0,320,480);
    }
    else if (iPhoneVersion == 5)
    {
        Loading.frame = CGRectMake(100,250,120,120);
        _View_dialoag.frame =CGRectMake(0,0,320,568);
    }
    else if (iPhoneVersion == 6)
    {
        Loading.frame = CGRectMake(117,280,141,141);
        _View_dialoag.frame =CGRectMake(0,0,375,667);
    }
    else if (iPhoneVersion == 61)
    {
        Loading.frame = CGRectMake(115,330,184,184);
        _View_dialoag.frame =CGRectMake(0,0,414,736);
    }
    else
    {
        Loading.frame = CGRectMake(239,400,289,289);
        _View_dialoag.frame =CGRectMake(0,0,768,1024);
    }
}


#pragma mark - Ads
-(void)IntializeAdd
{
    NSString *adds = [[NSUserDefaults standardUserDefaults]stringForKey:@"ADDS"];
    
    if (adds.length==0 && [Review_Ads_Show isEqualToString:@"YES"])
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
    }else
    {
        [self AdsShow_Table_NO];
        self.bannerView.hidden=YES;
        self.bannerView.backgroundColor=[UIColor clearColor];
    }
}

//Define Table Hight for Ads Show
-(void)AdsShow_Table_YES
{
    if (iPhoneVersion == 4)
        self.tbldata.frame = CGRectMake(0,0,320,378);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,466);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,547);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,603);
    else
        self.tbldata.frame = CGRectMake(0,0,768,776);
    
}
//Define Table Hight for  Not-Ads Show
-(void)AdsShow_Table_NO
{
    if (iPhoneVersion == 4)
        self.tbldata.frame = CGRectMake(0,0,320,428);
    else if (iPhoneVersion == 5)
        self.tbldata.frame = CGRectMake(0,0,320,516);
    else if (iPhoneVersion == 6)
        self.tbldata.frame = CGRectMake(0,0,376,607);
    else if (iPhoneVersion == 61)
        self.tbldata.frame = CGRectMake(0,0,414,670);
    else
        self.tbldata.frame = CGRectMake(0,0,768,900);
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
-(void)CallNetworkNotFoundDialog{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showWarning:self title:NSLocalizedString(@"Warning Alert Title",@"") subTitle:NSLocalizedString(@"Warning Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"Warning Alert closeButtonTitle",@"") duration:0.0f];
}

//Remove Place Holder
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.txt_comments.text isEqualToString:@"Enter Review"]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor]; //optional
    }
    [textView becomeFirstResponder];
}

//Set Place Holder
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter Review";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}


// Call Service [ Review From User ]
-(void)GetData
{
    arrData = [[NSMutableArray alloc]init];
    
    
    IsNetworkWorking = [self check_network];
    if (IsNetworkWorking)
    {
        [self FrameVersion];
        Loading.hidden = NO;
        Loading.layer.cornerRadius = Loading.frame.size.height/35;
        [self.view addSubview:Loading];
        
        WebServiceHelper  *obj_add = [WebServiceHelper new];
        NSString *main;
        main =[NSString stringWithFormat:@"userfeedback.php?value=%d",self.str_Rest_id];
        [obj_add setCurrentCall:main];
        [obj_add setMethodName:main];
        [obj_add setMethodResult:@"userfeedback"];
        [obj_add setDelegate:self];
        [obj_add initiateConnection];
    }
    else
        [self CallNetworkNotFoundDialog];
    
    
    
}

// Retrive Data From Service
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    arrData = [[NSMutableArray alloc]init];
    if (result)
    {
        if ([[editor currentCall] isEqualToString:Fill_User])
        {
            NSMutableArray *arr_dict = [[editor ReturnStr] JSONValue];
            
            NSMutableDictionary * Dict = [[NSMutableDictionary alloc]init];
            
            Dict = [arr_dict objectAtIndex:0];
            

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            NSString *user_id = [Dict objectForKey:@"id"];
            
            NSLog(@"UserID :%@",user_id);
            
            [user setObject:user_id forKey:@"USER_ID"];
            [user synchronize];
            
            
            self.View_Rating.hidden=NO;
            self.View_FillDetail.hidden =YES;
        }
        else if ([[editor currentCall] isEqualToString:Submit_Rate])
        {
            NSMutableDictionary *dict = [[editor ReturnStr] JSONValue];
            NSLog(@"%@",[dict description]);
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
           
            [alert showSuccess:NSLocalizedString(@"ReviewSubmit Alert Title",@"") subTitle:NSLocalizedString(@"ReviewSubmit Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"ReviewSubmit Alert closeButtonTitle",@"") duration:0.0f];
            
            [self GetData];
        }
        else
        {
            arrData = [[NSMutableArray alloc]init];
            
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            for (NSDictionary *dict in [resultDic objectForKey:@"userfeedback"])
            {
                
                NSMutableDictionary *dict_data =[[NSMutableDictionary alloc]init];
                
                NSLog(@"id :%@",[dict objectForKey:@"username"]);
                
                
                [dict_data setValue:[dict objectForKey:@"username"] forKey:@"UserName"];
                [dict_data setValue:[dict objectForKey:@"ratting"] forKey:@"Rate"];
                [dict_data setValue:[dict objectForKey:@"comment"] forKey:@"comments"];
                
                [arrData addObject:dict_data];
            }
            
            Loading.hidden=YES;
            self.View_table.hidden = NO;
            [self.tbldata reloadData];
        }
        
        
    }
    
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
        [alert showCustom:self image:nil color:color title:NSLocalizedString(@"Error Alert Title",@"") subTitle:NSLocalizedString(@"Error Alert SubTitle",@"") closeButtonTitle:NSLocalizedString(@"Error Alert closeButtonTitle",@"") duration:0.0f];
    }

    
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
    
    UIImageView *img_cell =(UIImageView *) [cell viewWithTag:100];
    if (indexPath.row%3 == 0)
    {
        [img_cell setImage:[UIImage imageNamed:@"Fav_cell_3.png"]];
    }
    else
    {
        if (indexPath.row%2 == 0)
        {
            [img_cell setImage:[UIImage imageNamed:@"Fav_cell_2.png"]];
        }
        else
        {
            [img_cell setImage:[UIImage imageNamed:@"Fav_cell_1.png"]];
        }
    }
    
    HCSStarRatingView *starRatingView = (HCSStarRatingView *) [cell viewWithTag:1001];;
    
    float Rate = [[dict_new objectForKey:@"Rate"]floatValue];
    
    starRatingView.value = Rate;
    starRatingView.maximumValue =5;
    starRatingView.minimumValue = 0;
    starRatingView.spacing =3;
    starRatingView.allowsHalfStars =YES;
    starRatingView.accurateHalfStars =YES;
    starRatingView.emptyStarImage = [UIImage imageNamed:@"rate_2.png"];
    starRatingView.filledStarImage = [UIImage imageNamed:@"rate_1.png"];
    
    NSString *strTitle = [dict_new objectForKey:@"UserName"];
    NSString *firstLetter = [[strTitle substringToIndex:1] uppercaseString];
    
    UILabel *Hotel_tag =(UILabel*) [cell.contentView viewWithTag:101];
    Hotel_tag.text = [firstLetter uppercaseString];
    
    UILabel *Reviewer_name =(UILabel*) [cell.contentView viewWithTag:102];
    Reviewer_name.text = [dict_new objectForKey:@"UserName"];
    
    UILabel *Review_details =(UILabel*) [cell.contentView viewWithTag:103];
    Review_details.textColor = [UIColor darkGrayColor];
    Review_details.text = [dict_new objectForKey:@"comments"];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    [self.view addSubview:self.View_Read_Review];
    self.View_Read_Review.hidden=NO;
    
    NSMutableDictionary *dict_new = [arrData objectAtIndex:indexPath.row];
    
    
    
    HCSStarRatingView *starRatingView = (HCSStarRatingView *) [self.View_Read_Review viewWithTag:1001];;
    
    float rate = [[dict_new objectForKey:@"Rate"]floatValue];
    NSLog(@"%f",rate);
    
    starRatingView.value = rate;
    starRatingView.maximumValue =5;
    starRatingView.minimumValue = 0;
    starRatingView.spacing =3;
    starRatingView.allowsHalfStars =YES;
    starRatingView.accurateHalfStars =YES;
    starRatingView.emptyStarImage = [UIImage imageNamed:@"rate_2.png"];
    starRatingView.filledStarImage = [UIImage imageNamed:@"rate_1.png"];
    
    self.txt_Read_comments.text =[dict_new objectForKey:@"comments"];
    
    self.lbl_Read_user_name.text = [dict_new objectForKey:@"UserName"];
    
    self.View_Read_Review.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.View_Read_Review.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
    }];
}

// Open Dialoag To Add Review
- (IBAction)DO_ADD_Review:(id)sender
{
    self.View_Rating.hidden=YES;
    self.View_FillDetail.hidden =YES;
    [self.view addSubview:self.View_dialoag];
    self.View_dialoag.hidden=NO;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userid = [user stringForKey:@"USER_ID"];
    if ([userid length]>0)
    {
        self.View_FillDetail.hidden =YES;
        self.View_Rating.hidden=NO;
    }
    else
    {
        self.View_Rating.hidden=YES;
        self.View_FillDetail.hidden =NO;
    }
    self.Rating.value = 2;
    self.Rating.maximumValue =5;
    self.Rating.minimumValue = 0;
    self.Rating.spacing =3;
    self.Rating.allowsHalfStars =NO;
    self.Rating.accurateHalfStars =NO;
    self.Rating.emptyStarImage = [UIImage imageNamed:@"rate_2.png"];
    self.Rating.filledStarImage = [UIImage imageNamed:@"rate_1.png"];
    
    self.View_dialoag.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.View_dialoag.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
    }];
}

// Add Rating
- (IBAction)didChangeValue:(HCSStarRatingView *)sender
{
    NSLog(@"Changed rating to %.1f", sender.value);
    
    self.Rating.value = sender.value;
    
    str_user_Rating = [NSString stringWithFormat:@"%f",self.Rating.value];
    
}

// Submit Review
- (IBAction)DO_SUBMIT:(id)sender
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userid = [user stringForKey:@"USER_ID"];
    
    NSString *str_text;
    if ([self.txt_comments.text isEqualToString:@"Enter Review"])
    {
        str_text = @"";
    }
    else
    {
        str_text = self.txt_comments.text;
    }
    str_text = [str_text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    WebServiceHelper  *obj = [WebServiceHelper new];
    Submit_Rate =[NSString stringWithFormat:@"userfeedback.php?res_id=%@&&user_id=%@&&ratting=%@&&comment=%@",[NSString stringWithFormat:@"%d",self.str_Rest_id],userid,str_user_Rating,str_text];
    [obj setCurrentCall:Submit_Rate];
    [obj setMethodName:Submit_Rate];
    [obj setDelegate:self];
    [obj initiateConnection];
    
    self.View_dialoag.hidden = YES;
}

// Hide Dialoag
- (IBAction)DO_CANCEL:(id)sender
{
    self.View_dialoag.hidden = YES;
   
}

// Go To Previous Page
- (IBAction)BACK:(id)sender
{
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

// Validation For Name
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

// Validation For Mail
-(void)validationCheckFormail
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //Valid email address
    if ([emailTest evaluateWithObject:self.txt_emal_id.text] == YES )
    {
        self.Error_mail.hidden=YES;
    }
    else
    {
        self.Error_mail.hidden=NO;
    }
}

// User-Name -> Did end Editing  : [Add Review]
- (IBAction)DO_txt_Name:(id)sender
{
    [self validationCheckForName];
}

// User-mail -> Did end Editing  : [Add Review]
- (IBAction)DO_txt_Email_id:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
}

// Submit user Detail
- (IBAction)DO_Submit_UserDetail:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //Valid email address
    if ([emailTest evaluateWithObject:self.txt_emal_id.text] != YES)
    {
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
        
        WebServiceHelper  *obj = [WebServiceHelper new];
        Fill_User =[NSString stringWithFormat:@"adduser.php?username=%@&&email=%@",str_name,str_email];
        [obj setCurrentCall:Fill_User];
        [obj setMethodName:Fill_User];
        [obj setDelegate:self];
        [obj initiateConnection];
    }
}


- (IBAction)DO_OK:(id)sender
{
    self.View_Read_Review.hidden = YES;
}

-(void)SetLanguage
{//Same as Home page Dialog..
    self.lbl_name.text=NSLocalizedString(@"Name", @"");
    self.lbl_mailid.text=NSLocalizedString(@"E_mail", @"");
    self.txt_name.placeholder=NSLocalizedString(@"Txt_Name", @"");
    self.txt_emal_id.placeholder=NSLocalizedString(@"Txt_E_mail", @"");
    self.txt_Read_comments.text=NSLocalizedString(@"TxtReview", @"");
    self.txt_comments.text=NSLocalizedString(@"TxtComment", @"");
    
    self.Lbl_Title.text=NSLocalizedString(@"Review_title", @"");
    self.Lbl_yourexprience.text=NSLocalizedString(@"Review_yourexprience", @"");
    self.Lbl_Dialog_submit.text=NSLocalizedString(@"Dialog_submit", @"");
    self.Lbl_Dialog_cancel.text=NSLocalizedString(@"Dialog_cancel", @"");
    self.Lbl_Dialog2_Submit.text=NSLocalizedString(@"Dialog_submit", @"");
    self.Lbl_Dialog2_Cancel.text=NSLocalizedString(@"Dialog_cancel", @"");
    self.Lbl_ok.text=NSLocalizedString(@"Review_ok", @"");
}

@end
