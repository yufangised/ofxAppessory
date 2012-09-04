/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iViewController.mm
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocViewController.h"
#import "iViewController.h"



@implementation ocViewController
@synthesize viewLoaded;
@synthesize viewOrientation;


-(id) initWithOrientation:(int)orientation
{
    self = [super init];
    viewOrientation = orientation;
    //self = [[UIViewController alloc] init];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.viewLoaded = TRUE;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    switch (viewOrientation) {
        case PORTRAIT:
            return (interfaceOrientation == UIInterfaceOrientationPortrait);
            break;
        
        case UPSIDEDOWN:
            return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
            break;
            
        case LANDSCAPE_RIGHT:
            return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
            break;
        
        case LANDSCAPE_LEFT:
            return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
            break;
            
        default:
            return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
            break;
    }
     
    
}

- (void)dealloc{

    [super dealloc];
    
}


iViewController::iViewController()
{
    myView = [[ocViewController alloc] initWithOrientation:PORTRAIT];
    
    
    myView.tabBarItem.title = @"View Controller";
    //myView.tabBarItem.image = [UIImage imageNamed:@"defaultTabBarIcon.png"];
    
    //NSLog(@"init the view");
    
}

iViewController::iViewController(string name)
{
    myView = [[ocViewController alloc] initWithOrientation:PORTRAIT];
    
    myView.title = ofxStringToNSString(name);
    
    myView.tabBarItem.title = ofxStringToNSString(name);
    //myView.tabBarItem.image = [UIImage imageNamed:@"defaultTabBarIcon.png"];
    
    //NSLog(@"init the view");
    
}

iViewController::iViewController(string name, ORIENTATION orientation)
{
    myView = [[ocViewController alloc] initWithOrientation:orientation];
    
    myView.title = ofxStringToNSString(name);
    
    myView.tabBarItem.title = ofxStringToNSString(name);
    //myView.tabBarItem.image = [UIImage imageNamed:@"defaultTabBarIcon.png"];
    
}

iViewController::~iViewController(){
    
    [myView dealloc];
    [UIColor release];
    
}



void iViewController::setBackground(int r, int g, int b, int a){
     
    
    myView.view.backgroundColor = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                                 green:ofClamp(g, 0, 255)/255.0f 
                                                  blue:ofClamp(b, 0, 255)/255.0f 
                                                 alpha:ofClamp(a, 0, 255)/255.0f];
     
    
}


void iViewController::setBackground(PREDEFINED_BACKGROUND background){

    switch (background) {
        case 0:
            backgroundColor = [UIColor whiteColor];
            break;
            
        case 1:
            backgroundColor = [UIColor blackColor];
            break;
            
        case 2:
            backgroundColor = [UIColor clearColor];
            break;
            
        case 3:
            backgroundColor = [UIColor groupTableViewBackgroundColor];
            break;
            
        case 4:
            backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
            break;
        
        default:
            backgroundColor = [UIColor clearColor];
            break;
    }
    
    myView.view.backgroundColor = backgroundColor;

}


void iViewController::setBackgroundImage(string imageName){
    
    myView.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:ofxStringToNSString(imageName)]];
}

void iViewController::setTabBarIcon(string imageName){
    
    myView.tabBarItem.image = [UIImage imageNamed:ofxStringToNSString(imageName)];
    if (myView.tabBarItem.image == nil) {
        //myView.tabBarItem.image = [UIImage imageNamed:@"defaultTabBarIcon.png"];
    }
}

void iViewController::shareViewWithOpenGL(){
    
	[[[UIApplication sharedApplication] keyWindow] addSubview:myView.view];
}

@end
