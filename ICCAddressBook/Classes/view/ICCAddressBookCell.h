//
//  ICCAddressBookCell.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "Person.h"

@protocol ICCAddressBookCellDelegate <NSObject>

- (void)sendMessageTo:(Person *)person;
- (void)makePhoneCall:(Person *)person;
- (void)showDetails:(Person *)person;

@end

@interface ICCAddressBookCell : UITableViewCell <ButtonDelegate>

@property (nonatomic, retain) IBOutlet UILabel *chineseNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *englishNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *teamLabel;
@property (nonatomic, retain) IBOutlet UILabel *positionLabel;
@property (nonatomic, retain) IBOutlet UILabel *extLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *emailLabel;
@property (nonatomic, retain) IBOutlet UILabel *msnLabel;
@property (nonatomic, retain) IBOutlet UILabel *telephoneLabel;

@property (nonatomic, retain) IBOutlet Button *buttonCall, *buttonMSM, *buttonDet;
@property (nonatomic, retain) id<ICCAddressBookCellDelegate> delegate;
@property (nonatomic, retain) Person *person;

@end
