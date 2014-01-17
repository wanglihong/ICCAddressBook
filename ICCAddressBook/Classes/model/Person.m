//
//  Person.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize chineseName = _chineseName;
@synthesize englishName = _englishName;
@synthesize team = _team;
@synthesize position = _position;
@synthesize ext= _ext;
@synthesize phone = _phone;
@synthesize email = _email;
@synthesize msn = _msn;
@synthesize telephone = _telephone;

- (void)dealloc {

    [_chineseName release];
    [_englishName release];
    [_team release];
    [_position release];
    [_ext release];
    [_phone release];
    [_email release];
    [_msn release];
    [_telephone release];
    [super dealloc];
}

@end
