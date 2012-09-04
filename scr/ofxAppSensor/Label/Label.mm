/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Label.mm
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "Label.h"

@implementation Label
@synthesize labelName;
@synthesize labelColor;
@synthesize textColor;

- (id)initWithFrame:(CGRect)frame 
               name:(NSString *) nameString
         labelColor:(UIColor *) colorOfLabel
          textColor:(UIColor *) colorOfText
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        labelName = nameString;
        labelColor = colorOfLabel;
        textColor = colorOfText;
    }
    
    return self;
}




-(void) drawRect:(CGRect)rect

{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetLineWidth(context, 0);
    //CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, labelColor.CGColor);
    CGRect rrect = self.bounds;
    
    CGFloat radius = rrect.size.height/2;
    CGFloat width = CGRectGetWidth(rrect);
    
    // Make sure corner radius isn't larger than half the shorter side
    if (radius > width/2.0) radius = width/2.0;
    
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat midy = CGRectGetMidY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    //draw text
    CGRect bounds = [self bounds];
    [textColor set];
    UIFont *textFont = [UIFont boldSystemFontOfSize:13.0f];
    CGPoint textLocation;
    textLocation.x = bounds.origin.x + 4.0f;
    textLocation.y = bounds.origin.y + 4.5f;
    
    [labelName drawAtPoint:textLocation withFont:textFont];
    
    [textFont release];
    
}

-(void) dealloc{
    [super dealloc];
    [labelName release];
    [labelColor release];
    [textColor release];
}

@end
