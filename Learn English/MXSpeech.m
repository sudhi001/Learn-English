//
//  MXSpeech.m
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 02/10/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import "MXSpeech.h"

@implementation MXSpeech
+(MXSpeech*)sharedInstance
{
    static MXSpeech *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MXSpeech alloc] init];
    });
    return _sharedInstance;
}

@end
