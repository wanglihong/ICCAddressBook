//
//  QueryViewController.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryViewController : UIViewController<UISearchBarDelegate> {
    IBOutlet UITableView *_tableView;
    IBOutlet UISearchBar *searchB;
}

@property (nonatomic, retain) NSMutableArray *results;

- (void)search:(NSString *)condition;

@end
