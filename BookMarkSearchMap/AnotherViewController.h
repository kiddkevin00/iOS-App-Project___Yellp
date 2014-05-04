//
//  AnotherViewController.h
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import <CoreLocation/CoreLocation.h>

@interface AnotherViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *list;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end
