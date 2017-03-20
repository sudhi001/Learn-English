//
//  DetailViewController.m
//  Learn English
//
//  Created by Sudhi.S on 27/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import "DetailViewController.h"

#define HEAD_LINKS @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"> <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"he\" lang=\"he\"><head><style type=\"text/css\" media=\"all\">@import \"style.css\";</style><style type=\"text/css\" media=\"all\">@import \"style_responcive.css\";</style><style type=\"text/css\" media=\"all\">@import \"mystyle.css\";</style><style type=\"text/css\" media=\"all\">@import \"font-awesome.css\";</style><style type=\"text/css\" media=\"all\">@import \"bootstrap.min.css\";</style><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><style type='text/css'>font { font-family: fontawesome-webfont; } </style></head><body>%@</body></html> "

@interface DetailViewController ()
@property (nonatomic, strong) NSArray *datas;
@end

@implementation DetailViewController
int selection=0;

- (void)viewDidLoad {
    [super viewDidLoad];
 [((MXUINavigationController *)self.navigationController)  setNavigationBarVissibility:NO animated:YES];
    [[self navigationItem] setTitle:@"Engish Grammar Ultimate"];
         selection=0;


}

#pragma mark- Segment
-(void)addSegMentView
{
    NSMutableArray *subTitles= [[NSMutableArray alloc]init];
    for (int i=0; i<_datas.count; i++) {
        NSDictionary *obj=_datas[i];
        [subTitles addObject:[[obj valueForKey:@"sub_category"]stringByDeletingPathExtension]];
    }
    if(subTitles.count==0){
          [subTitles addObject:_selectionStr];
     
    }
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:subTitles];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    segmentedControl1.selectionIndicatorHeight=3;
    segmentedControl1.textColor = [UIColor paperColorOrange700];
    segmentedControl1.selectionIndicatorColor = [UIColor paperColorOrange700];
    segmentedControl1.selectionIndicatorBoxOpacity=0.05;
    segmentedControl1.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    segmentedControl1.selectedTextColor = [UIColor paperColorOrange700];
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl1.layer.masksToBounds = NO;
    segmentedControl1.layer.shadowOffset = CGSizeMake(-3,1);
    segmentedControl1.layer.shadowRadius = 2;
    segmentedControl1.layer.shadowOpacity = 0.2;
    segmentedControl1.selectedSegmentIndex=selection;
    [self.view addSubview:segmentedControl1];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(openVerticalMenu:)];
    
    [shareButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:26.0], NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = shareButton;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_selection==0){
        
        _datas = [[MXLibraryAPI sharedInstance] getGrammarTopics:_selectionStr];
        _dictionary=_datas[selection];
    }
    
    [self addSegMentView];
      [self loadToView];
    [self listen:self];
    [((MXUINavigationController *)self.navigationController)  setNavigationBarVissibility:NO animated:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(listen:)
                                                 name:@"ListenStatus"
                                               object:nil];
}  
-(void)viewWillDisappear:(BOOL)animated
{
    [[MXSpeech sharedInstance] stopSpeeking];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    [((MXUINavigationController *)self.navigationController)  setNavigationBarVissibility:NO animated:YES];
  
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    selection=(int)segmentedControl.selectedSegmentIndex;
         _dictionary=_datas[selection];
    [self loadToView];
    [self listen:self];
  

}
-(void)loadToView
{
    NSString *htmlContent =[NSString stringWithFormat:HEAD_LINKS,[_dictionary valueForKey:@"content_body" ]];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [_webView loadHTMLString:htmlContent baseURL:baseURL];
}
-(void)listen:(id)sender
{
   
    if([[MXLibraryAPI sharedInstance]getVoiceSettingsPreference ]){
        NSString *context=[Utils processHTMLString:[_dictionary valueForKey:@"content_body" ]];
        [[MXSpeech sharedInstance] speakTextFromNonHTMLString:context];
    }else{
        [[MXSpeech sharedInstance] stopSpeeking];
    }
}
@end
