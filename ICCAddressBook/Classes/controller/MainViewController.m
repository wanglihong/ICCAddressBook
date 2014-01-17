//
//  MainViewController.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "ICCAddressBookCell.h"
#import "TFHpple.h"
#import "Person.h"
#import "Data.h"
#import "tooles.h"


typedef enum {
    PHONE_CALL = 0,
    SEND_MSG,
    SHOW_DETAIL
} buttonTAG;


@implementation MainViewController

@synthesize tableView = _tableView;
@synthesize records = _records;
@synthesize indexPath = _indexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"通讯录";
    }
    return self;
}

- (void)recoverLocalData {
    
    [self.records removeAllObjects];
    
    for (Person *person in [[Data sharedData] records]) {
        [self.records addObject:person];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rithtBarItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" 
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self 
                                                                    action:@selector(steal)];
    self.navigationItem.rightBarButtonItem = rithtBarItem;
    
    
    
    
    self.records = [[NSMutableArray alloc] init];
    
    if ([[Data sharedData] numberOfRecords] == 0) {
        [self steal];
    } else {
        [self recoverLocalData];
    }
    
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
    [self.tableView release];
    [self.records release];
    [self.indexPath release];
    [super dealloc];
}





#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.records count];
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.clipsToBounds = YES;
    cell.clipsToBounds = YES;
    
    
    
    Person *person = (Person *)[self.records objectAtIndex:indexPath.row];
    
    cell.chineseNameLabel.text  = person.chineseName;
    cell.englishNameLabel.text  = person.englishName;
    cell.teamLabel.text         = person.team;
    cell.positionLabel.text     = person.position;
    cell.extLabel.text          = person.ext;
    cell.phoneLabel.text        = person.phone;
    cell.emailLabel.text        = person.email;
    cell.msnLabel.text          = person.msn;
    cell.telephoneLabel.text    = person.telephone;
    cell.buttonCall.person      = person;
    cell.buttonMSM.person       = person;
    cell.buttonDet.person       = person;
    cell.person                 = person;
    cell.delegate               = self;
    
    
    
    return cell;
}





#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_indexPath isEqual:indexPath]) {
        return 140.0;
    }
    
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_indexPath isEqual:indexPath]) {
        
        self.indexPath = nil;
        
    } else {
        
        self.indexPath = indexPath;
        
    }
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}





#pragma mark - 
#pragma mark Search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    for (UIView *view in [searchBar subviews]) { 
        
        if ([view conformsToProtocol:@protocol(UITextInputTraits)]) {    
            @try {
                // set style of keyboard
                //[(UITextField *)view setKeyboardAppearance:UIKeyboardAppearanceAlert];
                
                // always force return key to be enabled
                [(UITextField *)view setEnablesReturnKeyAutomatically:NO];
            }
            @catch (NSException * e) {        
                // ignore exception
            }
        }
    }


    UITextField *searchField = [[searchBar subviews] lastObject];
    [searchField setReturnKeyType:UIReturnKeyDone];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if (searchBar.text.length == 0) {
        [self recoverLocalData];
        [self.tableView reloadData];
        
        return;
    }
    
    [self search:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
}





#pragma mark - 
#pragma mark search

- (void)search:(NSString *)condition {
    
    [[tooles sharedTooles] showHUD:@"查询..."];
    
    [NSThread detachNewThreadSelector:@selector(srarchResultWithCondition:) toTarget:self withObject:condition];
}

- (void)searchFinished {
    
    [[tooles sharedTooles] removeHUD];
    
    [self.tableView reloadData];
}

- (void)srarchResultWithCondition:(NSString *)condition {
    
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    
    
    
    [self.records removeAllObjects];
    
    for (Person *person in [[Data sharedData] records]) {
        
        if ([person.chineseName rangeOfString:condition].length > 0 
            || [person.englishName rangeOfString:condition].length > 0) {
            
            [self.records addObject:person];
        }
        
    }
    
    
    
    [self performSelectorOnMainThread:@selector(searchFinished) withObject:nil waitUntilDone:NO]; 
    
    [pool release]; 
}






#pragma mark -
#pragma mark crawl

- (void)steal {
    
    [[tooles sharedTooles] showHUD:@"加载数据..."];
    [self performSelector:@selector(stealFailed) withObject:nil afterDelay:60.0];
    
    
    [NSThread detachNewThreadSelector:@selector(crawl) toTarget:self withObject:nil];
}

- (void)stealFinished {
    
    [[tooles sharedTooles] removeHUD];
    
    
    
    [self recoverLocalData];
    [self.tableView reloadData];
    [[Data sharedData] write];
}

- (void)stealFailed {
    
   [[tooles sharedTooles] removeHUD];
}

- (void)crawl {
    
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    
#define target @"http://192.168.0.1/iprinthouse/ehr/staff/txl.asp"
    
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:target]];
    TFHpple *crawler = [[TFHpple alloc] initWithHTMLData:htmlData];
    [htmlData release];
    
    NSArray *elements_chineseName   = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=1]/div"];
    NSArray *elements_englishName   = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=2]/div"];
    NSArray *elements_teamBelong    = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=3]/div"];
    NSArray *elements_position      = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=4]/div"];
    NSArray *elements_ext           = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=5]/div"];
    NSArray *elements_phone         = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=6]/div"];
    NSArray *elements_email         = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=7]/div"];
    NSArray *elements_msn           = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=8]"];
    NSArray *elements_telephone     = [crawler search:@"//tr[@bgcolor='#FFFFFF']/td[position()=9]"];
    
    
    [[Data sharedData] clear];//千万不能让数据叠加
    
    for (int i = 0; i < [elements_chineseName count]; i++) {
		
        Person *person = [Person new];
        
		person.chineseName  = [[elements_chineseName objectAtIndex:i] content];
        person.englishName  = [[elements_englishName objectAtIndex:i] content];
        person.team         = [[elements_teamBelong objectAtIndex:i] content];
        person.position     = [[elements_position objectAtIndex:i] content];
        person.ext          = [[elements_ext objectAtIndex:i] content];
        person.phone        = [[elements_phone objectAtIndex:i] content];
        person.email        = [[elements_email objectAtIndex:i] content];
        person.msn          = [[elements_msn objectAtIndex:i] content];
        person.telephone    = [[elements_telephone objectAtIndex:i] content];
        
        [[Data sharedData] addRecord:person];
        [person release];
    }
    
    [crawler release];
    
    [self performSelectorOnMainThread:@selector(stealFinished) withObject:nil waitUntilDone:NO]; 
    
    [pool release]; 
}





#pragma mark -
#pragma mark Bubble delegate

- (void)sendMessageTo:(Person *)person {
	
	if ([MFMessageComposeViewController canSendText]) {
        
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.recipients = [NSArray arrayWithObject:person.phone];
		picker.messageComposeDelegate = self;
		picker.body = @"hello";
		
		[self presentModalViewController:picker animated:YES];
		[picker release];
		
	}
	
}

- (void)makePhoneCall:(Person *)person {
    
    NSString *telString = [NSString stringWithFormat:@"tel://%@",person.phone];
    
    NSURL *telURL = [NSURL URLWithString:telString];
    
    [[UIApplication sharedApplication] openURL:telURL];
    
}

- (void)showDetails:(Person *)person {
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.person = person;
    detailViewController.title = person.chineseName;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
    
}





#pragma mark -
#pragma mark MFMessageComposeViewController delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	/*
	// Notifies users about errors associated with the interface
	switch (result) {
		case MessageComposeResultCancelled:
			if (DEBUG) NSLog(@"Result: canceled");
			break;
		case MessageComposeResultSent:
			if (DEBUG) NSLog(@"Result: Sent");
			break;
		case MessageComposeResultFailed:
			if (DEBUG) NSLog(@"Result: Failed");
			break;
		default:
			break;
	}*/
	[self dismissModalViewControllerAnimated:YES];	
}

@end
