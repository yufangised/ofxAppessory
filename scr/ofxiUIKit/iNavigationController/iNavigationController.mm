/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * NavigationController.mm
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocNavigationController.h"
#import "iNavigationController.h"

@implementation ocNavigationController
//@synthesize viewLoaded;



-(id) init{

    self = [super init];
    return self;
}

-(void) dealloc{
    [super dealloc];
}



iNavigationController::iNavigationController(iViewController *rootViewController)
{
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController->myView];
   
}

iNavigationController::~iNavigationController()
{
    [myNavigationController dealloc];
}


void iNavigationController::pushViewController(iViewController *viewController){
    
    [myNavigationController pushViewController:viewController->myView animated:YES];
    
}

void iNavigationController::popViewController(){
    
    [myNavigationController popViewControllerAnimated:YES];
    
}

void iNavigationController::customizeNavigationBarWithImage(string imageName_portrait){
    
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:ofxStringToNSString(imageName_portrait)]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]; 
   
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground 
                                       forBarMetrics:UIBarMetricsDefault];
    
    [NavigationPortraitBackground release];
}



void iNavigationController::customizeNavigationBarWithImage(string imageName_portrait, string imageName_landscape){
    
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:ofxStringToNSString(imageName_portrait)]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]; 
    
    UIImage *NavigationLandscapeBackground = [[UIImage imageNamed:ofxStringToNSString(imageName_landscape)] 
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground 
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground 
                                       forBarMetrics:UIBarMetricsLandscapePhone];
    
    [NavigationPortraitBackground release];
    [NavigationLandscapeBackground release];
    

}

void iNavigationController::shareViewWithOpenGL(){
    
	[[[UIApplication sharedApplication] keyWindow] addSubview:myNavigationController.view];
}



@end
