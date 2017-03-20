//
//  MXLibraryAPI.h
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 16/05/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MXLibraryAPI : NSObject

+ (MXLibraryAPI*)sharedInstance;
-(NSArray *)getMainTopics;

-(NSArray *)getTenses;

-(NSArray *)getSpokenenglish;

-(NSArray *)getGrammarTopics :(NSString *)category;

-(BOOL)getVoiceSettingsPreference;
-(void)setVoiceSettingsPreference:(BOOL)state;
-(BOOL)getNotificationSettingsPreference;
-(void)setSpeechLanguage:(NSString *)code;
-(NSString*)getSpeechLanguage;
-(void)setVNotificationSettingsPreference:(BOOL)state;

@end
