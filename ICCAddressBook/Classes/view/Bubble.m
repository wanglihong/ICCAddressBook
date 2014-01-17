//
//  Bubble.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bubble.h"
#define ORC_RADIUS 12

@implementation Bubble

@synthesize person;
@synthesize button1, button2, button3;
@synthesize delegate;

typedef enum {
    PHONE_CALL = 0,
    SEND_MSG,
    SHOW_DETAIL
} buttonTAG;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *titles = [NSArray arrayWithObjects:@"呼叫", @"短信", @"详细", nil];
        
        for (int i = 0; i < 3; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button setTag:i];
            [button setFrame:CGRectMake(10 + 100 *i, 15, 80, 30)];
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
        }
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {/*
    //[[UIColor grayColor] setFill];
    //[path fill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    
    // draw the gray pointed shape: -----shadow
    CGMutablePathRef shadowpath = CGPathCreateMutable();
    CGPathMoveToPoint(shadowpath, NULL, 50.0, 60.0);        //箭头顶角
    CGPathAddLineToPoint(shadowpath, NULL, 105.0, 54.3);    //左角
    CGPathAddLineToPoint(shadowpath, NULL, 75.0, 54.3);     //右角
    CGContextAddPath(context, shadowpath);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0. alpha:.15].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(shadowpath);
    
    // draw the cyan rounded box  -----shadow
    shadowpath = CGPathCreateMutable();
    CGPathMoveToPoint(shadowpath, NULL, 15.0, 15.5);
    CGPathAddArcToPoint(shadowpath, NULL, 304.5, 15.5, 304.5, 20.0, 5.0);
    CGPathAddArcToPoint(shadowpath, NULL, 304.5, 54.5, 300.0, 54.5, 5.0);
    CGPathAddArcToPoint(shadowpath, NULL, 15.5, 54.5, 15.5, 49.0, 5.0);
    CGPathAddArcToPoint(shadowpath, NULL, 15.5, 15.5, 20.0, 15.5, 5.0);
    CGContextAddPath(context, shadowpath);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0. alpha:.15].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(shadowpath);
    
    // draw the gray pointed shape:
    CGMutablePathRef hpath = CGPathCreateMutable();
    CGPathMoveToPoint(hpath, NULL, 50.0, 60.0);        //箭头顶角
    CGPathAddLineToPoint(hpath, NULL, 100.0, 49.3);    //左角
    CGPathAddLineToPoint(hpath, NULL, 70.0, 49.3);     //右角
    CGContextAddPath(context, hpath);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0. alpha:.75].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(hpath);
    
    // draw the cyan rounded box
    hpath = CGPathCreateMutable();
    CGPathMoveToPoint(hpath, NULL, 15.0, 10.5);
    CGPathAddArcToPoint(hpath, NULL, 299.5, 10.5, 299.5, 15.0, 5.0);
    CGPathAddArcToPoint(hpath, NULL, 299.5, 49.5, 295.0, 49.5, 5.0);
    CGPathAddArcToPoint(hpath, NULL, 10.5, 49.5, 10.5, 44.0, 5.0);
    CGPathAddArcToPoint(hpath, NULL, 10.5, 10.5, 15.0, 10.5, 5.0);
    CGContextAddPath(context, hpath);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0. alpha:.75].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(hpath);
    */
}

- (IBAction)call {
    
    if ([delegate respondsToSelector:@selector(makePhoneCall:)]) {
        [delegate makePhoneCall:person];
    }
    
    //[self removeFromSuperview];
}

- (IBAction)mesg {
    
    if ([delegate respondsToSelector:@selector(sendMessageTo:)]) {
        [delegate sendMessageTo:person];
    }
    
    //[self removeFromSuperview];
}

- (IBAction)dtal {
    
    if ([delegate respondsToSelector:@selector(showDetails:)]) {
        [delegate showDetails:person];
    }
    
    //[self removeFromSuperview];
}

- (void)buttonDidTapped:(id)sender {
    //[self removeFromSuperview];
    
    UIButton *button = (UIButton *)sender;
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
    [button1 release];
    [button2 release];
    [button3 release];
    [person release];
    [super dealloc];
}

@end
