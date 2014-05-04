//
//  InfoViewController.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//
#import "Bookmark.h"
#import "InfoViewController.h"
#import "BMViewController.h"

@implementation InfoViewController
@synthesize info, context, rate, price,name,locationField,typeFeild,imageV;
- (IBAction)markedButton:(UIButton *)sender {
    // set state
    [sender setTitle:@"Marked" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [sender setEnabled:NO];
    
    // add the tuple to the database
    Bookmark *newItem = (Bookmark*)[NSEntityDescription insertNewObjectForEntityForName:@"Bookmark" inManagedObjectContext:context];
    
    [newItem setValue:info[@"name"] forKey:@"name"];
    [newItem setValue:info[@"vicinity"] forKey:@"location"];
    [newItem setValue:info[@"icon"] forKey:@"imageUrl"];
    
    NSString *type = [[NSString alloc] initWithFormat:@""];
    
    // the type list:
    for(id re in info[@"types"]){
        NSString *tmp = [[NSString alloc] initWithFormat:@"%@",re];
        type = [type stringByAppendingString:tmp];
        type = [type stringByAppendingString:@", "];
    }
    type = [type substringToIndex:[type length] - 2];
    [newItem setValue:type forKey:@"type"];
    
    
    NSDictionary *geo = info[@"geometry"];
    NSDictionary *location = geo[@"location"];
    
    double lat = [location[@"lat"] doubleValue];
    double lon = [location[@"lng"] doubleValue];
    [newItem setValue:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [newItem setValue:[NSNumber numberWithDouble:lon] forKey:@"lng"];
    
    NSError *err = nil;
    [context save:&err];
    
    // reload data: ####
    BMViewController *bookmarkVC = [[[self.tabBarController.viewControllers objectAtIndex:2] viewControllers] objectAtIndex:0];
    
    //reload modified Data
    [bookmarkVC initForContext];
    [bookmarkVC loadData];
    [bookmarkVC.myTableview reloadData];
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
    
    name.text = info[@"name"];
    locationField.text = info[@"vicinity"];
    
    
    rate.text = [NSString stringWithFormat:@"%3.2f", [info[@"rating"] floatValue]];
    
    price.text = [NSString stringWithFormat:@"%3.2f", [info[@"price_level"] floatValue]];
    
    // types
    NSString *type = [[NSString alloc] initWithFormat:@""];
    for(id re in info[@"types"]){
        NSString *tmp = [[NSString alloc] initWithFormat:@"%@", re];
        type = [type stringByAppendingString:tmp];
        type = [type stringByAppendingString:@", "];
    }
    
    type = [type substringToIndex:[type length] - 2];
    typeFeild.text = type;
    
    // photo reference
    NSString *pngAddress = info[@"icon"];
    
    NSURL *url = [[NSURL alloc] initWithString:pngAddress];
    NSData * data = [[NSData alloc] initWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData:data];
    imageV.image = image;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
