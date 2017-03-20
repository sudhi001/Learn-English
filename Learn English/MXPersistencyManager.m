//
//  MXPersistencyManager.m
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 16/05/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import "MXPersistencyManager.h"
#import "MXSQLiteManager.h"

#define MAIN_TOPICS_BY_GROUP @"SELECT * from main_topics group by category"
#define SPOKEN_ENGLISH_BY_GROUP @"SELECT * from spoken_english group by category"
#define SELECT_CATEGORY_TABLE @"SELECT * from CATEGORY"
#define SELECT_LEVEL_TABLE @"SELECT * from LEVEL WHERE CATEGORY_ID = '%@'"
#define SELECT_QUESTIONS_TABLE @"SELECT * from QUESTION WHERE CATEGORY_ID = '%@' AND LEVEL_ID = '%@'"
#define TENSES_TABLE @"tenses_topics"
#define CATEGORY_TABLE @"CATEGORY"
#define LEVEL_TABLE @"LEVEL"
#define QUESTIONS_TABLE @"QUESTION"
#define GRAMMAR_DATA_CONTENTS_BY_CATEGORY "SELECT * FROM main_topics WHERE category = '%@'"

@implementation MXPersistencyManager
{
     NSArray *main_topics;
     NSArray *tenses;
     NSArray *spokenEnglish;
}
- (id)init
{
    self = [super init];
    if (self) {

         main_topics =[[MXSQLiteManager sharedInstance] executeSql:MAIN_TOPICS_BY_GROUP];
         tenses =[[MXSQLiteManager sharedInstance] findAllFrom:TENSES_TABLE];
         spokenEnglish =[[MXSQLiteManager sharedInstance] executeSql:SPOKEN_ENGLISH_BY_GROUP];

    }
    return self;
}
-(NSArray *)getMainTopics
{
    return main_topics;
}
-(NSArray *)getTenses
{
    return tenses;
}
-(NSArray *)getGrammarTopics :(NSString *)category
{
    return [[MXSQLiteManager sharedInstance] executeSql:[NSString stringWithFormat:@GRAMMAR_DATA_CONTENTS_BY_CATEGORY,category]];
}

-(NSArray *)getSpokenenglish
{
    return spokenEnglish;
}


@end
