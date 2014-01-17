//
//  Button.h
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@protocol ButtonDelegate <NSObject>

- (void)buttonDidTapped:(id)sender;

@end

@interface Button : UIView

@property (nonatomic, retain) IBOutlet id<ButtonDelegate> delegate;
@property (nonatomic, retain) Person *person;

@end
