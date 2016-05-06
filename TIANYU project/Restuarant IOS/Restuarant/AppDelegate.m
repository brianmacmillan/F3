//
//  AppDelegate.m
//  Restuarant
//
//  Created by R on 01/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Constants.h"

@interface AppDelegate () <CLLocationManagerDelegate> {
    
    CLLocationManager* _myLocationManager;
}

@end

@implementation AppDelegate
@synthesize strdbpath,window;
@synthesize myLocation;
@synthesize locationDelegate = _locationDelegate;

+(AppDelegate *)instance {
    
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self CopyandCheckdb];
    
    if (iPhoneVersion == 4)
    {
        ViewController*loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"]; //or the homeController
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginController];
        self.window.rootViewController=navController;
    }
    else if(iPhoneVersion==5)
    {
        ViewController*loginController=[[UIStoryboard storyboardWithName:@"Mainfive" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"]; //or the homeController
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginController];
        self.window.rootViewController=navController;
    }
    else if(iPhoneVersion==6)
    {
        ViewController*loginController=[[UIStoryboard storyboardWithName:@"Mainsix" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"]; //or the homeController
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginController];
        self.window.rootViewController=navController;
    }
    else if(iPhoneVersion==61)
    {
        ViewController*loginController=[[UIStoryboard storyboardWithName:@"Mainsixplus" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"]; //or the homeController
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginController];
        self.window.rootViewController=navController;
    }
    else
    {
        ViewController*loginController=[[UIStoryboard storyboardWithName:@"Mainipad" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"]; //or the homeController
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginController];
        self.window.rootViewController=navController;
    }

    
    [self findMyCurrentLocation];
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    ViewController *temp = [[ViewController alloc]init];
    [temp.arrData removeAllObjects];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)CopyandCheckdb
{
    NSArray *dirpath = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    NSString *docdir =[dirpath objectAtIndex:0];
    
    self.strdbpath =[docdir stringByAppendingString :@"Restaurant_DB.sqlite"];
    
    NSLog(@"dbpath =%@",self.strdbpath);
    
    BOOL success;
    
    NSFileManager *fm =[NSFileManager defaultManager];
    
    success =[fm fileExistsAtPath:self.strdbpath];
    
    
    
    if (success)
    {
        NSLog(@"Already Present");
        
    }
    else
    {
        NSError *err;
        NSString *resource =[[NSBundle mainBundle]pathForResource:@"Restaurant_DB" ofType:@"sqlite"];
        
        success =[fm copyItemAtPath:resource toPath:self.strdbpath error:&err];
        
        if (success)
        {
            NSLog(@"Successfully Created");
        }
        else
        {
            NSLog(@"Error = %@",err);
        }
    }
}

#pragma mark - FIND USER LOCATION

-(void)findMyCurrentLocation {
    
    if(_myLocationManager == nil) {
        _myLocationManager = [[CLLocationManager alloc] init];
        _myLocationManager.delegate = self;
    }
    
    if(IS_OS_8_OR_LATER) {
        [_myLocationManager requestWhenInUseAuthorization];
        [_myLocationManager requestAlwaysAuthorization];
    }
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse ||
        authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        
        [_myLocationManager startUpdatingLocation];
        
    }
    
    if( [CLLocationManager locationServicesEnabled] ) {
        NSLog(@"Location Services Enabled....");
    }
    else {
        
        if([self.locationDelegate respondsToSelector:@selector(appDelegate:sensorError:)])
            [self.locationDelegate appDelegate:self sensorError:_myLocationManager];
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    myLocation = newLocation;
    
    if([self.locationDelegate respondsToSelector:@selector(appDelegate:locationManager:didUpdateToLocation:fromLocation:)]) {
        [self.locationDelegate appDelegate:self
                           locationManager:manager
                       didUpdateToLocation:newLocation
                              fromLocation:oldLocation];
    }
}


- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error {
    
    if([self.locationDelegate respondsToSelector:@selector(appDelegate:sensorError:)]) {
        [self.locationDelegate appDelegate:self
                           locationManager:manager
                          didFailWithError:error];
    }
}


@end
