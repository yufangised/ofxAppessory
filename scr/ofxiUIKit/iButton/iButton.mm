/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iButton.mm
 *
 * Created by Wang Yufan on 7/28/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "iButton.h"
#import "ocButton.h"


@implementation ocButton
@synthesize myButton;
@synthesize parent;

- (id) initWithFrame:(CGRect)frame{            
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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


-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    
    [myButton setBackgroundImage:image 
                     forState:state];
}

//-(void)buttonInfo:(id)sender {

-(void) buttonIsPressed:(id)sender
{
    NSLog(@"Button is pressed!!! "); 
    
    bool pressed = true;
    ofNotifyEvent(self.parent->pressed, pressed , parent);
    
}

-(void) buttonIsTapped:(id)sender
{
    bool tapped = true;
    ofNotifyEvent(self.parent->released, tapped , parent);
    NSLog(@"Button is released!!! ");
}



iButton::iButton(float x, float y, float width){
    
    
    buttonFrame = CGRectMake(x, y, width, 37.0f);
    
    button = [[ocButton alloc] initWithFrame:buttonFrame];
    
    button.parent = this;
    
    //ofAddListener(ofEvents().update, this, &iButton::update);
    
    
}


iButton::iButton(float x, float y, float width, float height){
    
    
    buttonFrame = CGRectMake(x, y, width, height);
    
    button = [[ocButton alloc] initWithFrame:buttonFrame];
    
    button.parent = this;
    
    //ofAddListener(ofEvents().update, this, &iButton::update);
    
    
}




iButton::~iButton()
{
    
}


void iButton::setTitle(string normal, string highlighted){
    
    [button->myButton setTitle:ofxStringToNSString(normal) forState:UIControlStateNormal];
    [button->myButton setTitle:ofxStringToNSString(highlighted) forState:UIControlStateHighlighted];

}
void iButton::setTitleFontSize(float size){

    [button->myButton setFont:[UIFont boldSystemFontOfSize:size]];
}

void iButton::setTitleColorNomarl(int r, int g, int b, int a){
    
    UIColor *color = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                     green:ofClamp(g, 0, 255)/255.0f 
                                      blue:ofClamp(b, 0, 255)/255.0f 
                                     alpha:ofClamp(a, 0, 255)/255.0f];
    
    [button->myButton setTitleColor:color forState:UIControlStateNormal];
    
    
}

void iButton::setTitleColorHighligted(int r, int g, int b, int a){
    
    UIColor *color = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                     green:ofClamp(g, 0, 255)/255.0f 
                                      blue:ofClamp(b, 0, 255)/255.0f 
                                     alpha:ofClamp(a, 0, 255)/255.0f];
    
    [button->myButton setTitleColor:color forState:UIControlStateHighlighted];
}

void iButton::customizeWithImage(string imageForNormal, string imageForHighlighted){

    [button setBackgroundImage:[UIImage imageNamed:ofxStringToNSString(imageForNormal)]
                      forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:ofxStringToNSString(imageForHighlighted)]
                      forState:UIControlStateHighlighted];

}


void iButton::addToView(iViewController *iView){
    
    [iView->myView.view addSubview:button];
    
}





void iButton::update(ofEventArgs &Args){
           
}

@end
