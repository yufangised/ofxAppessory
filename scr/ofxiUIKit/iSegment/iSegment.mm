/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSegment.mm
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocSegment.h"
#import "iSegment.h"
#import "ofEvents.h"

@implementation ocSegment
@synthesize parent;

-(id) initWithItems:(NSArray *)items
{
    self = [super initWithItems:(NSArray *) items];
    
    [self addTarget:self 
             action:@selector(segmentIsChanged:) 
   forControlEvents:UIControlEventValueChanged];   
    
    return self;
    
}

- (void) segmentIsChanged:(UISegmentedControl *)paramSender
{ 
    if ([paramSender isEqual:self]){
    //NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
    //NSString *selectedSegmentText =[paramSender titleForSegmentAtIndex:selectedSegmentIndex];
    //NSLog(@"Segment %ld with %@ text is selected", (long)selectedSegmentIndex, selectedSegmentText);
    int index = [paramSender selectedSegmentIndex];
    ofNotifyEvent(parent->segmentChanged, index, parent);
    parent->currentIndex = index;
    } 
}

// implementation of iSegment
iSegment::iSegment(int numberOfSegments, string title, ...){
    
        
    numOfSegments = numberOfSegments;
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:ofxStringToNSString(title), nil];
        
    va_list names;
    va_start(names, title);
        
    for(int i = 0; i< numberOfSegments-1; ++i){
            
        const char *name = va_arg(names, const char *);
            
        if (name == NULL) {
            
            [titleArray addObject:@"untitled"];
            
            }else {
            
            [titleArray addObject:ofxStringToNSString(name)];
                
            }
        }
    
        va_end(names);
    
    segment = [[ocSegment alloc] initWithItems:titleArray];
    styleOfSegment = BAR;
    currentIndex = 0;
}

iSegment::~iSegment()
{
    
}

void iSegment::setFrame(float x, float y, float width, float height){
    
    segmentFrame = CGRectMake(x, y, width, height);
}

void iSegment::setSegmentStyle(SEGMENT_STYLE style){
    
    styleOfSegment = style;

}

void iSegment::setSegmentColor(int r, int g, int b, int a){

    if (styleOfSegment == BAR) {
        segment.tintColor = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                            green:ofClamp(g, 0, 255)/255.0f 
                                             blue:ofClamp(b, 0, 255)/255.0f 
                                            alpha:ofClamp(a, 0, 255)/255.0f];
    }else {
        ofLog() << "Warning: setSelectedColor() is only supported for iSegment in BAR style!";
    }
}

void iSegment::setSelectedSegment(int index){
    
    if (index > numOfSegments) {
        currentIndex = numOfSegments;
    } else {
        currentIndex = index;
    }
}

void iSegment::addToView(iViewController *iView){
    
    
    segment.frame = segmentFrame;
    //segment.tintColor = [UIColor greenColor];
    switch (styleOfSegment) {
        case 0:
            segment.segmentedControlStyle = UISegmentedControlStyleBar;
            break;
        case 1:
            segment.segmentedControlStyle = UISegmentedControlStyleBezeled;
            break;
        case 2:
            segment.segmentedControlStyle = UISegmentedControlStyleBordered;
            break;
        default:
            segment.segmentedControlStyle = UISegmentedControlStyleBar;
            break;
    }
    segment.selectedSegmentIndex = currentIndex;
    segment.parent = this;
    [iView->myView.view addSubview:segment];
}

int iSegment::getIndex(){
    
    return currentIndex;
}

@end
