//
//  Book_table_Page.m
//  Restuarant
//
//  Created by R on 09/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "Book_table_Page.h"

@interface Book_table_Page ()

@end

@implementation Book_table_Page

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetLanguage];
    
    self.Error_name.hidden =YES;
    self.Error_mail.hidden =YES;
    self.Error_phone.hidden =YES;
    self.Error_date.hidden =YES;
    self.Error_time.hidden =YES;
    self.Error_Num_of_person.hidden =YES;
    
    
    
    counter = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Remove Place Holder
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.txt_comments.text isEqualToString:@"Comments !!!!"]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor]; //optional
    }
    [textView becomeFirstResponder];
}

//Set Place Holder
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Comments !!!!";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

// Validation For Name
-(void)validationCheckForName
{
    if ([self.txt_name.text isEqualToString:@""])
    {
        self.Error_name.hidden=NO;
    }
    else
    {
        self.Error_name.hidden=YES;
    }
}

// Validation For Mail
-(void)validationCheckFormail
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([emailTest evaluateWithObject:self.txt_mail_id.text] == YES )
    {
        self.Error_mail.hidden=YES;
    }
    else
    {
        self.Error_mail.hidden=NO;
    }
}

// Validation For Phone number
-(void)validationCheckForPhone
{
    NSString *phoneRegEx = @"^([+]{1})([0-9]{2,6})([-]{1})([0-9]{10})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    if([phoneTest evaluateWithObject:self.txt_phone.text]==YES)
    {
        self.Error_phone.hidden=YES;
        
    }
    else
    {
        self.Error_phone.hidden=NO;
        self.txt_phone.text =@"";
        self.txt_phone.placeholder =@"+99-9999999999";
    }
}

// Validation For Date
-(void)validationCheckForDate
{
    if ([self.txt_Date.text isEqualToString:@""])
    {
        self.Error_date.hidden=NO;
    }
    else
    {
        self.Error_date.hidden=YES;
    }
}

// Validation For Time
-(void)validationCheckForTime
{
    if ([self.txt_Time.text isEqualToString:@""])
    {
        self.Error_time.hidden=NO;
    }
    else
    {
        self.Error_time.hidden=YES;
    }
}

// Validation For Number Of Person
-(void)validationCheckForNUM_Of_Person
{
    if ([self.txt_num_of_person.text isEqualToString:@""])
    {
        self.Error_Num_of_person.hidden=NO;
    }
    else
    {
        self.Error_Num_of_person.hidden=YES;
    }
}

// User-Name -> Did end Editing  : [Book Table]
- (IBAction)DO_txt_name:(id)sender
{
    [self validationCheckForName];
    
}

// User-mail -> Did end Editing  : [Book Table]
- (IBAction)DO_txt_email:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
}

// User-Phone -> Did end Editing  : [Book Table]
- (IBAction)DO_txt_phone:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
    [self.txt_phone setKeyboardType:UIKeyboardTypeNumberPad];
  //  [self validationCheckForPhone];
}

// Book Date -> Did end Editing  : [Book Table]
- (IBAction)DO_txt_date:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
//    [self validationCheckForPhone];
    [self validationCheckForDate];
}

// Book time -> Did end Editing  : [Book Table]
- (IBAction)DO_txt_time:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
//    [self validationCheckForPhone];
    [self validationCheckForDate];
    [self validationCheckForTime];
}

// Num.of Person -> Did end Editing  : [Book Table]
- (IBAction)DO_txt_num_of_person:(id)sender
{
    [self validationCheckForName];
    [self validationCheckFormail];
//    [self validationCheckForPhone];
    [self validationCheckForDate];
    [self validationCheckForTime];
    [self validationCheckForNUM_Of_Person];
}



// Open Date Picker
- (IBAction)DO_DATE:(id)sender
{
    [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"DatePicker Title", @"") datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *d1 = [dateFormat stringFromDate:selectedDate];
       self.Error_date.hidden=YES;
        self.txt_Date.text = d1;

        
        NSLog(@"%@",d1);
        
    } cancelBlock:^(ActionSheetDatePicker *picker)
    {
        NSLog(@"ActionSheetDatePicker Canceled");
        self.Error_date.hidden=NO;
    } origin:sender];
}

// Open Time Picker
- (IBAction)DO_TIME:(id)sender
{
    [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"TimePicker Title", @"") datePickerMode:UIDatePickerModeTime selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mm:a"];
        NSString *d1 = [dateFormat stringFromDate:selectedDate];
        self.Error_time.hidden=YES;
        self.txt_Time.text = d1;
        
        
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        NSLog(@"ActionSheetDatePicker Canceled");
        self.Error_time.hidden=NO;
    } origin:sender];
}

// Press (-) Minues Button Action [ Num. of Person ]
- (IBAction)DO_MINUES:(id)sender
{
    [self validationCheckForNUM_Of_Person];
    if (counter <= 0)
    {
        self.txt_num_of_person.text =0;
    }
    else
    {
        counter = counter - 1;
        self.txt_num_of_person.text = [NSString stringWithFormat:@"%d",counter];
    }
}

// Press (+) Plus Button Action [ Num. of Person ]
- (IBAction)DO_PLUSE:(id)sender
{
    
    counter = counter + 1;
    self.txt_num_of_person.text = [NSString stringWithFormat:@"%d",counter];
    [self validationCheckForNUM_Of_Person];
}

// Submit For Book-Table
- (IBAction)DO_BOOK_NOW:(id)sender
{
    if ([self.txt_name.text isEqualToString:@""] || [self.txt_mail_id.text isEqualToString:@""] || [self.txt_phone.text isEqualToString:@""] || [self.txt_Date.text isEqualToString:@""] || [self.txt_Time.text isEqualToString:@""] || [self.txt_num_of_person.text isEqualToString:@""] )
    {
        [self validationCheckForName];
        [self validationCheckFormail];
//        [self validationCheckForPhone];
        [self validationCheckForDate];
        [self validationCheckForTime];
        [self validationCheckForNUM_Of_Person];
    }
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        
        [alert addButton:NSLocalizedString(@"Book Alert Button1", @"") target:self selector:@selector(Message)];
        [alert addButton:NSLocalizedString(@"Book Alert Button2", @"") target:self selector:@selector(Mail)];
        
        
        UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
        
        [alert showCustom:self image:nil color:color title:NSLocalizedString(@"Book Alert Title", @"") subTitle:nil closeButtonTitle:NSLocalizedString(@"Book Alert closeButtonTitle", @"") duration:0.0f];
    }
}

// send Details By Message
- (void)Message
{
    if(![MFMessageComposeViewController canSendText])
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message Alert Title", @"") message:NSLocalizedString(@"Message Alert SubTitle", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Message Alert closeButtonTitle", @"") otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[self.txt_phone.text];
    
    NSString *name = [NSString stringWithFormat:@"Name: %@",self.txt_name.text];
    NSString *MailID = [NSString stringWithFormat:@"Mail ID: %@",self.txt_mail_id.text];
    NSString *ContactNo = [NSString stringWithFormat:@"Contact No : %@",self.txt_phone.text];
    NSString *No_of_Person = [NSString stringWithFormat:@"Number of Person: %@",self.txt_num_of_person.text];
    NSString *Date = [NSString stringWithFormat:@"Date: %@",self.txt_Date.text];
    NSString *Time = [NSString stringWithFormat:@"Time: %@",self.txt_Time.text];
    NSString *Comment = [NSString stringWithFormat:@"Comment: %@",self.txt_comments.text];
    
    NSString *message = [[[[[[[[[[[[name stringByAppendingString:@",\n"] stringByAppendingString:MailID]
        stringByAppendingString:@",\n"]
        stringByAppendingString:ContactNo]
        stringByAppendingString:@",\n"]
        stringByAppendingString:No_of_Person]
        stringByAppendingString:@",\n"]
        stringByAppendingString:Date]
        stringByAppendingString:@",\n"]
        stringByAppendingString:Time]
        stringByAppendingString:@",\n"]
        stringByAppendingString:Comment];
    
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

// send Details By Mail
- (void)Mail
{
    
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setToRecipients:[NSArray arrayWithObjects:self.Rest_mail_id,nil]];
        [mailCont setSubject:@"Order Book"];
        
        NSString *name = [NSString stringWithFormat:@"<b>Name:</b> %@",self.txt_name.text];
        NSString *MailID = [NSString stringWithFormat:@"<b>Mail ID: </b>%@",self.txt_mail_id.text];
        NSString *ContactNo = [NSString stringWithFormat:@"<b>Contact No : </b>%@",self.txt_phone.text];
        NSString *No_of_Person = [NSString stringWithFormat:@"<b>Number of Person: </b>%@",self.txt_num_of_person.text];
        NSString *Date = [NSString stringWithFormat:@"<b>Date: </b>%@",self.txt_Date.text];
        NSString *Time = [NSString stringWithFormat:@"<b>Time: </b>%@",self.txt_Time.text];
        NSString *Comment = [NSString stringWithFormat:@"<b>Comment: </b>%@",self.txt_comments.text];
        
        NSString *html =[NSString stringWithFormat:@"%@<br>%@<br>%@<br>%@<br>%@<br>%@<br>%@<br>",name,MailID,ContactNo,No_of_Person,Date,Time,Comment];
        
        [mailCont setMessageBody:html isHTML:YES];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}


#pragma mark - mail compose delegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
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
    [self dismissModalViewControllerAnimated:YES];
}
-(void)SetLanguage
{
    self.lbl_name.text=NSLocalizedString(@"Name", @"");
    self.lbl_email.text=NSLocalizedString(@"Mail Id", @"");
    self.lbl_date.text=NSLocalizedString(@"Date", @"");
    self.lbl_time.text=NSLocalizedString(@"Time", @"");
    self.lbl_phone.text=NSLocalizedString(@"Phone Number", @"");
    self.lbl_numberofperson.text=NSLocalizedString(@"Person", @"");
    self.txt_name.placeholder=NSLocalizedString(@"Enter Your Name", @"");
    self.txt_mail_id.placeholder=NSLocalizedString(@"Enter Your Mail id", @"");
    self.txt_phone.placeholder=NSLocalizedString(@"Phone no", @"");
    self.txt_comments.text=NSLocalizedString(@"Txtcom", @"");
    
    self.Lbl_Title.text=NSLocalizedString(@"Book_Title", @"");
    
    self.Lbl_Booknow.text=NSLocalizedString(@"Book_Booknow", @"");
}
@end
