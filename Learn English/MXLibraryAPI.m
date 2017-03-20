//
//  MXLibraryAPI.m
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 16/05/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import "MXLibraryAPI.h"
#import "MXPersistencyManager.h"
#define VOICE_SETTING @"Voice_onn_off"
#define SPEECH_LANGUAGE @"speechlanguage"
#define NOTIFICATION @"Notification_onn_off"
@implementation MXLibraryAPI
{
     MXPersistencyManager *persistencyManager;
     NSUserDefaults *defaults;
}
#pragma Singleton
+(MXLibraryAPI*)sharedInstance
{
    static MXLibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MXLibraryAPI alloc] init];
    });
    return _sharedInstance;
}
#pragma init
- (id)init
{
    self = [super init];
    if (self) {
        persistencyManager = [[MXPersistencyManager alloc] init];
        defaults = [NSUserDefaults standardUserDefaults];
        
    }
    return self;
}

-(NSArray *)getMainTopics
{
    
    return [persistencyManager getMainTopics];
}
-(NSArray *)getTenses
{
    return [persistencyManager getTenses];
}
-(NSArray *)getSpokenenglish
{
    return [persistencyManager getSpokenenglish];
}
-(NSArray *)getGrammarTopics :(NSString *)category
{
    return [persistencyManager getGrammarTopics:category];
}

-(BOOL)getVoiceSettingsPreference
{
    NSString *onn_off=[defaults objectForKey:VOICE_SETTING];
    return onn_off==nil?YES:([onn_off isEqualToString:@"YES"]?YES:NO);
}
-(BOOL)getNotificationSettingsPreference
{
    NSString *onn_off=[defaults objectForKey:NOTIFICATION];
    return onn_off==nil?NO:([onn_off isEqualToString:@"YES"]?YES:NO);
}
-(void)setVoiceSettingsPreference:(BOOL)state
{
    [defaults setObject:state==YES?@"YES":@"NO" forKey:VOICE_SETTING];
    [defaults synchronize];
}
-(void)setVNotificationSettingsPreference:(BOOL)state
{
    [defaults setObject:state==YES?@"YES":@"NO" forKey:NOTIFICATION];
    [defaults synchronize];
}
-(void)setSpeechLanguage:(NSString *)code
{
    [[NSUserDefaults standardUserDefaults] setObject:code forKey:SPEECH_LANGUAGE ];
}
-(NSString*)getSpeechLanguage
{
    NSString *speechCode=[[NSUserDefaults standardUserDefaults] stringForKey:SPEECH_LANGUAGE];
    return speechCode==nil?@"en-US":speechCode;
}
@end
