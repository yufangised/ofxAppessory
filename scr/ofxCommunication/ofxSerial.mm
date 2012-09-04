/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ofxSerial.mm - ofxSerial library
 * Copyright (c) 2012 Copenhagen Institute of Interaction Design. 
 * All right reserved.
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

#import "redparkSerialListener.h"
#import "ofxSerial.h"


/***************** redparkSerialListerner implitation ******************/

@implementation redparkSerialListener
@synthesize rscMgr;
@synthesize cable_connected;

// init Readpark manager
-(id) init
{
    self = [super init];
    rscMgr = [[RscMgr alloc] init];
    [rscMgr setDelegate:self];
    return self;
}


#pragma mark - RscMgrDelegate methods
- (void) cableConnected:(NSString *)protocol
{
    NSLog(@"Cable Connected: %@", protocol);
    cable_connected = TRUE;
}

// Redpark Serial Cable was disconnected and/or application moved to background
- (void) cableDisconnected
{
    NSLog(@"Cable disconnected");
    cable_connected = FALSE;
}

// serial port status has changed
// user can call getModemStatus or getPortStatus to get current state
- (void) portStatusChanged
{
    NSLog(@"portStatusChanged");
}

// bytes are available to be read (user calls read:)
- (void) readBytesAvailable:(UInt32)length
{
    return;
}


/*********************** ofxSerial implitation *************************/

ofxSerial::ofxSerial(void) : _initialised(false){
    
    self = [[redparkSerialListener alloc] init];
    
}


ofxSerial::~ofxSerial(void){
    
    close();
}


void ofxSerial::enumerateDevices(){
    // do nothing
}


void ofxSerial::close(){
	
	_initialised = false;
	[(id)self dealloc];
}


bool ofxSerial::setup(int baud){
    
    [[(id)self rscMgr] setBaud:baud];
    _initialised = true;
    
    if([(id)self cable_connected]){
        
        [[(id)self rscMgr] open];
    }
    return true;
}


int ofxSerial::readBytes(unsigned char *buffer, int length){
    
    return [[(id)self rscMgr] read:buffer Length:length];
}


int ofxSerial::writeBytes(unsigned char *buffer, int length){
    
    return [[(id)self rscMgr] write:buffer Length:length];
}


int ofxSerial::readByte(){
    
	if ([[(id)self rscMgr] getReadBytesAvailable] < 0 || _initialised == false){
		return -1;
	}else{
		UInt8 tmpByte[1];
		[[(id)self rscMgr] read:tmpByte Length:1];
		return tmpByte[0];
	}
}


bool ofxSerial::writeByte(unsigned char singleByte){
    
    if (_initialised == false) {
		return false;
	}else{
		UInt8 tmpByte[1];
		tmpByte[0] = singleByte;
		[[(id)self rscMgr] write:tmpByte Length:1];
		return true;		
	}
}


int ofxSerial::available(){
    
    return [[(id)self rscMgr] getReadBytesAvailable];
}


void ofxSerial::flush(bool flushIn, bool flushOut){
    
    serialPortControl* ctrl;
    ctrl->rxFlush = (flushIn ? 1 : 0);
    ctrl->txFlush = (flushOut ? 1 : 0);
    [[(id)self rscMgr] setPortControl:ctrl RequestStatus:FALSE];//
}


void ofxSerial::drain(){

	;// do nothing
}


bool ofxSerial::connected(){
    
    return [(id)self cable_connected];
}


bool ofxSerial::initialised(){
    
    return _initialised;
}


@end