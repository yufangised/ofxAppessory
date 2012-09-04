/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iRoundButton.mm
 *
 * Created by Wang Yufan on 7/28/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "iRoundButton.h"
#import "ocRoundButton.h"
#import "ofEvents.h"

@implementation ocRoundButton
@synthesize myButton;
@synthesize parent;

- (id) initWithFrame:(CGRect)frame 
          buttonType:(int) type{  
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        switch (type) {
            case 0:
                myButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                break;
            case 1:
                myButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
                break;
            case 2:
                myButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
                break;
            case 3:
                myButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
                break;
            default:
                myButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                break;
        }
        
        myButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview:myButton];
        
        [myButton addTarget:self
                     action:@selector(buttonIsPressed:) 
           forControlEvents:UIControlEventTouchDown];
        
        [myButton addTarget:self
                     action:@selector(buttonIsTapped:) 
           forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
    
}


-(void) buttonIsPressed:(id)sender
{
    NSLog(@"roundButton is pressed!!! "); 
    
    bool pressed = true;
    ofNotifyEvent(self.parent->pressed, pressed , parent);
    
}

-(void) buttonIsTapped:(id)sender
{
    bool tapped = true;
    ofNotifyEvent(self.parent->released, tapped , parent);
    NSLog(@"roundButton is released!!! ");
}




iRoundButton::iRoundButton(float x, float y, ROUND_BUTTON_TYPE type)
{
    buttonFrame = CGRectMake(x, y, 37.0f, 37.0f);
    
    roundButton = [[ocRoundButton alloc] initWithFrame:buttonFrame buttonType:type];
    
    roundButton.parent = this;
}



iRoundButton::~iRoundButton(){
    
}

//void iButton::swichtIsChanged:(iViewController iView){

void iRoundButton::addToView(iViewController *iView){
    
    [iView->myView.view addSubview:roundButton];
}


@end
