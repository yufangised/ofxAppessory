/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSlider.mm
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocSlider.h"
#import "iSlider.h"

@implementation ocSlider
@synthesize parent;

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    [self addTarget:self 
             action:@selector(sliderValueChanged:) 
   forControlEvents:UIControlEventValueChanged];   
    
    return self;
    
}


-(void) sliderValueChanged:(UISlider*)paramSender
{
    //NSLog(@"Slider new value %f", paramSender.value); 
    
    float newValue = [paramSender value];
    ofNotifyEvent(parent->valueChanged, newValue, parent);
    
}




iSlider::iSlider(float x, float y, float length)
{
        
    slider = [[ocSlider alloc] initWithFrame:CGRectMake(x, y, length, 23.0f)];
    slider.parent = this;
    
    slider.minimumValue = 0;
    slider.maximumValue = length;
    
    minValue = 0;
    maxValue = length;
    
    //isVaribleAttacted = false;
    
}

iSlider::~iSlider(){
    
}

float iSlider::getValue(){
    
    return slider.value;

}

void iSlider::attach(float &variable){

    variable = slider.value;
}

void iSlider::attach(float &variable, float rangeMinimum, float rangeMaximum){
    
    variable = ofMap(slider.value, minValue, maxValue,  rangeMinimum, rangeMaximum);
}

void iSlider::addToView(iViewController *iView){
    
    [iView->myView.view addSubview:slider];
}

void iSlider::setValueRange(float min, float max){
    if(max >= min){
        slider.minimumValue = min;
        slider.maximumValue = max;
        minValue = min;
        maxValue = max;
    }else {
        slider.minimumValue = max;
        slider.maximumValue = min;
        minValue = max;
        maxValue = min;
        ofLog() << "Slider value range was setted wrong!";
    }
}

void iSlider::customizeWithImage(string imageName){

    [slider setMinimumTrackImage:[[UIImage imageNamed:ofxStringToNSString(imageName)] 
                                  stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] 
                        forState:UIControlStateNormal];

}

void iSlider::attach(PWM *pwm){
    
    DIGITAL_PWM[pwm->pinNumber] = (int)(ofMap(slider.value, minValue, maxValue, 0, 255));
}

void iSlider::attach(LED *led){
    
    if (led->isPWM) {
        DIGITAL_PWM[led->pinNumber] = (int)(ofMap(slider.value, minValue, maxValue, 0, 255));
    } else {
        ofLog()<<"Warning:iSlider method attch() is only available when a LED connected to a PWM pin!";
    }

}

void iSlider::attach(iTextField *textField){

    stringstream valueString;
    valueString << slider.value;
    textField->setText(valueString.str());
}


@end
