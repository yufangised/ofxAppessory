/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iLabel.mm
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "iLabel.h"


iLabel::iLabel(string text){
    
    //label = [[UILabel alloc] init];
    numOfLines = 1;
    textOflabel = ofxStringToNSString(text);
    
    colorOftext = [UIColor darkTextColor];
    colorOfBackground = [UIColor clearColor];
    sizeOfFont = 16.0f;
    styleOfFont = 0;
    alignmentOfText = 0;
    isWithShadow = false;
    
}

iLabel::iLabel(string text, int numberOflines){

    numOfLines = numberOflines;
    textOflabel = ofxStringToNSString(text);
    
    colorOftext = [UIColor darkTextColor];
    colorOfBackground = [UIColor clearColor];
    sizeOfFont = 16.0f;
    styleOfFont = 0;
    alignmentOfText = 0;
    isWithShadow = false;
}

iLabel::~iLabel(void){
    
}

void iLabel::setFrame(float x, float y, float width, float height){
    
    labelFrame = CGRectMake(x, y, width, height);
        
}

void iLabel::setBackground(int r, int g, int b, int a){
    
    colorOfBackground = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                        green:ofClamp(g, 0, 255)/255.0f 
                                         blue:ofClamp(b, 0, 255)/255.0f 
                                        alpha:ofClamp(a, 0, 255)/255.0f];
}

void iLabel::setBackground(PREDEFINED_BACKGROUND background){
    
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

void iLabel::setTextColor(int r, int g, int b, int a){
    
    colorOftext = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                  green:ofClamp(g, 0, 255)/255.0f 
                                   blue:ofClamp(b, 0, 255)/255.0f 
                                  alpha:ofClamp(a, 0, 255)/255.0f];
    
}

void iLabel::setFont(float fontSize){
    
    sizeOfFont = fontSize;
}

void iLabel::setFont(float fontSize, FONT_STYLE style){
    
    sizeOfFont = fontSize;
    styleOfFont = style;
}
void iLabel::setFont(float fontSize, FONT_STYLE style, bool withShadow){
    
    sizeOfFont = fontSize;
    styleOfFont = style;
    isWithShadow = withShadow;

}

void iLabel::setTextAlignment(TEXT_ALIGNMENT alignment){
    
    if(alignment == CENTER || alignment == LEFT || alignment == RIGHT){
        alignmentOfText = alignment;
    }else {
        alignmentOfText = CENTER;
    }
}


//void iLabel::swichtIsChanged:(iViewController iView){

void iLabel::addToView(iViewController *iView){
    
    label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = textOflabel;
    label.numberOfLines = numOfLines;
    label.backgroundColor = colorOfBackground;
    switch (styleOfFont) {
        case 0:
            label.font = [UIFont systemFontOfSize:sizeOfFont];
            break;
        case 1:
            label.font = [UIFont boldSystemFontOfSize:sizeOfFont];
            break;
        case 2:
            label.font = [UIFont italicSystemFontOfSize:sizeOfFont];
            break;
        default:
            label.font = [UIFont systemFontOfSize:sizeOfFont];
            break;
    }
    
    switch (alignmentOfText) {
        case 0:
            label.textAlignment = UITextAlignmentCenter;
            break;
        case 1:
            label.textAlignment = UITextAlignmentLeft;
            break;
        case 2:
            label.textAlignment = UITextAlignmentRight;
            break;
        default:
            label.textAlignment = UITextAlignmentCenter;
            break;
    }
    
    if (isWithShadow) {
        label.shadowColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(0,1);
    }
    
    label.textColor = colorOftext;
    
    
    [iView->myView.view addSubview:label];
}

//when somebody clicks thisSwtich 
//bool isOn = STATE OF THE SWTICH
//fire ofNotifyEvent(changed, isOn, this);


