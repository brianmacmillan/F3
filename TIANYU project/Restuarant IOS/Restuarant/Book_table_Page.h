//
//  Book_table_Page.h
//  Restuarant
//
//  Created by R on 09/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetPicker.h"
#import "SCLAlertView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Book_table_Page : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UITextFieldDelegate>
{
    int counter;
    
}

@property(strong,nonatomic)NSString *Rest_mail_id;

@property (strong, nonatomic) IBOutlet UITextField *txt_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_mail_id;
@property (strong, nonatomic) IBOutlet UITextField *txt_phone;
@property (strong, nonatomic) IBOutlet UILabel *txt_Date;
@property (strong, nonatomic) IBOutlet UILabel *txt_Time;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_email;

@property (weak, nonatomic) IBOutlet UILabel *lbl_phone;

@property (weak, nonatomic) IBOutlet UILabel *lbl_date;

@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_numberofperson;





@property (strong, nonatomic) IBOutlet UITextField *txt_num_of_person;

@property (strong, nonatomic) IBOutlet UITextView *txt_comments;



- (IBAction)DO_MINUES:(id)sender;
- (IBAction)DO_PLUSE:(id)sender;
- (IBAction)DO_BOOK_NOW:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *Error_name;
@property (strong, nonatomic) IBOutlet UIImageView *Error_mail;
@property (strong, nonatomic) IBOutlet UIImageView *Error_phone;
@property (strong, nonatomic) IBOutlet UIImageView *Error_date;
@property (strong, nonatomic) IBOutlet UIImageView *Error_time;
@property (strong, nonatomic) IBOutlet UIImageView *Error_Num_of_person;

- (IBAction)DO_txt_name:(id)sender;
- (IBAction)DO_txt_email:(id)sender;
- (IBAction)DO_txt_phone:(id)sender;
- (IBAction)DO_txt_num_of_person:(id)sender;
- (IBAction)DO_txt_date:(id)sender;
- (IBAction)DO_txt_time:(id)sender;




- (IBAction)DO_DATE:(id)sender;
- (IBAction)DO_TIME:(id)sender;



- (IBAction)BACK:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *Lbl_Title;

@property (weak, nonatomic) IBOutlet UILabel *Lbl_Booknow;

@end
