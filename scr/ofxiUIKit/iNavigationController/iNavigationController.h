/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * NavigationController.h
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocNavigationController.h"
#import "iViewController.h"

#pragma once

class iNavigationController
{
public:
    iNavigationController       (iViewController *rootViewController);
    ~iNavigationController      ();
    
    void                        pushViewController(iViewController *viewController);
    void                        popViewController();
    
    void                        customizeNavigationBarWithImage(string imageName_portrait);
    
    void                        customizeNavigationBarWithImage(string imageName_portrait, 
                                                                string imageName_landscape);
    
    void                        setNavigationBarTextColor(int r, int g, int b, int a);
    

    void                        shareViewWithOpenGL();
    
    UINavigationController      *myNavigationController;
        
private:
    
    
    
};
