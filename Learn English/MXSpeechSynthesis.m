//
//  MXSpeechSynthesis.m
//  EnglishGrammarUltimate
//
//  Created by Sudhi.S on 26/07/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import "MXSpeechSynthesis.h"
#import "MXLibraryAPI.h"

@implementation MXSpeechSynthesis
-(id)init{
    self=[super init];
    if(self){
        _kAVSpeechSynthesizer = [AVSpeechSynthesizer new];
        
      
    }
    return self;
}


-(void)speakTextFromNonHTMLString:(NSString *)htmlContent{
    
if([_kAVSpeechSynthesizer  isSpeaking]){
    if(![htmlContent isEqualToString:_speechString]){
        [self stopSpeeking];
        _speechString=htmlContent;
    }
}
   AVSpeechUtterance *kAVSpeechUtterance=[[AVSpeechUtterance alloc] initWithString:htmlContent];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:  [[MXLibraryAPI sharedInstance]getSpeechLanguage]];
    kAVSpeechUtterance.voice=voice;
    [kAVSpeechUtterance setRate:0];
    [_kAVSpeechSynthesizer speakUtterance:kAVSpeechUtterance];
    
    
}
-(void)stopSpeeking
{
    if([_kAVSpeechSynthesizer  isSpeaking]){
        [_kAVSpeechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@""];
        [_kAVSpeechSynthesizer speakUtterance:utterance];
        [_kAVSpeechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

-(NSArray *)getSpeechVoies
{
    return [AVSpeechSynthesisVoice speechVoices];
}

@end
