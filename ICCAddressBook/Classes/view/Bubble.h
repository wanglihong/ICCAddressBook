//
//  Bubble.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@protocol BubbleDelegate <NSObject>

- (void)sendMessageTo:(Person *)person;
- (void)makePhoneCall:(Person *)person;
- (void)showDetails:(Person *)person;

@end

@interface Bubble : UIView {

    
}

@property (nonatomic, retain) Person *person;
@property (nonatomic, retain) IBOutlet UIButton *button1, *button2, *button3;
@property (nonatomic, retain) id<BubbleDelegate> delegate;

- (IBAction)call;
- (IBAction)mesg;
- (IBAction)dtal;

@end
