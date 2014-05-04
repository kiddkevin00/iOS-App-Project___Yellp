//
//  InfoViewController.h
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface InfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *locationField;
@property (weak, nonatomic) IBOutlet UILabel *typeFeild;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSNumber *index;
@property (strong, nonatomic) NSDictionary *info;

@end
