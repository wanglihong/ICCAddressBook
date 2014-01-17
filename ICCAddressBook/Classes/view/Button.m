//
//  Button.m
//  ICCAddressBook
//
//  Created by Dennis Yang on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Button.h"

@implementation Button

@synthesize delegate;
@synthesize person;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
     
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetLineWidth(context, 1);
     
     
     // draw the cyan rounded box
     CGMutablePathRef hpath = CGPathCreateMutable();
     CGPathMoveToPoint(hpath, NULL, 5.0, 0.5);
     CGPathAddArcToPoint(hpath, NULL, 91.5, 0.5, 91.5, 5.0, 5.0);
     CGPathAddArcToPoint(hpath, NULL, 91.5, 29.5, 87.0, 29.5, 5.0);
     CGPathAddArcToPoint(hpath, NULL, 0.5, 29.5, 0.5, 24.0, 5.0);
     CGPathAddArcToPoint(hpath, NULL, 0.5, 0.5, 5.0, 0.5, 5.0);
     CGContextAddPath(context, hpath);
     CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
     CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0. alpha:.1].CGColor);
     CGContextDrawPath(context, kCGPathFillStroke);
     CGPathRelease(hpath);
     
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor colorWithWhite:0. alpha:.1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor clearColor];
    
    if ([delegate respondsToSelector:@selector(buttonDidTapped:)]) {
        [delegate buttonDidTapped:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc 
{
    [delegate release];
    [person release];
    [super dealloc];
}

@end
