//
//  Utils.m
//  English Grammar Ultimate
//
//  Created by Sudhi.S on 20/05/14.
//  Copyright (c) 2014 maxlogix. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(NSString *)processHTMLString:(NSString *)htmlString
{
    NSArray *components = [htmlString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
    }
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    NSString *str=@"@import \"style.css\";@import \"style_responcive.css\";@import \"mystyle.css\";@import \"font-awesome.css\";@import \"bootstrap.min.css\";font { font-family: fontawesome-webfont; }";
    NSString* result =[plainText stringByReplacingOccurrencesOfString:str withString:@""];
    NSString* finalresult =[result stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return finalresult;
}
@end
