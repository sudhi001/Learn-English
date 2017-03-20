//
//  ViewController.m
//  Learn English
//
//  Created by Sudhi.S on 26/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, strong) NSArray *tenses;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *spoken;

@property (nonatomic, assign) NSInteger selection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Engish Grammar Ultimate"];
    _tenses=[[MXLibraryAPI sharedInstance] getTenses];
     _topics=[[MXLibraryAPI sharedInstance] getMainTopics];
    _spoken=[[MXLibraryAPI sharedInstance] getSpokenenglish];

    [self addSegMentView];
     _selection=0;
      self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_selection) {
        case 0:  return _topics.count;
        case 1:  return _tenses.count;
        case 2:  return _spoken.count;
        default: return 0;
    }
 
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell;
 
           cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
   
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    UILabel *sub_category = (UILabel *)[cell viewWithTag:2];
    NSDictionary *dict;
    switch (_selection) {
        case 0:
            dict=_topics[indexPath.row];
               title.text=[NSString stringWithFormat:@"\u25C9 %@",[dict valueForKey:@"category"]];
            sub_category.text=[[dict valueForKey:@"sub_category"]stringByDeletingPathExtension];
             [self setSelectionCellColour:cell with:[UIColor paperColorOrange700]];
            break;
        case 1:dict= _tenses[indexPath.row];
             sub_category.text=[[dict valueForKey:@"sub_title"]stringByDeletingPathExtension];
               title.text=[NSString stringWithFormat:@"\u25C9 %@",[[dict valueForKey:@"subcategory"] stringByDeletingPathExtension ]];
              [self setSelectionCellColour:cell with:[UIColor paperColorOrange700]];
            break;
        case 2:dict= _spoken[indexPath.row];
             sub_category.text=[[dict valueForKey:@"sub_title"]stringByDeletingPathExtension];
               title.text=[NSString stringWithFormat:@"\u25C9 %@",[[dict valueForKey:@"category"] stringByDeletingPathExtension ]];
             [self setSelectionCellColour:cell with:[UIColor paperColorOrange700]];
            break;
        
        default:
            break;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
 
   
 
    return cell;
}
-(void)setSelectionCellColour:(UITableViewCell *)cell with:(UIColor *)colour
{
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor =colour; ;
    cell.selectedBackgroundView=customColorView;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
       DetailViewController *controller= [segue destinationViewController];
    controller.selection =_selection;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    switch (_selection) {
        case 0:{
               NSDictionary *dict=_topics[indexPath.row];
               controller.selectionStr=[[dict valueForKey:@"category"]stringByDeletingPathExtension];
               }
            break;
        case 1: {
            NSDictionary *dict=_tenses[indexPath.row];
            controller.selectionStr=[[dict valueForKey:@"subcategory"]stringByDeletingPathExtension];
               controller.dictionary=dict;
                }
            break;
        case 2:{
               NSDictionary *dict= _spoken[indexPath.row];
               controller.selectionStr=[[dict valueForKey:@"category"]stringByDeletingPathExtension];
              controller.dictionary=dict;
               }
            break;
        default:
            break;
    }

 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if(_selection!=3&&_selection!=4&&_selection!=5&&_selection!=6){
            if (_lastContentOffset > scrollView.contentOffset.y)
            {
                if(self.navigationController.navigationBarHidden){
                    [((MXUINavigationController *)self.navigationController)  setNavigationBarVissibility:NO animated:YES];
                  
                }
            }
            else if (_lastContentOffset < scrollView.contentOffset.y)
            {
                if(!self.navigationController.navigationBarHidden){
                    [((MXUINavigationController *)self.navigationController)  setNavigationBarVissibility:YES animated:YES];
                 
                }
            }
        
            _lastContentOffset = scrollView.contentOffset.y;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
       [((MXUINavigationController *)self.navigationController) setNavigationBarVissibility:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [((MXUINavigationController *)self.navigationController) setNavigationBarVissibility:NO animated:YES];
    
}
#pragma mark- Segment
-(void)addSegMentView
{
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Topics", @"Tenses", @"Spoken English" ]];
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
    segmentedControl1.selectedSegmentIndex=_selection;
    [self.view addSubview:segmentedControl1];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(openVerticalMenu:)];

    [shareButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:26.0], NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = shareButton;

      [self.tableView setContentInset:UIEdgeInsetsMake(50,0,20,0)];
     self.automaticallyAdjustsScrollViewInsets = YES;
   
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
   
    _selection=segmentedControl.selectedSegmentIndex;
    [_tableView reloadData];
 
}


@end
