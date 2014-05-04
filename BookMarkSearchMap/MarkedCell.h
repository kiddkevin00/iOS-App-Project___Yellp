//
//  MarkedCell.h
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMViewController.h"
#import "AppDelegate.h"

@interface MarkedCell : UITableViewCell

// core data
@property (atomic) int index;
@property (strong, nonatomic) NSDictionary *item;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (IBAction)deleteBookmark:(UIButton *)sender;

@end
