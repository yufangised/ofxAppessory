/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * LightSensor.mm
 *
 * Created by Wang Yufan on 8/17/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include <iostream>
#import "LightSensor.h"


LightSensor::LightSensor(DIGITAL_PIN digitalPin){
    
   
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'd';
    isAnalog = false;
    isReverse = false;
    
    
    DIGITAL_PWM[pinNumber] ? currentState = false : currentState = true;
    tempState = currentState;
}

LightSensor::LightSensor(DIGITAL_PIN digitalPin, TRIGGER_AT state){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'd';
    isAnalog = false;
    isReverse = false;
    
    DIGITAL_PWM[pinNumber] ? currentState = false : currentState = true;
    tempState = currentState;
    
    triggerState = state;   
    ofAddListener(ofEvents().update, this, &LightSensor::update);

}


LightSensor::LightSensor(ANALOG_PIN analogPin){
    
    pinNumber = analogPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'a';
    isAnalog = true;
    isReverse = false;
    
    currentValue = ANALOG_INPUT[pinNumber];
    tempValue = currentValue;
    
    ofAddListener(ofEvents().update, this, &LightSensor::update);

}

LightSensor::LightSensor(ANALOG_PIN analogPin, TRIGGER_WHEN direction, int threshold){
    
    pinNumber = analogPin;
    ANALOG_CONFIG_BUF[pinNumber] = 'a';
    isAnalog = true;
    isReverse = false;
    
    analogThreshold = threshold;
    
    currentValue = ANALOG_INPUT[pinNumber];
    tempValue = currentValue;
    
    triggerState = direction;   
    ofAddListener(ofEvents().update, this, &LightSensor::update);
    
}

void LightSensor::reverse(){
    isReverse = true;
}

bool LightSensor::getState(){

    if (isAnalog == false) {
        
        if (isReverse) {
            return (DIGITAL_PWM[pinNumber] ? false : true);
        } else {
            return (DIGITAL_PWM[pinNumber] ? true : false);
        }
        
    }else {
        ofLog() << "Warning: getStage() is not available when a LightSensor is connected to a Analog pin!"; 
        return false;
    }
    
}

int LightSensor::getValue(){
    
    if (isAnalog == true) {
        
        if (isReverse) {
            return 1023 - ANALOG_INPUT[pinNumber];
        } else {
            return ANALOG_INPUT[pinNumber];
        }
        
    } else {
        ofLog() << "Warning: getValue() is not available when a LightSensor is connected to a Digital pin!"; 
        if (isReverse) {
            return 1 - DIGITAL_PWM[pinNumber];
        } else {
            return DIGITAL_PWM[pinNumber];
        }
    }
}


void LightSensor::attach(bool &variable){
    
   

    if (isAnalog) {
        ofLog()<< "Waring: LightSensor method: attach(bool &variable) is not available when a LightSensor connected to an Analog pin!";
    } else {
        if (isReverse) {
            DIGITAL_PWM[pinNumber] ? variable = true : variable = false;
        } else {
            DIGITAL_PWM[pinNumber] ? variable = false : variable = true;
        }

        
    }
}

void LightSensor::attach(int &variable, int rangeMinimum, int rangeMaximum){
    
    int inputValue;
    if (isReverse) {
        inputValue = 1023 - ANALOG_INPUT[pinNumber];
    } else {
        inputValue = ANALOG_INPUT[pinNumber];
    }
    
    if (isAnalog){
        
        if (rangeMaximum > rangeMinimum) {
            variable = (int) (ofMap(inputValue, 0, 1023, rangeMinimum, rangeMaximum));
        } else {
            variable = (int) (ofMap(inputValue, 0, 1023, rangeMaximum, rangeMinimum));
            ofLog() << "Warning: LightSensor method: attach(int &variable, int rangeMinimum, int rangeMaximum) value range was set wrong!";
        }
        
    }else {
        ofLog() <<"Warning: LightSensor method: attach(int &variable, int rangeMinimum, int rangeMaximum) is not available when a LightSensor is connected to a Digital pin!";
    }
}


void LightSensor::attach(float &variable, float rangeMinimum, float rangeMaximum){
    
    int inputValue;
    if (isReverse) {
        inputValue = 1023 - ANALOG_INPUT[pinNumber];
    } else {
        inputValue = ANALOG_INPUT[pinNumber];
    }

    
    if (isAnalog){
        
        if (rangeMaximum > rangeMinimum) {
            variable =  (ofMap(inputValue, 0, 1023, rangeMinimum, rangeMaximum));
        } else {
            variable =  (ofMap(inputValue, 0, 1023, rangeMaximum, rangeMinimum));
            ofLog() << "Warning: LightSensor method: attach(int &variable, int rangeMinimum, int rangeMaximum) value range was set wrong!";
        }
        
    }else {
        ofLog() <<"Warning: LightSensor method: attach(float &variable, float rangeMinimum, float rangeMaximum) is not available when a LightSensor is connected to a Digital pin!";
    }

    
}


void LightSensor::attach(iTextField *textField){
    
    int inputValue = 0;
    
    if(isAnalog){
        if (isReverse) {
            inputValue = 1023 - ANALOG_INPUT[pinNumber];
        }else {
            inputValue = ANALOG_INPUT[pinNumber];
        }
        
        stringstream valueString;
        valueString << inputValue;
        textField->setText(valueString.str());
    } else {
        if (isReverse) {
            DIGITAL_PWM[pinNumber] ? textField->setText("false") : textField->setText("true");
        } else {
            DIGITAL_PWM[pinNumber] ? textField->setText("true") : textField->setText("false");
        }
    }
}


void LightSensor::update(ofEventArgs &Args){
    
    if (isAnalog == false) {
        
        if (isReverse) {
            DIGITAL_PWM[pinNumber] ? tempState = false : tempState = true;
        }else {
            DIGITAL_PWM[pinNumber] ? tempState = true : tempState = false;
        }
        
        
        if (triggerState == STATE_HIGH) {
            
            if (tempState == true || tempState != currentState) {
                currentState = tempState;
                ofNotifyEvent(triggeredOn, currentState, this);
            }
                
            if (tempState == false || tempState != currentState) {
                currentState = tempState;
                ofNotifyEvent(triggeredOff, currentState, this);
            }
        }
    
       if (triggerState == STATE_LOW) {
        
            if (tempState == false || tempState != currentState) {
                currentState = tempState;
                ofNotifyEvent(triggeredOn, currentState, this);
            }
        
            if (tempState == true || tempState != currentState) {
                currentState = tempState;
                ofNotifyEvent(triggeredOff, currentState, this);
            }
       }
        
    } else {
        
        if (isReverse) {
            tempValue = 1023 - ANALOG_INPUT[pinNumber];
        }else {
            tempValue = ANALOG_INPUT[pinNumber];
        }

        
        if (triggerState == LARGER_THAN) {
            
            if (tempValue > analogThreshold || currentValue <= analogThreshold) {
                currentValue = tempValue;
                ofNotifyEvent(triggeredOn, currentValue, this);
            }
            
            if (tempValue < analogThreshold || currentValue >= analogThreshold) {
                currentValue = tempValue;
                ofNotifyEvent(triggeredOff, currentValue, this);
            }
        }
        
        
        if (triggerState == SMALLER_THAN) {
            
            if (tempValue < analogThreshold || currentValue >= analogThreshold) {
                currentValue = tempValue;
                ofNotifyEvent(triggeredOn, currentValue, this);
            }
            
            if (tempValue > analogThreshold || currentValue <= analogThreshold) {
                currentValue = tempValue;
                ofNotifyEvent(triggeredOff, currentValue, this);
            }
        }
    }
}
        
        
