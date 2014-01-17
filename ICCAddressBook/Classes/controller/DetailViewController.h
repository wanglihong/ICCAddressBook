//
//  DetailViewController.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Person.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) Person *person;

@end
