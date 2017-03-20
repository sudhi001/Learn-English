//
//  MXSpeechSynthesis.h
//  EnglishGrammarUltimate
//
//  Created by Sudhi.S on 26/07/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import <Foundation/Foundation.h>
@import  AVFoundation;

@interface MXSpeechSynthesis : NSObject 
@property (nonatomic,strong)AVSpeechSynthesizer *kAVSpeechSynthesizer;
@property (nonatomic,strong)NSString *speechString;
-(void)speakTextFromNonHTMLString:(NSString *)htmlContent;
-(void)stopSpeeking;
-(NSArray *)getSpeechVoies;
@end
