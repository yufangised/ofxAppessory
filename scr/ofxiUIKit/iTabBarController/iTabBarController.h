/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iTabBarController.h
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocTabBarController.h"
#import "iViewController.h"
#import "iNavigationController.h"

#pragma once

class iTabBarController
{
public:
    iTabBarController(iViewController *viewController);
    
    iTabBarController(iViewController *viewController1, 
                      iViewController *viewController2);
    
    iTabBarController(iViewController *viewController1, 
                      iViewController *viewController2, 
                      iViewController *viewController3);
    
    iTabBarController(iViewController *viewController1, 
                      iViewController *viewController2, 
                      iViewController *viewController3, 
                      iViewController *viewController4);
    
    iTabBarController(iViewController *viewController1, 
                      iViewController *viewController2, 
                      iViewController *viewController3, 
                      iViewController *viewController4,
                      iViewController *viewController5);
    
    iTabBarController(iViewController *viewController1, 
                      iViewController *viewController2, 
                      iViewController *viewController3, 
                      iViewController *viewController4,
                      iViewController *viewController5,
                      iViewController *viewController6);
    
    
    iTabBarController(iNavigationController *navigationController);
    
    iTabBarController(iNavigationController *navigationController1, 
                      iNavigationController *navigationController2);
    
    iTabBarController(iNavigationController *navigationController1, 
                      iNavigationController *navigationController2,
                      iNavigationController *navigationController3);
    
    iTabBarController(iNavigationController *navigationController1, 
                      iNavigationController *navigationController2,
                      iNavigationController *navigationController3,
                      iNavigationController *navigationController4);
    
    iTabBarController(iNavigationController *navigationController1, 
                      iNavigationController *navigationController2,
                      iNavigationController *navigationController3,
                      iNavigationController *navigationController4,
                      iNavigationController *navigationController5);
    
    iTabBarController(iNavigationController *navigationController1, 
                      iNavigationController *navigationController2,
                      iNavigationController *navigationController3,
                      iNavigationController *navigationController4,
                      iNavigationController *navigationController5,
                      iNavigationController *navigationController6);
    
    ~iTabBarController();
    
    ocTabBarController  *myTabBarController;
    
    
    void                shareViewWithOpenGL();
    
    
public: 
    
    int                 tabIndex; 
    
};
