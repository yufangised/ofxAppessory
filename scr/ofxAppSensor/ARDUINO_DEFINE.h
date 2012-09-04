/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ARDUINO_DEFINE.h
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

//ARDUINO DIGITAL PINS(14)
#define PIN_0       0   // ARDUINO_DIGITAL_PIN_0 = RX       
#define PIN_1       1   // ARDUINO_DIGITAL_PIN_1 = TX
#define PIN_2       2   // ARDUINO_DIGITAL_PIN_2
#define PIN_3       3   // ARDUINO_DIGITAL_PIN_3
#define PIN_4       4   // ARDUINO_DIGITAL_PIN_4
#define PIN_5       5   // ARDUINO_DIGITAL_PIN_5
#define PIN_6       6   // ARDUINO_DIGITAL_PIN_6
#define PIN_7       7   // ARDUINO_DIGITAL_PIN_7
#define PIN_8       8   // ARDUINO_DIGITAL_PIN_8
#define PIN_9       9   // ARDUINO_DIGITAL_PIN_9
#define PIN_10      10  // ARDUINO_DIGITAL_PIN_10
#define PIN_11      11  // ARDUINO_DIGITAL_PIN_11
#define PIN_12      12  // ARDUINO_DIGITAL_PIN_12
#define PIN_13      13  // ARDUINO_DIGITAL_PIN_13

//ANALOG INPUT PINS
#define PIN_14      0   // ARDUINO_ANALOG_PIN_0
#define PIN_15      1   // ARDUINO_ANALOG_PIN_1
#define PIN_16      2   // ARDUINO_ANALOG_PIN_2
#define PIN_17      3   // ARDUINO_ANALOG_PIN_3
#define PIN_18      4   // ARDUINO_ANALOG_PIN_4
#define PIN_19      5   // ARDUINO_ANALOG_PIN_5

//
#define DEFAULT         "default"
#define OUTPUT          "output"
#define INPUT           "input"

#define ARDUINO_LOW     0
#define ARDUINO_HIGH    1


typedef enum DIGITAL_PIN{
    
    DIGITAL_2  = PIN_2,     
    DIGITAL_3  = PIN_3,       
    DIGITAL_4  = PIN_4,
    DIGITAL_5  = PIN_5,
    DIGITAL_6  = PIN_6,   
    DIGITAL_7  = PIN_7,
    DIGITAL_8  = PIN_8,
    DIGITAL_9  = PIN_9,
    DIGITAL_10 = PIN_10,
    DIGITAL_11 = PIN_11,
    DIGITAL_12 = PIN_12,
    DIGITAL_13 = PIN_13
    
} DIGITAL_PIN;

typedef enum PWM_PIN{
    
    PWM_3  = PIN_3,
    PWM_5  = PIN_5,
    PWM_6  = PIN_6,
    PWM_9  = PIN_9,
    PWM_10 = PIN_10,
    PWM_11 = PIN_11
    
} PWM_PIN;

typedef enum ANALOG_PIN{
    
    ANALOG_0 = PIN_14,
    ANALOG_1 = PIN_15,
    ANALOG_2 = PIN_16,
    ANALOG_3 = PIN_17,
    ANALOG_4 = PIN_18,
    ANALOG_5 = PIN_19
    
} ANALOG_PIN;

typedef enum STATE{
    
    OFF  = 0,
    ON   = 1,
    LOW  = ARDUINO_LOW,
    HIGH = ARDUINO_HIGH,
    
} STATE;


typedef enum TRIGGER_WHEN{
    
    SMALLER_THAN = 0,
    LARGER_THAN = 1
    
} TRIGGER_WHEN;

typedef enum TRIGGER_AT{
    
    STATE_LOW = 0,
    STATE_HIGH = 1
    
} TRIGGER_AT;


// digital input   -------->   'd'
// digital output  -------->   'D'
// PWM(analog out) -------->   'A'
// analog input    -------->   'a'

extern unsigned char DIGITAL_CONFIG_BUF[14];
extern unsigned char ANALOG_CONFIG_BUF[6];
extern unsigned int  DIGITAL_PWM[14];
extern unsigned int  ANALOG_INPUT[6];
extern unsigned int  NUM_OF_SENDING_BYTES;
