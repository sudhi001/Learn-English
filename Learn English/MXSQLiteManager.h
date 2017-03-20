//
//  MXSQLiteManager.h
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 16/05/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#define databaseName    @"max_english.sqlite"

@interface MXSQLiteManager : NSObject
{
    NSString *databasePath;
}
+(MXSQLiteManager*)sharedInstance;
-(void) checkAndCreateDatabaseWithOverwrite:(BOOL)overwriteDB;
#pragma SQL : SQL METHOD
-(NSArray *)findAllFrom:(NSString *)table;
-(NSArray *)find:(NSString *)field from:(NSString *)table where:(NSString *)condition;
-(NSArray *)find:(NSString *)field from:(NSString *)table where:(NSString *)condition order:(NSString *)order limit:(NSString *)limit;
-(BOOL)save:(NSMutableDictionary *)data into:(NSString *)table;
-(BOOL)deleteRowWithId:(int)idRow from:(NSString *)table;
-(id)executeSql:(NSString *)sql;
@property(nonatomic, retain) NSString *databasePath;

@end
