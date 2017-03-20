//
//  ViewController.h
//  Learn English
//
//  Created by Sudhi.S on 26/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "UIColor+BFPaperColors.h"
#import "DetailViewController.h"
#import "MXUINavigationController.h"



@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl;
@end

