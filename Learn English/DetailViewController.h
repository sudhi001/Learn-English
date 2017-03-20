//
//  DetailViewController.h
//  Learn English
//
//  Created by Sudhi.S on 27/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "UIColor+BFPaperColors.h"
#import "MXLibraryAPI.h"
#import "MXSpeech.h"
#import "Utils.h"
#import "MXUINavigationController.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,assign )  NSInteger selection;
@property (nonatomic,strong )  NSString *selectionStr;
@property (nonatomic,strong )NSDictionary *dictionary;
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl;
@end
