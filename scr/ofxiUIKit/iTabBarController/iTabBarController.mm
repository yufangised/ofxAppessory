/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iTabBarController.mm
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocTabBarController.h"
#import "iTabBarController.h"


@implementation ocTabBarController

-(id) init
{
    self = [super init];
    //[self setDelegate:self];
    return self;
}

-(void) dealloc{
    
    [super dealloc];
}



// init with 1 iViewControllers
iTabBarController::iTabBarController(iViewController *viewController){
    
    myTabBarController = [[ocTabBarController alloc] init];
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:viewController->myView, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
    
}

// init with 2 iViewControllers
iTabBarController::iTabBarController(iViewController *viewController1, 
                                     iViewController *viewController2){
    
    myTabBarController = [[ocTabBarController alloc] init];
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:viewController1->myView, 
                                 viewController2->myView, nil];
    
    [myTabBarController setViewControllers:iViewControllers];    
}

// init with 3 iViewControllers
iTabBarController::iTabBarController(iViewController *viewController1, 
                                     iViewController *viewController2, 
                                     iViewController *viewController3){
    
    myTabBarController = [[ocTabBarController alloc] init];
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:viewController1->myView, 
                                 viewController2->myView, 
                                 viewController3->myView, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
}

// init with 4 iViewControllers
iTabBarController::iTabBarController(iViewController *viewController1, 
                                     iViewController *viewController2, 
                                     iViewController *viewController3,
                                     iViewController *viewController4){
    
    myTabBarController = [[ocTabBarController alloc] init];
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:viewController1->myView, 
                                 viewController2->myView, 
                                 viewController3->myView,
                                 viewController4->myView, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
}

// init with 5 iViewControllers
iTabBarController::iTabBarController(iViewController *viewController1, 
                                     iViewController *viewController2, 
                                     iViewController *viewController3,
                                     iViewController *viewController4,
                                     iViewController *viewController5){
    
    myTabBarController = [[ocTabBarController alloc] init];
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:viewController1->myView, 
                                 viewController2->myView, 
                                 viewController3->myView,
                                 viewController4->myView,
                                 viewController5->myView, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
}

// init with 6 iViewControllers
iTabBarController::iTabBarController(iViewController *viewController1, 
                                     iViewController *viewController2, 
                                     iViewController *viewController3,
                                     iViewController *viewController4,
                                     iViewController *viewController5,
                                     iViewController *viewController6){
    
    myTabBarController = [[ocTabBarController alloc] init];
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:viewController1->myView, 
                                 viewController2->myView, 
                                 viewController3->myView,
                                 viewController4->myView,
                                 viewController5->myView, 
                                 viewController6->myView, nil];
        
    [myTabBarController setViewControllers:iViewControllers];
}


//init with 1 iNavigationControllers
iTabBarController::iTabBarController(iNavigationController *navigationController1){
    
    myTabBarController = myTabBarController = [[ocTabBarController alloc] init];  
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:navigationController1->myNavigationController, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
}


//init with 2 iNavigationControllers
iTabBarController::iTabBarController(iNavigationController *navigationController1, 
                                     iNavigationController *navigationController2){
    
    myTabBarController = myTabBarController = [[ocTabBarController alloc] init];  
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:navigationController1->myNavigationController, 
                                 navigationController2->myNavigationController, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
}

//init with 3 iNavigationControllers
iTabBarController::iTabBarController(iNavigationController *navigationController1, 
                                     iNavigationController *navigationController2,
                                     iNavigationController *navigationController3){
    
    myTabBarController = myTabBarController = [[ocTabBarController alloc] init];  
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:navigationController1->myNavigationController, 
                                 navigationController2->myNavigationController, 
                                 navigationController3->myNavigationController, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
}

//init with 4 iNavigationControllers
iTabBarController::iTabBarController(iNavigationController *navigationController1, 
                                     iNavigationController *navigationController2,
                                     iNavigationController *navigationController3,
                                     iNavigationController *navigationController4){
    
    myTabBarController = myTabBarController = [[ocTabBarController alloc] init];  
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:navigationController1->myNavigationController, 
                                 navigationController2->myNavigationController, 
                                 navigationController3->myNavigationController, 
                                 navigationController4->myNavigationController, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
}

//init with 5 iNavigationControllers
iTabBarController::iTabBarController(iNavigationController *navigationController1, 
                                     iNavigationController *navigationController2,
                                     iNavigationController *navigationController3,
                                     iNavigationController *navigationController4,
                                     iNavigationController *navigationController5){
    
    myTabBarController = myTabBarController = [[ocTabBarController alloc] init];  
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:navigationController1->myNavigationController, 
                                 navigationController2->myNavigationController, 
                                 navigationController3->myNavigationController, 
                                 navigationController4->myNavigationController, 
                                 navigationController5->myNavigationController, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
}

//init with 6 iNavigationControllers
iTabBarController::iTabBarController(iNavigationController *navigationController1, 
                                     iNavigationController *navigationController2,
                                     iNavigationController *navigationController3,
                                     iNavigationController *navigationController4,
                                     iNavigationController *navigationController5,
                                     iNavigationController *navigationController6){
    
    myTabBarController = myTabBarController = [[ocTabBarController alloc] init];  
    
    NSArray *iViewControllers = [NSArray arrayWithObjects:navigationController1->myNavigationController, 
                                 navigationController2->myNavigationController, 
                                 navigationController3->myNavigationController, 
                                 navigationController4->myNavigationController, 
                                 navigationController5->myNavigationController, 
                                 navigationController6->myNavigationController, nil];
    
    [myTabBarController setViewControllers:iViewControllers];
    
}



iTabBarController::~iTabBarController(){
    
}


void iTabBarController::shareViewWithOpenGL(){
    
	[[[UIApplication sharedApplication] keyWindow] addSubview:myTabBarController.view];
}



@end
