//
//  MXUINavigationController.m
//  Learn English
//
//  Created by Sudhi.S on 27/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import "MXUINavigationController.h"
#import "UIColor+BFPaperColors.h"
#define FACEBOOK_URL @"https://www.facebook.com/Grammarapp"
#define GOOGLE_PLUS_URL @"https://plus.google.com/101911010094831826438"
#define TWITTER_URL @"https://twitter.com/themaxlogix"
#define ABOUT_US @"http://grammarultimatefree.appscloudfactory.com"
#define RATE_IT @"https://itunes.apple.com/app/english-gammas-ultimate-free/id1168261305"
@interface MXUINavigationController ()<MFMailComposeViewControllerDelegate>

@end

@implementation MXUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVerticalMenu];
    self.verticalMenu.delegate = self;
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.verticalMenu.liveBlurBackgroundStyle = self.navigationBar.barStyle;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FCVerticalMenu Configuration
- (void)configureVerticalMenu
{
    FCVerticalMenuItem *item1 = [[FCVerticalMenuItem alloc] initWithTitle:@"Listen"
                                                             andIconImage:[UIImage imageNamed:@"sound"]];
    
    FCVerticalMenuItem *item2 = [[FCVerticalMenuItem alloc] initWithTitle:@"Share"
                                                             andIconImage:[UIImage imageNamed:@"share"]];
    
    FCVerticalMenuItem *item3 = [[FCVerticalMenuItem alloc] initWithTitle:@"Contact Us"
                                                             andIconImage:[UIImage imageNamed:@"mail"]];
//    FCVerticalMenuItem *item4 = [[FCVerticalMenuItem alloc] initWithTitle:@"Facebook"
//                                                             andIconImage:[UIImage imageNamed:@"fb"]];
//    
//    FCVerticalMenuItem *item5 = [[FCVerticalMenuItem alloc] initWithTitle:@"Twitter"
//                                                             andIconImage:[UIImage imageNamed:@"tw"]];
//    
//    FCVerticalMenuItem *item6 = [[FCVerticalMenuItem alloc] initWithTitle:@"Google Plus"
//                                                             andIconImage:[UIImage imageNamed:@"g"]];
 
    item1.actionBlock = ^{
        if([[MXLibraryAPI sharedInstance]getVoiceSettingsPreference ]){
            [[MXLibraryAPI sharedInstance] setVoiceSettingsPreference:NO];
        }else{
            [[MXLibraryAPI sharedInstance]setVoiceSettingsPreference:YES];
        }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"ListenStatus"
         object:self];
     
    };
 
    item2.actionBlock = ^{
        NSArray *objectsToShare = @[@"English Grammar Utlimate is a great application. Please download from Appstore https://itunes.apple.com/app/english-grammar-ultimate/id828459522"];
        UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        [self presentViewController:controller animated:YES completion:nil];

        
    };
    item3.actionBlock = ^{
        
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
            mailer.mailComposeDelegate = self;
            
            [mailer setSubject:@"Support For Engish Grammar Ultimate Version 2.0"];
            
            NSArray *toRecipients = @[@"themaxlogix@gmail.com"];
            [mailer setToRecipients:toRecipients];
            
            [mailer setMessageBody:@"Hi,\n" isHTML:NO];
            
            [self presentViewController:mailer animated:YES completion:NULL];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                            message:@"Your device doesn't support the composer sheet"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            
        }

    
        
    };
    item4.actionBlock = ^{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:FACEBOOK_URL]];
        
    };
    item5.actionBlock = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TWITTER_URL]];
        
    };
    item6.actionBlock = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:GOOGLE_PLUS_URL]];
        
    };
    _verticalMenu = [[FCVerticalMenu alloc] initWithItems:@[item1, item2, item3,item4,item5,item6]];
    _verticalMenu.appearsBehindNavigationBar = YES;
    
}

-(IBAction)openVerticalMenu:(id)sender
{
    if (_verticalMenu.isOpen)
        return [_verticalMenu dismissWithCompletionBlock:nil];
    
    [_verticalMenu showFromNavigationBar:self.navigationBar inView:self.view];
}


#pragma mark - FCVerticalMenu Delegate Methods

-(void)menuWillOpen:(FCVerticalMenu *)menu
{
}

-(void)menuDidOpen:(FCVerticalMenu *)menu
{

}

-(void)menuWillClose:(FCVerticalMenu *)menu
{
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)closeMenu
{

    if (_verticalMenu.isOpen)
        return [_verticalMenu dismissWithCompletionBlock:nil];
}
-(void)setNavigationBarVissibility:(BOOL)hidden animated:(BOOL)animated
{
    [self setNavigationBarHidden:hidden animated:animated];
    [self closeMenu];
}
-(void)menuDidClose:(FCVerticalMenu *)menu
{

}


@end
