/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iTableView.mm
 *
 * Created by Wang Yufan on 8/2/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "iTableView.h"
#import "ocTableView.h"


@implementation ocTableView
@synthesize numberOfSections;
@synthesize rowsArray;
@synthesize labelsArray;
@synthesize typesArray;
@synthesize headerAndFooterInfoArray;
@synthesize parent;


- (id) initWithTableStyle:(int)style
                yPosition:(float)yPos
         numberOfSections:(int)numOfS
           rowsInSections:(NSArray *)rowArray
         labelsInSections:(NSMutableArray *)labelArray
          typesInSections:(NSMutableArray *)typeArray
          headerAndFooter:(NSMutableArray *)headerAndFooterArray
          backgroundColor:(UIColor *)color
{
    
    CGRect frame = CGRectMake(0, 0, 320, 480);
    
    if (style == 0) {
        self = [super initWithFrame:frame
                              style:UITableViewStyleGrouped];
    }else if(style == 1){
        self = [super initWithFrame:frame
                              style:UITableViewStylePlain];
    }else {
        self = [super initWithFrame:frame
                              style:UITableViewStyleGrouped];
    }
    

    numberOfSections = numOfS;
    rowsArray = [[NSArray alloc] initWithArray:rowArray copyItems:YES];
    labelsArray = [[NSMutableArray alloc] initWithArray:labelArray copyItems:YES];
    typesArray = [[NSMutableArray alloc] initWithArray:typeArray copyItems:YES];
    headerAndFooterInfoArray = [[NSMutableArray alloc] initWithArray:headerAndFooterArray copyItems:YES];
    
    
    [self setDelegate:self];
    self.dataSource = self;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = color;
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger result = 0;
    if ([tableView isEqual:self]) {
        result =  numberOfSections;
    }
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section

{
    NSInteger result = 0;
    if ([tableView isEqual:self]) {
    NSNumber *rows = [rowsArray objectAtIndex:section]; 
        result = [rows integerValue];
    }
    
    return result;

}

- (UITableViewCell *)   tableView:(UITableView *)tableView 
            cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *result = nil;
    if([tableView isEqual:self]){
        static NSString *TabelViewCellIdentifier = @"MyCell";
        result = [tableView
                  dequeueReusableCellWithIdentifier:TabelViewCellIdentifier];
        
        if(result == nil){
            result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:TabelViewCellIdentifier];
        }
        
        id sectionArray = [labelsArray objectAtIndex:indexPath.section];
        id labelText = [sectionArray objectAtIndex:indexPath.row];
        
        //NSLog(@"what are you = %@", labelText);
        result.textLabel.text = labelText;
        
        NSNumber *accessoryType = [[typesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSInteger typeValue = [accessoryType integerValue];
        //NSLog(@"typeValue = %d", typeValue);
        switch (typeValue) {
            case 0:
                result.accessoryType = UITableViewCellAccessoryNone;
                break;
                
            case 1:
                result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            case 2:
                result.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                break;
                
            default:
                result.accessoryType = UITableViewCellAccessoryNone;
                break;
        }
        
    }
    
    return result;
}

//fire the cell selected event
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self]){
        NSLog(@"%@",
              [NSString stringWithFormat:@"Cell %ld in Section %ld is selected", (long)indexPath.row, (long)indexPath.section]);
        
       //NSLog(@"Switch is switchin!!! %d", [paramSender isOn]); 
        
        int section = indexPath.section;
        int row = indexPath.row;
        int index = 0;
        
        for (int s = 0; s < section; s ++) {
            for (int r = 0 ; r < [[rowsArray objectAtIndex:s] intValue]; r++ ) {
                index ++;
            }
        }
        
        index = index + row;
        ofLog() << "index = " << index;
        
        ofNotifyEvent(parent->cellSelected, index, parent);
    }
}


//delegate methods for header view and footer view
- (UIView *)    tableView:(UITableView *)tableView 
   viewForHeaderInSection:(NSInteger)section
{
    UIView *result = nil;
    
    if([tableView isEqual:self]){
        
        for (int i = 0; i < numberOfSections; i++) {
        
            id sectionArray = [headerAndFooterInfoArray  objectAtIndex:section];
            id headerText = [sectionArray objectAtIndex:0];
        
            if (headerText != @"") {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = headerText;
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                
                label.frame = CGRectMake(label.frame.origin.x + 10.0f, 
                                         5.0f, 
                                         label.frame.size.width, 
                                         label.frame.size.height);
                
                CGRect resultFrame = CGRectMake(0.0f, 
                                                0.0f, 
                                                label.frame.size.height,
                                                label.frame.size.width +10.0f);
                
                result = [[UIView alloc] initWithFrame:resultFrame];
                [result addSubview:label];
            }else {
                result = nil;
            }
        }
    }
    return result;
}

- (UIView *)    tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section
{
    UIView *result = nil;
    
    if([tableView isEqual:self]){
        
        for (int i = 0; i < numberOfSections; i++) {
            
            id sectionArray = [headerAndFooterInfoArray  objectAtIndex:section];
            id footerText = [sectionArray objectAtIndex:1];
            
            if (footerText != @"") {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = footerText;
                label.backgroundColor = [UIColor clearColor];
                [label sizeToFit];
                
                float centerX = (300 - label.frame.size.width)/2;
                
                label.frame = CGRectMake(label.frame.origin.x + centerX, 
                                         5.0f, 
                                         label.frame.size.width, 
                                         label.frame.size.height);
                
                CGRect resultFrame = CGRectMake(0.0f, 
                                                0.0f, 
                                                label.frame.size.height,
                                                label.frame.size.width +10.0f);
                
                result = [[UIView alloc] initWithFrame:resultFrame];
                [result addSubview:label];
            }else {
                result = nil;
            }
        }
    }
    return result;}


- (CGFloat)     tableView:(UITableView *)tableView 
 heightForHeaderInSection:(NSInteger)section
{
    CGFloat result = 0.0f;
    if([tableView isEqual:self]){
        for (int i = 0; i < numberOfSections; i++) {
            result = 30.f;
        }
    }
    return result;
}

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForFooterInSection:(NSInteger)section
{
    CGFloat result = 0.0f;
    if([tableView isEqual:self]){
        for (int i = 0; i < numberOfSections; i++) {
            result = 30.f;
        }
    }
    return result;
}



/*

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if ([tableView isEqual:self]){ 
        result = UITableViewCellEditingStyleDelete;
    }
    return result; 
}

- (void) setEditing:(BOOL)editing 
           animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self setEditing:editing animated:animated];
}

- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){ 
        if (indexPath.row < [self.arrayOfRows count]){
        // First remove this object from the source 
            [self.arrayOfRows removeObjectAtIndex:indexPath.row];
        // Then remove the associated cell from the Table View 
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

*/


iTableView::iTableView(iCellGroup *section1){
    
    disToTop = 0.0f;
    colorOfBackground = [UIColor clearColor];
    
    NSNumber *rowsInSection1 = [NSNumber numberWithInt:section1->numOfCells];
    rowsInSection = [[NSArray alloc] initWithObjects:rowsInSection1, nil];
    NSMutableArray *labelsInSection1 = [[NSMutableArray alloc] init];
    labelsInSections = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeInSection1 = [[NSMutableArray alloc] init];
    typeInSections = [[NSMutableArray alloc] init];
    
   
    
    
    for (int i = 0; i < section1->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section1->cellLabels[i]);
        [labelsInSection1 addObject:label];
        
        if (section1->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section1->accessoryTypes[i]];
            [typeInSection1 addObject:type];
            [type release];
            
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection1 addObject:type];
            [type release];
        }
        
        [label release];
        
    }
    
    numOfSections = 1;
    [labelsInSections addObject:labelsInSection1];
    [typeInSections addObject:typeInSection1];
    
    //header and footer in sections
    NSMutableArray *headerAndFooterInSection1 = [[NSMutableArray alloc] init];
    headerAndFooterInSections = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < 2; j++){
        NSString *infoS1 = ofxStringToNSString(section1->headerAndFooterInfo[j]);
        [headerAndFooterInSection1 addObject:infoS1];
        [infoS1 release];
    }
    [headerAndFooterInSections addObject: headerAndFooterInSection1];
    
    [rowsInSection1 release];
    [labelsInSection1 release];
    [typeInSection1 release];
    [headerAndFooterInSection1 release];
    
}

iTableView::iTableView(iCellGroup *section1, 
                       iCellGroup *section2){
    
    disToTop = 0.0f;
    colorOfBackground = [UIColor clearColor];
    
    NSNumber *rowsInSection1 = [NSNumber numberWithInt:section1->numOfCells];
    NSNumber *rowsInSection2 = [NSNumber numberWithInt:section2->numOfCells];
    rowsInSection = [[NSArray alloc] initWithObjects:rowsInSection1,
                                                     rowsInSection2, nil];
    
    NSMutableArray *labelsInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection2 = [[NSMutableArray alloc] init];
    labelsInSections = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection2 = [[NSMutableArray alloc] init];
    typeInSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < section1->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section1->cellLabels[i]); 
        [labelsInSection1 addObject:label];
        
        if (section1->isTypeDefined) {
           
            NSNumber *type = [NSNumber numberWithInt:section1->accessoryTypes[i]];
            [typeInSection1 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection1 addObject:type];
        }
        
    }
    
    for (int i = 0; i < section2->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section2->cellLabels[i]);
        [labelsInSection2 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section2->accessoryTypes[i]];
            [typeInSection2 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection2 addObject:type];
        }
        
    }
    
    numOfSections = 2;
    [labelsInSections addObject:labelsInSection1];
    [labelsInSections addObject:labelsInSection2];
    [typeInSections addObject:typeInSection1];
    [typeInSections addObject:typeInSection2];
    
    //header and footer in sections
    NSMutableArray *headerAndFooterInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection2 = [[NSMutableArray alloc] init];
    headerAndFooterInSections = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < 2; j++){
        NSString *infoS1 = ofxStringToNSString(section1->headerAndFooterInfo[j]);
        [headerAndFooterInSection1 addObject:infoS1];
        NSString *infoS2 = ofxStringToNSString(section2->headerAndFooterInfo[j]);
        [headerAndFooterInSection2 addObject:infoS2];
    }
    
    [headerAndFooterInSections addObject: headerAndFooterInSection1];
    [headerAndFooterInSections addObject: headerAndFooterInSection2]; 
    
    [rowsInSection1 release];
    [rowsInSection2 release];
    [labelsInSection1 release];
    [labelsInSection2 release];
    [typeInSection1 release];
    [typeInSection2 release];
    [headerAndFooterInSection1 release];
    [headerAndFooterInSection2 release];
    
    
}

iTableView::iTableView(iCellGroup *section1, iCellGroup *section2, iCellGroup *section3){
    
    disToTop = 0.0f;
    colorOfBackground = [UIColor clearColor];
    
    NSNumber *rowsInSection1 = [NSNumber numberWithInt:section1->numOfCells];
    NSNumber *rowsInSection2 = [NSNumber numberWithInt:section2->numOfCells];
    NSNumber *rowsInSection3 = [NSNumber numberWithInt:section3->numOfCells];
    rowsInSection = [[NSArray alloc] initWithObjects:rowsInSection1,
                                                     rowsInSection2,
                                                     rowsInSection3, nil];
    
    NSMutableArray *labelsInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection3 = [[NSMutableArray alloc] init];
    labelsInSections = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection3 = [[NSMutableArray alloc] init];
    typeInSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < section1->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section1->cellLabels[i]); 
        [labelsInSection1 addObject:label];
        
        if (section1->isTypeDefined) {
            
            NSNumber *type = [NSNumber numberWithInt:section1->accessoryTypes[i]];
            [typeInSection1 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection1 addObject:type];
        }
        
    }
    
    for (int i = 0; i < section2->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section2->cellLabels[i]);
        [labelsInSection2 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section2->accessoryTypes[i]];
            [typeInSection2 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection2 addObject:type];
        }
    }
    
    for (int i = 0; i < section3->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section3->cellLabels[i]);
        [labelsInSection3 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section3->accessoryTypes[i]];
            [typeInSection3 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection3 addObject:type];
        }
    }
    
    numOfSections = 3;
    [labelsInSections addObject:labelsInSection1];
    [labelsInSections addObject:labelsInSection2];
    [labelsInSections addObject:labelsInSection3];
    [typeInSections addObject:typeInSection1];
    [typeInSections addObject:typeInSection2];
    [typeInSections addObject:typeInSection3];
    
    //header and footer in sections
    NSMutableArray *headerAndFooterInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection3 = [[NSMutableArray alloc] init];
    headerAndFooterInSections = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < 2; j++){
        NSString *infoS1 = ofxStringToNSString(section1->headerAndFooterInfo[j]);
        [headerAndFooterInSection1 addObject:infoS1];
        NSString *infoS2 = ofxStringToNSString(section2->headerAndFooterInfo[j]);
        [headerAndFooterInSection2 addObject:infoS2];
        NSString *infoS3 = ofxStringToNSString(section3->headerAndFooterInfo[j]);
        [headerAndFooterInSection3 addObject:infoS3];
    }
    [headerAndFooterInSections addObject: headerAndFooterInSection1];
    [headerAndFooterInSections addObject: headerAndFooterInSection2]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection3]; 
    
    [rowsInSection1 release];
    [rowsInSection2 release];
    [rowsInSection3 release];
    [labelsInSection1 release];
    [labelsInSection2 release];
    [labelsInSection3 release];
    [typeInSection1 release];
    [typeInSection2 release];
    [typeInSection3 release];
    [headerAndFooterInSection1 release];
    [headerAndFooterInSection2 release];
    [headerAndFooterInSection3 release];


}

iTableView::iTableView(iCellGroup *section1, 
                       iCellGroup *section2, 
                       iCellGroup *section3, 
                       iCellGroup *section4){
    
    disToTop = 0.0f;
    colorOfBackground = [UIColor clearColor];
    
    NSNumber *rowsInSection1 = [NSNumber numberWithInt:section1->numOfCells];
    NSNumber *rowsInSection2 = [NSNumber numberWithInt:section2->numOfCells];
    NSNumber *rowsInSection3 = [NSNumber numberWithInt:section3->numOfCells];
    NSNumber *rowsInSection4 = [NSNumber numberWithInt:section4->numOfCells];
    rowsInSection = [[NSArray alloc] initWithObjects:rowsInSection1,
                                                     rowsInSection2,
                                                     rowsInSection3, 
                                                     rowsInSection4, nil];
    
    NSMutableArray *labelsInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection4 = [[NSMutableArray alloc] init];
    labelsInSections = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection4 = [[NSMutableArray alloc] init];
    typeInSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < section1->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section1->cellLabels[i]); 
        [labelsInSection1 addObject:label];
        
        if (section1->isTypeDefined) {
            
            NSNumber *type = [NSNumber numberWithInt:section1->accessoryTypes[i]];
            [typeInSection1 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection1 addObject:type];
        }
        
    }
    
    for (int i = 0; i < section2->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section2->cellLabels[i]);
        [labelsInSection2 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section2->accessoryTypes[i]];
            [typeInSection2 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection2 addObject:type];
        }
    }
    
    for (int i = 0; i < section3->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section3->cellLabels[i]);
        [labelsInSection3 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section3->accessoryTypes[i]];
            [typeInSection3 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection3 addObject:type];
        }
    }
    
    for (int i = 0; i < section4->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section4->cellLabels[i]);
        [labelsInSection4 addObject:label];
        
        if (section4->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section4->accessoryTypes[i]];
            [typeInSection4 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection4 addObject:type];
        }
    }
    
    numOfSections = 4;
    [labelsInSections addObject:labelsInSection1];
    [labelsInSections addObject:labelsInSection2];
    [labelsInSections addObject:labelsInSection3];
    [labelsInSections addObject:labelsInSection4];
    [typeInSections addObject:typeInSection1];
    [typeInSections addObject:typeInSection2];
    [typeInSections addObject:typeInSection3];
    [typeInSections addObject:typeInSection4];
    
    //header and footer in sections
    NSMutableArray *headerAndFooterInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection4 = [[NSMutableArray alloc] init];
    headerAndFooterInSections = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < 2; j++){
        NSString *infoS1 = ofxStringToNSString(section1->headerAndFooterInfo[j]);
        [headerAndFooterInSection1 addObject:infoS1];
        NSString *infoS2 = ofxStringToNSString(section2->headerAndFooterInfo[j]);
        [headerAndFooterInSection2 addObject:infoS2];
        NSString *infoS3 = ofxStringToNSString(section3->headerAndFooterInfo[j]);
        [headerAndFooterInSection3 addObject:infoS3];
        NSString *infoS4 = ofxStringToNSString(section4->headerAndFooterInfo[j]);
        [headerAndFooterInSection4 addObject:infoS4];
    }
    
    [headerAndFooterInSections addObject: headerAndFooterInSection1];
    [headerAndFooterInSections addObject: headerAndFooterInSection2]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection3]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection4]; 
    
    [rowsInSection1 release];
    [rowsInSection2 release];
    [rowsInSection3 release];
    [rowsInSection4 release];
    [labelsInSection1 release];
    [labelsInSection2 release];
    [labelsInSection3 release];
    [labelsInSection4 release];
    [typeInSection1 release];
    [typeInSection2 release];
    [typeInSection3 release];
    [typeInSection4 release];
    [headerAndFooterInSection1 release];
    [headerAndFooterInSection2 release];
    [headerAndFooterInSection3 release];
    [headerAndFooterInSection4 release];
    
    
}

iTableView::iTableView(iCellGroup *section1, 
                       iCellGroup *section2, 
                       iCellGroup *section3, 
                       iCellGroup *section4,
                       iCellGroup *section5){
    
    disToTop = 0.0f;
    colorOfBackground = [UIColor clearColor];
    
    NSNumber *rowsInSection1 = [NSNumber numberWithInt:section1->numOfCells];
    NSNumber *rowsInSection2 = [NSNumber numberWithInt:section2->numOfCells];
    NSNumber *rowsInSection3 = [NSNumber numberWithInt:section3->numOfCells];
    NSNumber *rowsInSection4 = [NSNumber numberWithInt:section4->numOfCells];
    NSNumber *rowsInSection5 = [NSNumber numberWithInt:section5->numOfCells];
    rowsInSection = [[NSArray alloc] initWithObjects:rowsInSection1,
                                                     rowsInSection2,
                                                     rowsInSection3, 
                                                     rowsInSection4, 
                                                     rowsInSection5, nil];
    
    NSMutableArray *labelsInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection4 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection5 = [[NSMutableArray alloc] init];
    labelsInSections = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection4 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection5 = [[NSMutableArray alloc] init];
    typeInSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < section1->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section1->cellLabels[i]); 
        [labelsInSection1 addObject:label];
        
        if (section1->isTypeDefined) {
            
            NSNumber *type = [NSNumber numberWithInt:section1->accessoryTypes[i]];
            [typeInSection1 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection1 addObject:type];
        }
        
    }
    
    for (int i = 0; i < section2->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section2->cellLabels[i]);
        [labelsInSection2 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section2->accessoryTypes[i]];
            [typeInSection2 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection2 addObject:type];
        }
    }
    
    for (int i = 0; i < section3->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section3->cellLabels[i]);
        [labelsInSection3 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section3->accessoryTypes[i]];
            [typeInSection3 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection3 addObject:type];
        }
    }
    
    for (int i = 0; i < section4->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section4->cellLabels[i]);
        [labelsInSection4 addObject:label];
        
        if (section4->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section4->accessoryTypes[i]];
            [typeInSection4 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection4 addObject:type];
        }
    }
    
    for (int i = 0; i < section5->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section5->cellLabels[i]);
        [labelsInSection5 addObject:label];
        
        if (section4->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section5->accessoryTypes[i]];
            [typeInSection5 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection5 addObject:type];
        }
    }
    
    numOfSections = 5;
    [labelsInSections addObject:labelsInSection1];
    [labelsInSections addObject:labelsInSection2];
    [labelsInSections addObject:labelsInSection3];
    [labelsInSections addObject:labelsInSection4];
    [labelsInSections addObject:labelsInSection5];
    [typeInSections addObject:typeInSection1];
    [typeInSections addObject:typeInSection2];
    [typeInSections addObject:typeInSection3];
    [typeInSections addObject:typeInSection4];
    [typeInSections addObject:typeInSection5];
    
    //header and footer in sections
    NSMutableArray *headerAndFooterInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection4 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection5 = [[NSMutableArray alloc] init];
    headerAndFooterInSections = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < 2; j++){
        NSString *infoS1 = ofxStringToNSString(section1->headerAndFooterInfo[j]);
        [headerAndFooterInSection1 addObject:infoS1];
        NSString *infoS2 = ofxStringToNSString(section2->headerAndFooterInfo[j]);
        [headerAndFooterInSection2 addObject:infoS2];
        NSString *infoS3 = ofxStringToNSString(section3->headerAndFooterInfo[j]);
        [headerAndFooterInSection3 addObject:infoS3];
        NSString *infoS4 = ofxStringToNSString(section4->headerAndFooterInfo[j]);
        [headerAndFooterInSection4 addObject:infoS4];
        NSString *infoS5 = ofxStringToNSString(section5->headerAndFooterInfo[j]);
        [headerAndFooterInSection5 addObject:infoS5];
    }
    
    [headerAndFooterInSections addObject: headerAndFooterInSection1];
    [headerAndFooterInSections addObject: headerAndFooterInSection2]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection3]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection4];
    [headerAndFooterInSections addObject: headerAndFooterInSection5];
    
    [rowsInSection1 release];
    [rowsInSection2 release];
    [rowsInSection3 release];
    [rowsInSection4 release];
    [rowsInSection5 release];
    [labelsInSection1 release];
    [labelsInSection2 release];
    [labelsInSection3 release];
    [labelsInSection4 release];
    [labelsInSection5 release];
    [typeInSection1 release];
    [typeInSection2 release];
    [typeInSection3 release];
    [typeInSection4 release];
    [typeInSection5 release];
    [headerAndFooterInSection1 release];
    [headerAndFooterInSection2 release];
    [headerAndFooterInSection3 release];
    [headerAndFooterInSection4 release];
    [headerAndFooterInSection5 release];
}

iTableView::iTableView(iCellGroup *section1, 
                       iCellGroup *section2, 
                       iCellGroup *section3, 
                       iCellGroup *section4,
                       iCellGroup *section5,
                       iCellGroup *section6){
    
    disToTop = 0.0f;
    colorOfBackground = [UIColor clearColor];
    
    NSNumber *rowsInSection1 = [NSNumber numberWithInt:section1->numOfCells];
    NSNumber *rowsInSection2 = [NSNumber numberWithInt:section2->numOfCells];
    NSNumber *rowsInSection3 = [NSNumber numberWithInt:section3->numOfCells];
    NSNumber *rowsInSection4 = [NSNumber numberWithInt:section4->numOfCells];
    NSNumber *rowsInSection5 = [NSNumber numberWithInt:section5->numOfCells];
    NSNumber *rowsInSection6 = [NSNumber numberWithInt:section6->numOfCells];
    rowsInSection = [[NSArray alloc] initWithObjects:rowsInSection1,
                     rowsInSection2,
                     rowsInSection3, 
                     rowsInSection4, 
                     rowsInSection5, 
                     rowsInSection6, nil];
    
    NSMutableArray *labelsInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection4 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection5 = [[NSMutableArray alloc] init];
    NSMutableArray *labelsInSection6 = [[NSMutableArray alloc] init];
    labelsInSections = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection4 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection5 = [[NSMutableArray alloc] init];
    NSMutableArray *typeInSection6 = [[NSMutableArray alloc] init];
    typeInSections = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < section1->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section1->cellLabels[i]); 
        [labelsInSection1 addObject:label];
        
        if (section1->isTypeDefined) {
            
            NSNumber *type = [NSNumber numberWithInt:section1->accessoryTypes[i]];
            [typeInSection1 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection1 addObject:type];
        }
        
    }
    
    for (int i = 0; i < section2->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section2->cellLabels[i]);
        [labelsInSection2 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section2->accessoryTypes[i]];
            [typeInSection2 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection2 addObject:type];
        }
    }
    
    for (int i = 0; i < section3->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section3->cellLabels[i]);
        [labelsInSection3 addObject:label];
        
        if (section2->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section3->accessoryTypes[i]];
            [typeInSection3 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection3 addObject:type];
        }
    }
    
    for (int i = 0; i < section4->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section4->cellLabels[i]);
        [labelsInSection4 addObject:label];
        
        if (section4->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section4->accessoryTypes[i]];
            [typeInSection4 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection4 addObject:type];
        }
    }
    
    for (int i = 0; i < section5->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section5->cellLabels[i]);
        [labelsInSection5 addObject:label];
        
        if (section5->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section5->accessoryTypes[i]];
            [typeInSection5 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection5 addObject:type];
        }
    }
    
    for (int i = 0; i < section6->numOfCells; i++) {
        NSString *label =ofxStringToNSString(section6->cellLabels[i]);
        [labelsInSection6 addObject:label];
        
        if (section6->isTypeDefined) {
            NSNumber *type = [NSNumber numberWithInt:section6->accessoryTypes[i]];
            [typeInSection6 addObject:type];
        }else {
            NSNumber *type = [NSNumber numberWithInt:0];
            [typeInSection6 addObject:type];
        }
    }
    
    numOfSections = 5;
    [labelsInSections addObject:labelsInSection1];
    [labelsInSections addObject:labelsInSection2];
    [labelsInSections addObject:labelsInSection3];
    [labelsInSections addObject:labelsInSection4];
    [labelsInSections addObject:labelsInSection5];
    [labelsInSections addObject:labelsInSection6];
    [typeInSections addObject:typeInSection1];
    [typeInSections addObject:typeInSection2];
    [typeInSections addObject:typeInSection3];
    [typeInSections addObject:typeInSection4];
    [typeInSections addObject:typeInSection5];
    [typeInSections addObject:typeInSection6];
    
    //header and footer in sections
    NSMutableArray *headerAndFooterInSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection2 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection3 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection4 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection5 = [[NSMutableArray alloc] init];
    NSMutableArray *headerAndFooterInSection6 = [[NSMutableArray alloc] init];
    headerAndFooterInSections = [[NSMutableArray alloc] init];
    
    for(int j = 0; j < 2; j++){
        NSString *infoS1 = ofxStringToNSString(section1->headerAndFooterInfo[j]);
        [headerAndFooterInSection1 addObject:infoS1];
        NSString *infoS2 = ofxStringToNSString(section2->headerAndFooterInfo[j]);
        [headerAndFooterInSection2 addObject:infoS2];
        NSString *infoS3 = ofxStringToNSString(section3->headerAndFooterInfo[j]);
        [headerAndFooterInSection3 addObject:infoS3];
        NSString *infoS4 = ofxStringToNSString(section4->headerAndFooterInfo[j]);
        [headerAndFooterInSection4 addObject:infoS4];
        NSString *infoS5 = ofxStringToNSString(section5->headerAndFooterInfo[j]);
        [headerAndFooterInSection5 addObject:infoS5];
        NSString *infoS6 = ofxStringToNSString(section6->headerAndFooterInfo[j]);
        [headerAndFooterInSection6 addObject:infoS6];
    }
    
    [headerAndFooterInSections addObject: headerAndFooterInSection1];
    [headerAndFooterInSections addObject: headerAndFooterInSection2]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection3]; 
    [headerAndFooterInSections addObject: headerAndFooterInSection4];
    [headerAndFooterInSections addObject: headerAndFooterInSection5];
    [headerAndFooterInSections addObject: headerAndFooterInSection6];
    
    [rowsInSection1 release];
    [rowsInSection2 release];
    [rowsInSection3 release];
    [rowsInSection4 release];
    [rowsInSection5 release];
    [rowsInSection6 release];
    [labelsInSection1 release];
    [labelsInSection2 release];
    [labelsInSection3 release];
    [labelsInSection4 release];
    [labelsInSection5 release];
    [labelsInSection6 release];
    [typeInSection1 release];
    [typeInSection2 release];
    [typeInSection3 release];
    [typeInSection4 release];
    [typeInSection5 release];
    [typeInSection6 release];
    [headerAndFooterInSection1 release];
    [headerAndFooterInSection2 release];
    [headerAndFooterInSection3 release];
    [headerAndFooterInSection4 release];
    [headerAndFooterInSection5 release];
    [headerAndFooterInSection6 release];
}

void  iTableView::setDistanceToTop(float distance){
    
    if (distance >= 0) {
        disToTop = distance;
    }
}

void  iTableView::setTableStyle(TABLE_STYLE style){
    
    if (style == GROUPED || style == PLAIN) {
        styleOfTable = style;
    }else {
        styleOfTable = GROUPED;
    }
}

void  iTableView::setBackground(int r, int g, int b, int a){
    
    colorOfBackground = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                        green:ofClamp(g, 0, 255)/255.0f 
                                         blue:ofClamp(b, 0, 255)/255.0f 
                                        alpha:ofClamp(a, 0, 255)/255.0f];
      
}

iTableView::~iTableView(){
    
    
}

void iTableView::setBackground(PREDEFINED_BACKGROUND background){
    
    switch (background) {
        case 0:
            colorOfBackground = [UIColor whiteColor];
            break;
            
        case 1:
            colorOfBackground = [UIColor blackColor];
            break;
            
        case 2:
            colorOfBackground = [UIColor clearColor];
            break;
            
        case 3:
            colorOfBackground = [UIColor groupTableViewBackgroundColor];
            break;
            
        case 4:
            colorOfBackground = [UIColor scrollViewTexturedBackgroundColor];
            break;
            
        default:
            colorOfBackground = [UIColor clearColor];
            break;
    }
    
}

void iTableView::setBackgroundImage(string imageName){
    
    colorOfBackground = [UIColor colorWithPatternImage:[UIImage imageNamed:ofxStringToNSString(imageName)]];
}

void iTableView::addToView(iViewController *iView){
    
    myTableView = [[ocTableView alloc] initWithTableStyle:styleOfTable
                                                yPosition:disToTop
                                         numberOfSections:numOfSections
                                           rowsInSections:rowsInSection
                                         labelsInSections:labelsInSections
                                          typesInSections:typeInSections
                                          headerAndFooter:headerAndFooterInSections 
                                          backgroundColor:colorOfBackground]; 
    myTableView.parent = this;
    
    [iView->myView.view addSubview:myTableView];
}

@end
