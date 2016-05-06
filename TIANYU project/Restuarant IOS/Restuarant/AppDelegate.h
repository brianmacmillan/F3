//
//  AppDelegate.h
//  Restuarant
//
//  Created by R on 01/10/2015.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class AppDelegate;

@protocol LocationDelegate <NSObject>

-(void) appDelegate:(AppDelegate*)appDelegate locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
       fromLocation:(CLLocation *)oldLocation;

-(void) appDelegate:(AppDelegate*)appDelegate locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error;

@optional
-(void) appDelegate:(AppDelegate*)appDelegate sensorError: (CLLocationManager *)manager;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    id <LocationDelegate> _locationDelegate;
    
    NSString *strdbpath;
}

@property (strong, retain) id <LocationDelegate> locationDelegate;
+(AppDelegate*) instance;

@property (nonatomic, strong) CLLocation* myLocation;

-(void)findMyCurrentLocation;

@property (strong,nonatomic) UIWindow *window;

@property(strong,nonatomic)NSString *strdbpath;

-(void)CopyandCheckdb;

@end

