/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ARDUINO_DEFINE.mm
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include "ARDUINO_DEFINE.h"

unsigned char DIGITAL_CONFIG_BUF[] = {'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'};
unsigned char ANALOG_CONFIG_BUF[] = {'0', '0', '0', '0', '0', '0'};
unsigned int  DIGITAL_PWM[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};
unsigned int  ANALOG_INPUT[] = {0,0,0,0,0,0};
unsigned int  NUM_OF_SENDING_BYTES = 0;