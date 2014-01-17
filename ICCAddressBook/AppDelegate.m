//
//  AppDelegate.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Data.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [[Data sharedData] read];
    /*
     * 首页
     */
    MainViewController *mainController = [[MainViewController alloc] init];
    UINavigationController *main = [[UINavigationController alloc] initWithRootViewController:mainController];
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"通讯录" 
                                                       image:[UIImage imageNamed:@"home.png"] 
                                                         tag:1];  
    main.tabBarItem = tabBarItem1;
    [tabBarItem1 release];
    [mainController release];
    
    
    /*
     * 组
     */
    TeamViewController *teamController = [[TeamViewController alloc] init];
    UINavigationController *team = [[UINavigationController alloc] initWithRootViewController:teamController];
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"组" 
                                                              image:[UIImage imageNamed:@"user_group.png"] 
                                                                tag:2];  
    team.tabBarItem = tabBarItem2;
    [tabBarItem2 release];
    [teamController release];
    
    
    /*
     * 搜索页
     */
    QueryViewController *queryController = [[QueryViewController alloc] init];
    UINavigationController *query = [[UINavigationController alloc] initWithRootViewController:queryController];
    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"搜索" 
                                                       image:[UIImage imageNamed:@"search.png"] 
                                                         tag:3];  
    query.tabBarItem = tabBarItem3;
    [tabBarItem3 release];
    [queryController release];
    
    
    /*
     * 标签栏
     */
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    tabBarController.view.frame = [[UIScreen mainScreen] bounds];
    tabBarController.viewControllers = [NSArray arrayWithObjects:main, team, query, nil];
    [main release];
    [query release];
    
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
