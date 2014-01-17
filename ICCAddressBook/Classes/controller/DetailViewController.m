//
//  DetailViewController.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize person = _person;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"个人信息";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rithtBarItem = [[UIBarButtonItem alloc] initWithTitle:@"添加到地址簿" 
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self 
                                                                    action:@selector(addToAddressBook)];
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
}

- (void)dealloc
{
    [_person release];
    [super dealloc];
}





#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    if (indexPath.row == 4) {
        UIButton *contact = [UIButton buttonWithType:UIButtonTypeCustom];
        [contact setBackgroundImage:[UIImage imageNamed:@"contact.png"] forState:UIControlStateNormal];
        [contact addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
        [contact setFrame:CGRectMake(240, 0, 44, 44)];
        [cell addSubview:contact];
    }
    
    
    NSArray *titles = [NSArray arrayWithObjects:@"英文名：",@"组名：", @"职位：", @"分机号码：", @"手机号码：", @"Email：", @"MSN：", @"宅电：",  nil];
    NSArray *values = [NSArray arrayWithObjects:_person.englishName, _person.team, _person.position, _person.ext, _person.phone, _person.email, _person.msn, _person.telephone, nil];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", [titles objectAtIndex:indexPath.row], [values objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    return cell;
}





#pragma mark -
#pragma mark Address book

- (BOOL)personIsAlreadyExist {
    
    // Fetch the address book 
	ABAddressBookRef addressBook = ABAddressBookCreate();
    
	// Search for the person named "Appleseed" in the address book
	NSArray *people = (NSArray *)ABAddressBookCopyPeopleWithName(addressBook, (CFStringRef)_person.chineseName);
    
	// Display "Appleseed" information if found in the address book 
	if ((people != nil) && [people count]) {
        return YES;
    }
    
    return NO;
}

- (void)addToAddressBook {
    
    if ([self personIsAlreadyExist]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                        message:@"通讯录列表中已经存在该联系人。" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        
        return;
    }
    
    
    
    CFErrorRef error = NULL;
    
    //打开数据库,创建一个空记录    
    ABRecordRef person = ABPersonCreate();
    
    
    
    
    ////添加单个项的属性值，如姓、名、生日、职务、公司...
    ABRecordSetValue(person, kABPersonOrganizationProperty, (CFStringRef)_person.chineseName, &error);
    
    
    
    
    //用于存放具有多个值的项
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    //电话号码属于具有多个值的项（除此还有email、地址类）
    ABMultiValueAddValueAndLabel(multi, (CFStringRef)_person.phone, kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(person, kABPersonPhoneProperty, multi, &error);
    
    //清空该变量用于存放下一个多值的项
    multi=nil;
    multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    //email也属于具有多个项的值
    ABMultiValueAddValueAndLabel(multi, (CFStringRef)_person.email, kABWorkLabel, NULL);
    ABRecordSetValue(person, kABPersonEmailProperty, multi, &error);
    
    
    
    
    //添加并保存到地址本中
    ABAddressBookRef addressBookt = ABAddressBookCreate(); 
    ABAddressBookAddRecord(addressBookt, person, &error);
    ABAddressBookSave(addressBookt, &error);
    
    //保存后就可以拿到id了，id没保存前是 -1
    ABRecordID personId = ABRecordGetRecordID(person);
    if (personId != -1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                        message:@"添加成功" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
    
    
    
    CFRelease(multi);
    CFRelease(person);
    CFRelease(addressBookt); 
}





#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}





- (void)call {

    NSString *telString = [NSString stringWithFormat:@"tel://%@",_person.phone];
    
    NSURL *telURL = [NSURL URLWithString:telString];
    
    [[UIApplication sharedApplication] openURL:telURL];
}

@end

