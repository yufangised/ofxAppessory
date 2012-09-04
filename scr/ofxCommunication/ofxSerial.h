/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ofxSerial.h - ofxSerial library
 * Copyright (c) 2012 Copenhagen Institute of Interaction Design. 
 * All right reserved.
 *
 * ofxSerial.h has a very similar interface to ofSerial.h. The methods 
 * commented exist in ofSerial.h but are not available in ofxSerial.h 
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser Public License for more details.
 *
 * You should have received a copy of the GNU Lesser Public License
 * along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 *
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * + author: dviid + yufan
 * + contact: dviid@labs.ciid.dk + w.yufan@edu.ciid.dk
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once

#include "ofConstants.h"
#include "ofTypes.h"
#include <termios.h>
#include <iostream>

class ofxSerial
{
public:
    ofxSerial(void);
    ~ofxSerial(void);
	
  //void			listDevices(); //
	void 			enumerateDevices(); //
	
  //vector <ofSerialDeviceInfo> getDeviceList(); //
	
	void 			close();
	bool			setup(int baud);	// use default port, baud (0,9600)
  //bool			setup(string portName, int baudrate);
  //bool			setup(int deviceNumber, int baudrate);
    
	int 			readBytes(unsigned char * buffer, int length);
	int 			writeBytes(unsigned char * buffer, int length);
    
	bool			writeByte(unsigned char singleByte);
	int             readByte();  // returns -1 on no read or error...
    void            flush(bool flushIn = true, bool flushOut = true);
    int				available();
    
	void            drain();
    
    bool			connected();
    bool			initialised();    
        
    

private:
    void			*self;
    bool			_initialised;
    bool			_connected;
};
