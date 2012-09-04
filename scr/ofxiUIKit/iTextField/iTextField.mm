/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iTextField.mm
 *
 * Created by Wang Yufan on 8/20/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "iTextField.h"
#import "ocTextField.h"

@implementation ocTextField
@synthesize myTextField;


-(id) initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    if (self) {
        CGRect textFieldframe = CGRectMake(0, 0, frame.size.width, frame.size.height);
        myTextField = [[UITextField alloc] initWithFrame:textFieldframe];
        [self addSubview:myTextField];
        [myTextField setDelegate:self];
        
    }
    
    return self;

}


- (BOOL)            textField:(UITextField *)textField 
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)string
{
    BOOL result = YES;
    if ([textField isEqual:self.myTextField]){
        [textField.text stringByReplacingCharactersInRange:range
                                                withString:string]; 
    }
    return result; 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES; 
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

}





iTextField::iTextField(){
    
    colorOftext = [UIColor darkTextColor];
    colorOfBackground = [UIColor whiteColor];
    sizeOfFont = 16.0f;
    styleOfFont = 0;
    alignmentOfText = 0;
    
    isLayout = false;
    styleOfTextField = ROUND_RECT;
}

iTextField::iTextField(string text){

    textOfTextField = text;
    
    colorOftext = [UIColor darkTextColor];
    colorOfBackground = [UIColor whiteColor];
    sizeOfFont = 16.0f;
    styleOfFont = 0;
    alignmentOfText = 0;
    
    isLayout = false;
    styleOfTextField = ROUND_RECT;
}

iTextField::~iTextField(void){
    
}

void iTextField::setFrame(float x, float y, float width, float height){
    
    textFieldFrame = CGRectMake(x, y, width, height);
    isLayout = true;
        
}

void iTextField::setTextFieldStyle(TEXT_FIELD_STYLE style){
    
    if(style == ROUND_RECT || style == LINE || style == BEZEL){
        
        styleOfTextField = style;
    }else{
        styleOfTextField = ROUND_RECT;
    }
    
}

void iTextField::setBackground(int r, int g, int b, int a){
    
    colorOfBackground = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                        green:ofClamp(g, 0, 255)/255.0f 
                                         blue:ofClamp(b, 0, 255)/255.0f 
                                        alpha:ofClamp(a, 0, 255)/255.0f];
}

void iTextField::setBackground(PREDEFINED_BACKGROUND background){
    
    switch (background) {
        case 0:
            colorOfBackground = [UIColor whiteColor];
            break;
            
        case 1:
            colorOfBackground = [UIColor blackColor];
            break;
            
        case 2:
            colorOfBackground = [UIColor clearColor];
            break;
            
        case 3:
            colorOfBackground = [UIColor groupTableViewBackgroundColor];
            break;
            
        case 4:
            colorOfBackground = [UIColor scrollViewTexturedBackgroundColor];
            break;
            
        default:
            colorOfBackground = [UIColor clearColor];
            break;
    }
    
}

void iTextField::setTextColor(int r, int g, int b, int a){
    
    colorOftext = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                  green:ofClamp(g, 0, 255)/255.0f 
                                   blue:ofClamp(b, 0, 255)/255.0f 
                                  alpha:ofClamp(a, 0, 255)/255.0f];
    
}

void iTextField::setFont(float fontSize){
    
    sizeOfFont = fontSize;
}

void iTextField::setFont(float fontSize, FONT_STYLE style){
    
    sizeOfFont = fontSize;
    styleOfFont = style;
}
void iTextField::setFont(float fontSize, FONT_STYLE style, bool withShadow){
    
    sizeOfFont = fontSize;
    styleOfFont = style;

}

void iTextField::setTextAlignment(TEXT_ALIGNMENT alignment){
    
    if(alignment == CENTER || alignment == LEFT || alignment == RIGHT){
        alignmentOfText = alignment;
    }else {
        alignmentOfText = CENTER;
    }
    
}

void iTextField::setText(string text){
    
    textField->myTextField.text = ofxStringToNSString(text);

}

string iTextField::getText(){
    
    return ofxNSStringToString(textField->myTextField.text);
    
}

void iTextField::attactTo(int variable){
    
    stringstream variableString;
    variableString << variable;
    setText(variableString.str());

}

void iTextField::attachTo(float variable){
    
    stringstream variableString;
    variableString << variable;
    setText(variableString.str());

}

void iTextField::attactTo(bool variable){
    
   
    variable ? setText("True"): setText("false");
    
}

void iTextField::attachTo(string varibel){
    
    setText(varibel);
    
}

void iTextField::attachTo(iSlider *slider){
    
    stringstream valueString;
    valueString << slider->getValue();
    setText(valueString.str());

}

void iTextField::attachTo(Potentiometer *potentiometer){
    
    stringstream valueString;
    valueString << ANALOG_INPUT[potentiometer->pinNumber];
    setText(valueString.str());
}

void iTextField::attachTo(LightSensor *lightSensor){
    
    
    if(lightSensor->isAnalog){
        stringstream valueString;
        valueString << ANALOG_INPUT[lightSensor->pinNumber];
        setText(valueString.str());
    
    }else {
        ANALOG_INPUT[lightSensor->pinNumber] ? setText("ON") : setText("OFF");
    }
    
}

void iTextField::addToView(iViewController *iView){
    
    if (isLayout == false) {
        float textFieldWidth = 100.0f;
        float textFieldHeight = 37.0f;
        float screenWidth = [UIScreen mainScreen].applicationFrame.size.width;
        float screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
        
        
        textFieldFrame = CGRectMake((screenWidth-textFieldWidth)/2, 
                                    (screenHeight-textFieldHeight)/2, 
                                    textFieldWidth, 
                                    textFieldHeight);

    }
        
    
    textField = [[ocTextField alloc] initWithFrame:textFieldFrame];
    textField->myTextField.text = ofxStringToNSString(textOfTextField);
    textField->myTextField.backgroundColor = colorOfBackground;
    
    
    
    switch (styleOfTextField) {
        case 0:
            textField->myTextField.borderStyle = UITextBorderStyleRoundedRect;
            break;
        case 1:
            textField->myTextField.borderStyle = UITextBorderStyleLine;
            break;
        case 2:
            textField->myTextField.borderStyle = UITextBorderStyleBezel;
            break;
        case 3:
            textField->myTextField.borderStyle = UITextBorderStyleNone;
            break;
        default:
            break;
    }
    
    
    switch (styleOfFont) {
        case 0:
            textField->myTextField.font = [UIFont systemFontOfSize:sizeOfFont];
            break;
        case 1:
            textField->myTextField.font = [UIFont boldSystemFontOfSize:sizeOfFont];
            break;
        case 2:
            textField->myTextField.font = [UIFont italicSystemFontOfSize:sizeOfFont];
            break;
        default:
            textField->myTextField.font = [UIFont systemFontOfSize:sizeOfFont];
            break;
    }
    
    switch (alignmentOfText) {
        case 0:
            textField->myTextField.textAlignment = UITextAlignmentCenter;
            break;
        case 1:
            textField->myTextField.textAlignment = UITextAlignmentLeft;
            break;
        case 2:
            textField->myTextField.textAlignment = UITextAlignmentRight;
            break;
        default:
            textField->myTextField.textAlignment = UITextAlignmentCenter;
            break;
    }
    
    textField->myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField->myTextField.textColor = colorOftext;
    
    //textField->myTextField.userInteractionEnabled = YES;
    [iView->myView.view addSubview:textField];
}

@end

