//
//  SQLFile.h
//  MEDICINES
//
//  Created by Tianyu Ren on 4/17/16.
//  Copyright (c) 2016 Food for Friends. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "AppDelegate.h"


@interface SQLFile : NSObject
{
    sqlite3 *database;
    AppDelegate *appd;
    NSString *strdbname;
    
}

@property(strong,nonatomic)AppDelegate *appd;


-(BOOL)operationdb:(NSString *)str;
-(NSMutableArray *)selectrecord:(NSString *)strqr;
-(NSMutableArray *)select_cate:(NSString *)strqr;
-(NSMutableArray *)note:(NSString *)strqr;
-(NSMutableArray *)select_favou:(NSString *)strqr;



-(BOOL)updatedb:(NSString *)strupdate;
@end
