//
//  ICCAddressBookCell.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ICCAddressBookCell.h"

@implementation ICCAddressBookCell

@synthesize chineseNameLabel;
@synthesize englishNameLabel;
@synthesize teamLabel;
@synthesize positionLabel;
@synthesize extLabel;
@synthesize phoneLabel;
@synthesize emailLabel;
@synthesize msnLabel;
@synthesize telephoneLabel;

@synthesize buttonCall, buttonMSM, buttonDet;
@synthesize delegate;
@synthesize person;

typedef enum {
    PHONE_CALL = 0,
    SEND_MSG,
    SHOW_DETAIL
} buttonTAG;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buttonDidTapped:(id)sender {
    
    Button *button = (Button *)sender;
    int tag = button.tag;
    
    switch (tag) {
        case PHONE_CALL:
            if ([delegate respondsToSelector:@selector(makePhoneCall:)]) {
                [delegate makePhoneCall:person];
            }
            break;
            
        case SEND_MSG:
            if ([delegate respondsToSelector:@selector(sendMessageTo:)]) {
                [delegate sendMessageTo:person];
            }
            break;
            
        case SHOW_DETAIL:
            if ([delegate respondsToSelector:@selector(showDetails:)]) {
                [delegate showDetails:person];
            }
            break;
            
        default:
            break;
    }
}

- (void)dealloc
{
    [chineseNameLabel release];
    [englishNameLabel release];
    [teamLabel release];
    [positionLabel release];
    [extLabel release];
    [phoneLabel release];
    [emailLabel release];
    [msnLabel release];
    [telephoneLabel release];
    [delegate release];
    [person release];
    
    [buttonCall release];
    [buttonMSM release];
    [buttonDet release];
    [super dealloc];
}

@end
