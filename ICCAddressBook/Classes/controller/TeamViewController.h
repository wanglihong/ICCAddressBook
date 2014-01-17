//
//  TeamViewController.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
{
    BOOL *flag;//BOOL 类型数组，用来存储每个section的打开状态
}

@property (nonatomic, retain) NSMutableArray *teamNames, *teams;

- (void)separateTeam;
- (void)createTeam;
- (void)stateOfTeam;//open or close
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

@end
