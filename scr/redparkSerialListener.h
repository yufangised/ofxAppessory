/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * redparkSerialListener.h - ofxSerial library
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

#import <Foundation/Foundation.h>
#import "RscMgr.h"

@interface redparkSerialListener : NSObject <RscMgrDelegate>
{
    RscMgr *rscMgr;
    bool    cable_connected;
}

//properties
@property (nonatomic, retain)   RscMgr *rscMgr;
@property (nonatomic) bool      cable_connected;

@end