/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocTableView.h
 *
 * Created by Wang Yufan on 8/2/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

class iTableView;

@interface ocTableView : UITableView<UITableViewDelegate,UITableViewDataSource>{

    int numberOfSections;
    NSArray* rowsArray;
    NSMutableArray *labelsArray;
    NSMutableArray *typesArray;
    NSMutableArray *headerAndFooterInfoArray;
    iTableView *parent;
}

@property(nonatomic)int numberOfSections;
@property(nonatomic, strong)NSArray *rowsArray;
@property(nonatomic, strong)NSMutableArray *labelsArray;
@property(nonatomic, strong)NSMutableArray *typesArray;
@property(nonatomic, strong)NSMutableArray *headerAndFooterInfoArray;
@property(nonatomic) iTableView *parent;

//@property(nonatomic, strong)UITableView *myTableView;
- (id) initWithTableStyle:(int)style
                yPosition:(float)yPos
         numberOfSections:(int)numOfS
           rowsInSections:(NSArray *)rowArray
         labelsInSections:(NSMutableArray *)labelArray
          typesInSections:(NSMutableArray *)typeArray
          headerAndFooter:(NSMutableArray *)headerAndFooterArray 
          backgroundColor:(UIColor *)color;

@end
