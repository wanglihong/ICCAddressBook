//
//  Data.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Data.h"

@implementation Data

@synthesize records = _records;



static Data *_instance = nil;

+ (Data *)sharedData {
    
    @synchronized(self){
		if (!_instance){
			_instance = [[Data alloc] init];
		}
	}
	
	return _instance;
}

- (id)init {
    if (self = [super init]) {
        self.records = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)clear {
    [_records removeAllObjects];
}

- (void)read {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDiretory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDiretory stringByAppendingPathComponent:@"Data.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return;
    }
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    
    
    //NSMutableArray *persons = [NSMutableArray array];//用于存放 从 plist 里读出来的数据
    
    for (NSDictionary *item in [dictionary objectForKey:@"icc"]) {
        
        Person *person = [[Person alloc] init];
        
        person.chineseName  = [item objectForKey:@"chineseName"];
        person.englishName  = [item objectForKey:@"englishName"];
        person.team         = [item objectForKey:@"team"];
        person.position     = [item objectForKey:@"position"];
        person.ext          = [item objectForKey:@"ext"];
        person.phone        = [item objectForKey:@"phone"];
        person.email        = [item objectForKey:@"email"];
        person.msn          = [item objectForKey:@"msn"];
        person.telephone    = [item objectForKey:@"telephone"];
        
        [_records addObject:person];
        [person release];
    }
    
    
    
    [dictionary release];
    
    
    
    //_records = persons;
}

- (void)write {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];//用于存放 要写进 plist 里的数据
    
    for (Person *person in [[Data sharedData] records]) {
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        
        [item setValue:person.chineseName forKey:@"chineseName"];
        [item setValue:person.englishName forKey:@"englishName"];
        [item setValue:person.team forKey:@"team"];
        [item setValue:person.position forKey:@"position"];
        [item setValue:person.ext forKey:@"ext"];
        [item setValue:person.phone forKey:@"phone"];
        [item setValue:person.email forKey:@"email"];
        [item setValue:person.msn forKey:@"msn"];
        [item setValue:person.telephone forKey:@"telephone"];
        
        [array addObject:item];
        [item release];
    }
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    if (documentDirectory) {
        
        NSString *fileName = [documentDirectory stringByAppendingPathComponent:@"Data.plist"];
        
        NSMutableDictionary *saveDic = [[NSMutableDictionary alloc] init];
        [saveDic setObject:array forKey:@"icc"];
        [saveDic writeToFile:fileName atomically:NO];
        [saveDic release];
        
        NSLog(@"%@",fileName);
    }
    
    
    
    [array release];
    
}


- (int)numberOfRecords {
    return [_records count];
}

- (void)addRecord:(Person *)person {
    [_records addObject:person];
}

- (Person *)recordAtIndex:(int)index {
    return [_records objectAtIndex:index];
}

- (void)dealloc {
    [self.records release];
    [super dealloc];
}

@end
