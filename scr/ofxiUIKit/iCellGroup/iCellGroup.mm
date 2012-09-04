/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iCellGroup.mm
 *
 * Created by Wang Yufan on 8/1/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include "testApp.h"
#include <iostream>
#include "iCellGroup.h"
#include <stdarg.h>
#include "ofxiPhoneExtras.h"




iCellGroup::iCellGroup(int numberOfCells, string cellLabel, ...){
    
    numOfCells = numberOfCells;
    isTypeDefined = false;
    
    headerAndFooterInfo.push_back("");
    headerAndFooterInfo.push_back(""); 
    
    cellLabels.push_back(cellLabel);
    //NSMutableArray *cellLabels = [[NSMutableArray alloc] initWithObjects:ofxStringToNSString(cellLabel), nil];
    
    va_list names;
    va_start(names, cellLabel);
    
    for(int i = 0; i< numberOfCells-1; ++i){
        
        const char *name = va_arg(names, const char*);
        
        if(name == NULL){
            
         cellLabels.push_back("untitled"); 
            //[cellLabels addObject:@"untitled"];
            
        }else{
         cellLabels.push_back(name); 
            //[cellLabels addObject:ofxStringToNSString(name)];
        }
    }
    va_end(names);
    
}

iCellGroup::~iCellGroup(){

}

void iCellGroup::setAccessoryType(ACCESSORY_TYPE type, ...){
    
    accessoryTypes.push_back(type);    
        
    
    va_list typeList;
    va_start(typeList, type);
    
    for (int i = 0; i < numOfCells -1 ; ++i) {
        int typeOfAccessory = va_arg(typeList, int);
        
        accessoryTypes.push_back(typeOfAccessory);
        
        }
    
    isTypeDefined = true;
}

void  iCellGroup::headerAndFooter(string header, string footer){
    
    headerAndFooterInfo[0] = header;
    headerAndFooterInfo[1] = footer;
    
}
