//
//  About.m
//  Resto
//
//  Created by Redixbit on 12/10/15.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "About.h"

@interface About ()

@end

@implementation About

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
     [self SetLanguage];
    if (iPhoneVersion==4) {
        self.Scrollview.contentSize=CGSizeMake(0, 500);
        [self.Scrollview    setShowsVerticalScrollIndicator:NO];
    }
    else if (iPhoneVersion==5) {
            self.Scrollview.contentSize=CGSizeMake(0, 550);
            [self.Scrollview    setShowsVerticalScrollIndicator:NO];
        }
    else if (iPhoneVersion==6) {
        self.Scrollview.contentSize=CGSizeMake(0, 1000);
        [self.Scrollview    setShowsVerticalScrollIndicator:NO];
    }
    else if (iPhoneVersion==61) {
        self.Scrollview.contentSize=CGSizeMake(0, 1000);
        [self.Scrollview    setShowsVerticalScrollIndicator:NO];
    }
    else
    {
        self.Scrollview.contentSize=CGSizeMake(0, 1250);
        [self.Scrollview    setShowsVerticalScrollIndicator:NO];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Go To Previous Page
- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)SetLanguage
{
    self.Lbl_Title.text=NSLocalizedString(@"Aboutus_title",@"");
}


@end
