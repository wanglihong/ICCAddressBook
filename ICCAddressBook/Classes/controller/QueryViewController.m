//
//  QueryViewController.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryViewController.h"
#import "DetailViewController.h"
#import "ICCAddressBookCell.h"
#import "Person.h"
#import "Data.h"
#import "tooles.h"

@implementation QueryViewController

@synthesize results = _results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"搜索";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _results = [[NSMutableArray alloc] init];
    /*
    for(id cc in [searchB subviews]) {
        if([cc isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    */
    UIBarButtonItem *rithtBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" 
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self 
                                                                    action:@selector(hideKeyboard)];
    self.navigationItem.rightBarButtonItem = rithtBarItem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _tableView = nil;
}

- (void)dealloc
{
    [_results release];
    [super dealloc];
}





#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ICCAddressBookCell *cell = (ICCAddressBookCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ICCAddressBookCell" owner:self options:nil] lastObject];
    }
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.1];
    }
    
    
    
    Person *person = (Person *)[_results objectAtIndex:indexPath.row];
    
    cell.chineseNameLabel.text  = person.chineseName;
    cell.englishNameLabel.text  = person.englishName;
    cell.teamLabel.text         = person.team;
    cell.positionLabel.text     = person.position;
    cell.extLabel.text          = person.ext;
    cell.phoneLabel.text        = person.phone;
    cell.emailLabel.text        = person.email;
    cell.msnLabel.text          = person.msn;
    cell.telephoneLabel.text    = person.telephone;
    
    return cell;
}





#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Person *person = [_results objectAtIndex:indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.person = person;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
}





#pragma mark - 
#pragma mark Search bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    NSString *keyworks = searchBar.text;
    
    [self search:keyworks];    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)hideKeyboard {
    [searchB resignFirstResponder];
}





#pragma mark - 
#pragma mark search

- (void)search:(NSString *)condition {
    
    [[tooles sharedTooles] showHUD:@"搜索数据..."];
    
    [NSThread detachNewThreadSelector:@selector(srarchResultWithCondition:) toTarget:self withObject:condition];
}

- (void)searchFinished {
    
    [[tooles sharedTooles] removeHUD];
    
    [_tableView reloadData];
}

- (void)srarchResultWithCondition:(NSString *)condition {
    
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    
    
    
    [_results removeAllObjects];
    
    for (Person *person in [[Data sharedData] records]) {
        
        if ([person.chineseName rangeOfString:condition].length > 0 
            || [person.englishName rangeOfString:condition].length > 0) {
            
            [_results addObject:person];
        }
        
    }
    
    
    
    [self performSelectorOnMainThread:@selector(searchFinished) withObject:nil waitUntilDone:NO]; 
    
    [pool release]; 
}

@end
