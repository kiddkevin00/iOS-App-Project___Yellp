//
//  BMViewController.h
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MarkedCell.h"


@interface BMViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *myTableview;
// core data
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSMutableArray *dataSource;

-(void)loadData;
-(void)initForContext;

@end
