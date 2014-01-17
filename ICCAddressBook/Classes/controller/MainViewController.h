//
//  MainViewController.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ICCAddressBookCell.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MFMessageComposeViewControllerDelegate, ICCAddressBookCellDelegate> {

    IBOutlet ICCAddressBookCell *iccAddressBookCell;

}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *records;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (void)steal;
- (void)crawl;
- (void)search:(NSString *)condition;

@end
