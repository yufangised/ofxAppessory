/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSwitch.mm
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocSwitch.h"
#import "iSwitch.h"

@implementation ocSwitch
@synthesize parent;

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self addTarget:self 
             action:@selector(switchToggled:) 
   forControlEvents:UIControlEventValueChanged];   
    
    return self;
    
}


- (void)switchToggled:(id)sender
{
    bool isOn = [sender isOn];
    ofNotifyEvent(parent->toggled, isOn, parent);
}




iSwitch::iSwitch(float x, float y){
        
    switchFrame = CGRectMake(x, y, 79.0f, 27.0f);
    mySwitch = [[ocSwitch alloc] initWithFrame:CGRectMake(x, y, 79, 27)];
    [mySwitch setOn:NO animated:YES];
    mySwitch.parent = this;
    
}

iSwitch::iSwitch(float x, float y, float width, float height){
    
    switchFrame = CGRectMake(x, y, width, height);
    mySwitch = [[ocSwitch alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [mySwitch setOn:NO animated:YES];
    mySwitch.parent = this;
    
}

iSwitch::~iSwitch()
{
    
}


void iSwitch::addToView(iViewController *iView){
    
    [iView->myView.view addSubview:mySwitch];
}

bool iSwitch::getState()
{
    return [mySwitch isOn]? true:false;
}

bool iSwitch::setState(bool state)
{
    //mySwitch seton
    state? [mySwitch setOn:YES animated:YES]:[mySwitch setOn:NO animated:YES];
    return state;
}

void iSwitch::setSwitchOnColor(int r, int g, int b, int a){
    
    stageColorOfSwitch = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                         green:ofClamp(g, 0, 255)/255.0f 
                                          blue:ofClamp(b, 0, 255)/255.0f 
                                         alpha:ofClamp(a, 0, 255)/255.0f];
    
    mySwitch.onTintColor = stageColorOfSwitch;
    
}


void iSwitch::setSwitchText(string onText, string offText){
    
    mySwitch.onText = ofxStringToNSString(onText);
    mySwitch.offText = ofxStringToNSString(offText);
}


void iSwitch::attach(bool &variable)
{
    //mySwitch seton
    [mySwitch isOn]? variable = true : variable = false;
}

void iSwitch::attach(LED *led){
    
    if (led->isPWM == false){
        [mySwitch isOn]? DIGITAL_PWM[led->pinNumber] = 1 : DIGITAL_PWM[led->pinNumber] = 0;
        [mySwitch isOn]? led->setOn() : led->setOff();
        
    } else {
        [mySwitch isOn]? DIGITAL_PWM[led->pinNumber] = 255 : DIGITAL_PWM[led->pinNumber] = 0;
        [mySwitch isOn]? led->setOn() : led->setOff();
    }
}


@end
