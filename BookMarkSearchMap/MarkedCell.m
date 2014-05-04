//
//  MarkedCell.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import "MarkedCell.h"

@implementation MarkedCell
@synthesize index, context, imageview, item, deleteButton;

- (IBAction)deleteBookmark:(UIButton *)sender
{
    
    NSLog(@"deleted");
    NSLog(@"d : %d", index);
    
    UITableView *uitv = (UITableView *)self.superview.superview;
    
    // I used 2 superview because
    // self.superview is UITableViewWrapperView
    // the UITableViewWrapperView.superview is UITableView
    
    //    NSString *className = NSStringFromClass([self.superview class]);
    //    NSLog(@"%@", className);
    
    
    BMViewController *bvc = (BMViewController*)(uitv.dataSource);
    [bvc.dataSource removeObjectAtIndex:index];
    
    [bvc.myTableview reloadData];
    
    NSEntityDescription *entDes = [NSEntityDescription entityForName:@"Bookmark" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entDes];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like '*'"];
    [request setPredicate:predicate];
    
    
    NSError *err;
    NSArray *matchingData = [context executeFetchRequest:request error:&err];
    
    NSManagedObject *obj = [matchingData objectAtIndex:index];
    [context deleteObject:obj];
    [context save:&err];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Do your custom initialization here
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        context = [appDelegate managedObjectContext];
        NSLog(@"init cell!!");
    }
    return self;
}




@end

