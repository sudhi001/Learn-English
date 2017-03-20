//
//  MXUINavigationController.h
//  Learn English
//
//  Created by Sudhi.S on 27/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCVerticalMenu.h"
#import "MXLibraryAPI.h"
#import <MessageUI/MessageUI.h>
@interface MXUINavigationController : UINavigationController <FCVerticalMenuDelegate>

@property (strong, readonly, nonatomic) FCVerticalMenu *verticalMenu;

-(IBAction)openVerticalMenu:(id)sender;
-(void)closeMenu;
-(void)setNavigationBarVissibility:(BOOL)hidden animated:(BOOL)animated;
@end
