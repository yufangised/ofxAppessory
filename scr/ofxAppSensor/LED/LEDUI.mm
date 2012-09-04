/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * LEDUI.mm
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "LEDUI.h"

@implementation LEDUI
@synthesize colorIndex;
@synthesize ledColor;
@synthesize ledRedOn;
@synthesize ledRedOff;
@synthesize ledGreenOn;
@synthesize ledGreenOff;
@synthesize ledBlueOn;
@synthesize ledBlueOff;
@synthesize ledYellowOn;
@synthesize ledYellowOff;
@synthesize ledOutline;
@synthesize ledHighlight;


- (id)initWithFrame:(CGRect)frame 
              color:(int) index
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.ledRedOn = [UIColor redColor];
        self.ledRedOff = [UIColor colorWithRed:0.4 green:0 blue:0 alpha:1];
        
        self.ledGreenOn = [UIColor greenColor];
        self.ledGreenOff = [UIColor colorWithRed:0 green:0.4 blue:0 alpha:1];
        self.ledBlueOn = [UIColor blueColor];
        self.ledBlueOff = [UIColor colorWithRed:0 green:0 blue:0.4 alpha:1];
        self.ledYellowOn = [UIColor yellowColor];
        self.ledYellowOff = [UIColor colorWithRed:194.0f/255.0f green:194.0f/255.0f blue:65.0f/255.0f alpha:1];
        //self.ledColor = ledGreenOff;//default color
        self.ledOutline = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.6];
        self.ledHighlight = [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.4f];
        
        colorIndex = index;
        
        switch (colorIndex) {
            case 0:
                self.ledColor = ledGreenOff;//default color
                break;
            case 1:
                self.ledColor = ledRedOff;
                break;
            case 2:
                self.ledColor = ledBlueOff;
                break;
            case 3:
                self.ledColor = ledYellowOff;
                break;
            default:
                self.ledColor = ledGreenOff;
                break;
        }
        
        
    }
    return self;
}

-(void) setLedColor:(UIColor *)clr
{
    ledColor = clr;
    [self setNeedsDisplay];
}

-(void) setOn
{
    switch (colorIndex) {
        case 0:
            [self setLedColor:ledGreenOn];
            break;
        case 1:
            [self setLedColor:ledRedOn];
            break;
        case 2:
            [self setLedColor:ledBlueOn];
            break;
        case 3:
            [self setLedColor:ledYellowOn];
            break;
        default:
            [self setLedColor:ledGreenOn];
            break;
    }

}

-(void) setOff
{
    switch (colorIndex) {
        case 0:
            [self setLedColor:ledGreenOff];
            break;
        case 1:
            [self setLedColor:ledRedOff];
            break;
        case 2:
            [self setLedColor:ledBlueOff];
            break;
        case 3:
            [self setLedColor:ledYellowOff];
            break;
        default:
            [self setLedColor:ledGreenOff];
            break;
    }
    
}


-(void) drawRect:(CGRect)rect

{
    //add led
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, rect);
    CGContextSetLineWidth(context, 1);
    
    CGContextSetFillColor(context, CGColorGetComponents([ledColor CGColor]));
    CGContextSetStrokeColor(context, CGColorGetComponents([[UIColor grayColor] CGColor]));
    CGContextEOFillPath(context);
    
    
    //add highlight
    CGRect bounds = [self bounds];
    CGPoint center;
    
    center.x = bounds.origin.x + bounds.size.width /2;
    center.y = bounds.origin.y + bounds.size.height/2;
    
    CGPoint highlightRectOrigin;
    float ledRadius = rect.size.width/2;
    float highlightRectSize = (sqrtf(2)/2) * ledRadius;
    highlightRectOrigin.x = rect.origin.x + (ledRadius - highlightRectSize);
    highlightRectOrigin.y = rect.origin.y + (ledRadius - highlightRectSize);
    
    CGRect highlightRect = CGRectMake(highlightRectOrigin.x, 
                                      highlightRectOrigin.y , 
                                      highlightRectSize, 
                                      highlightRectSize);
    
    CGContextAddEllipseInRect(context, highlightRect);
    CGContextSetFillColor(context, CGColorGetComponents([ledHighlight CGColor]));
    CGContextEOFillPath(context);
    
    //add outline
    CGContextAddArc(context, center.x, center.y, ledRadius-1, 0.0, M_PI*2.0, YES);
    [[self ledOutline] setStroke];
    
    CGContextStrokePath(context);
    
}

-(void) dealloc
{
    [super dealloc];
    [ledRedOn release];
    [ledRedOff release];
    [ledGreenOn release];
    [ledGreenOff release];
    [ledBlueOn release];
    [ledBlueOff release];
    [ledYellowOn release];
    [ledYellowOff release];
    [ledColor release];
    [ledOutline release];
    [ledHighlight release];
}


@end
