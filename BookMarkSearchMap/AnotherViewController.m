//
//  AnotherViewController.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import "AnotherViewController.h"
#import "InfoViewController.h"

@interface AnotherViewController ()

@end

@implementation AnotherViewController
@synthesize list, myTableView;


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"myCell";
    Cell *theCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!theCell){
        theCell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dict =[list objectAtIndex:indexPath.row];
    theCell.name.text = dict[@"name"];
    theCell.location.text = dict[@"vicinity"];
    theCell.item = dict;
    theCell.index = (int)indexPath.item;

    
    NSString *pngAddress = dict[@"icon"];
    NSURL *url = [[NSURL alloc] initWithString:pngAddress];
    NSData * data = [[NSData alloc] initWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData:data];
    theCell.image.image = image;
    return theCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myTableView.dataSource = self;
    myTableView.delegate = self;
   
    UIColor *backimage = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"image.jpg"]];
    self.view.backgroundColor = backimage;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"info"])  {
        InfoViewController *destination = segue.destinationViewController;
        
        NSIndexPath *index = [self.myTableView indexPathForSelectedRow];
        
        // pass the info the the DetailViewController
        destination.info = [list objectAtIndex:index.row];
        destination.index = [NSNumber numberWithInt:(int)index.row];
        
    }
    
}





@end
