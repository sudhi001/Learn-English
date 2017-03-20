//
//  MXPersistencyManager.h
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 16/05/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXPersistencyManager : NSObject

-(NSArray *)getMainTopics;

-(NSArray *)getTenses;

-(NSArray *)getSpokenenglish;

-(NSArray *)getGrammarTopics :(NSString *)category;

@end
