//
//  TeamViewController.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TeamViewController.h"
#import "DetailViewController.h"
#import "Person.h"
#import "Data.h"

@implementation TeamViewController

@synthesize teamNames = _teamNames;
@synthesize teams = _teams;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"组";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _teamNames = [[NSMutableArray alloc] init];
    _teams = [[NSMutableArray alloc] init];
    
    
    [self separateTeam];
    
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
}

- (void)dealloc
{
    [_teamNames release];
    [_teams release];
    free(flag);
    [super dealloc];
}





#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_teamNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    NSMutableArray *team = [_teams objectAtIndex:indexPath.section];
    Person *person = [team objectAtIndex:indexPath.row];
    
    UILabel *lable = (UILabel *)[cell viewWithTag:7];
    if (!lable) {
        lable = [[UILabel alloc]initWithFrame:CGRectMake(60.0, 5.0, 220.0, 30.0)];
		lable.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lable.backgroundColor = [UIColor clearColor];
		lable.textColor = [UIColor blackColor];
		lable.tag = 7;
		[cell addSubview:lable];
		[lable release];
    }
    lable.text = person.chineseName;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSMutableArray *team = [_teams objectAtIndex:section];
    
    
    
    // header view
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setTag:section];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // left arrows
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
	
	if(flag[section]) image.image = [UIImage imageNamed:@"normal.png"];
	else image.image = [UIImage imageNamed:@"pressed.png"];
    
	if(!flag[section]) image.transform=CGAffineTransformMakeRotation(-1.58);
	else image.transform=CGAffineTransformMakeRotation(1.58);
    
	[button addSubview:image];
	[image release];
    
    
    
    // titile
    CGFloat width = [[_teamNames objectAtIndex:section] sizeWithFont:[UIFont boldSystemFontOfSize:16]].width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, width+200, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor blackColor];
	label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
	label.text = [NSString stringWithFormat:@"%@ (%i人)", [_teamNames objectAtIndex:section], [team count]];
    
	[button addSubview:label];
	[label release];
    
    
    
    // separator
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
	line.backgroundColor = [UIColor colorWithWhite:0. alpha:.25];
    
	[button addSubview:line];
	[line release];
    
    return button;
}





#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableArray *team = [_teams objectAtIndex:indexPath.section];
    Person *person = [team objectAtIndex:indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.person = person;
    detailViewController.title = person.chineseName;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
}







#pragma mark - 
#pragma mark methods about team

- (void)separateTeam {
    
    for (Person *person in [[Data sharedData] records]) {
        
        if (![_teamNames containsObject:person.team]) {
            [_teamNames addObject:person.team];
        }
        
    }
    
    [self createTeam];
}

- (void)checkData {
    
    int count = 0;
    
    for (NSMutableArray *team in _teams) {
        
        NSLog(@"-----------%@-------------", [_teamNames objectAtIndex:count]);
        
        for (Person *person in team) {
            NSLog(@"%i:%@", count, person.chineseName);
        }
        
        count ++;
    }
}

- (void)createTeam {
    
    for (NSString *teamName in _teamNames) {
        
        NSMutableArray *team = [[NSMutableArray alloc] init];
        
        for (Person *person in [[Data sharedData] records]) {
            
            if ([person.team isEqualToString:teamName]) {
                [team addObject:person];
            }
            
        }
        
        [_teams addObject:team];
        [team release];
    }
    
    [self stateOfTeam];
}

- (void)stateOfTeam {
    
    //[self checkData];
    flag = (BOOL*)malloc([_teamNames count] * sizeof(BOOL*));
	memset(flag, NO, sizeof(flag) * [_teamNames count]);
}

-(void)headerClicked:(id)sender {
    
	NSInteger section = ((UIButton*)sender).tag;
	flag[section] = !flag[section];
	//[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationTop];
	[self.tableView reloadData];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {  
    
    NSMutableArray *team = (NSMutableArray*)[_teams objectAtIndex:section];
    
    if (flag[section])  
        
        return [team  count];  
    
    else 
        
        return 0;  
    
}

@end
