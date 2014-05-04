//
//  BMViewController.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import "BMViewController.h"

@interface BMViewController ()

@end

@implementation BMViewController
@synthesize myTableview, context, dataSource;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MarkedCell";
    MarkedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        cell = [[MarkedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dict =[dataSource objectAtIndex:indexPath.row];
    cell.nameLabel.text = dict[@"name"];
    cell.locationLabel.text = dict[@"vicinity"];
    cell.item = dict;
    
    cell.index = (int)indexPath.item;
    
    NSString *pngAddress = dict[@"icon"];
    
    
    NSURL *url = [[NSURL alloc] initWithString:pngAddress];
    NSData * data = [[NSData alloc] initWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageview.image = image;
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myTableview.dataSource = self;
    myTableview.delegate = self;
    
    // core data
    dataSource = [[NSMutableArray alloc] init];
    [self initForContext];
    [self loadData];
    [myTableview reloadData];
    
    
}

-(void)initForContext{
    if(context == nil){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        context = [appDelegate managedObjectContext];
    }
}

- (void) loadData{
    [dataSource removeAllObjects];
    
    NSEntityDescription * entDes = [NSEntityDescription entityForName:@"Bookmark" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entDes];
    
    NSString *query2 = [NSString stringWithFormat:@"name like '*'"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query2];
    [request setPredicate:predicate];
    
    NSError *err;
    NSArray * matchingData = [context executeFetchRequest:request error:&err];
    
    //
    NSLog(@"count : %d", (int)matchingData.count);
    
    if(matchingData.count <= 0){
        NSLog(@"not found!");
    }else{
        
        for (NSManagedObject *obj in matchingData) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            NSString *name = [obj valueForKey:@"name"];
            NSString *location = [obj valueForKey:@"location"];
            NSString *imgurl = [obj valueForKey:@"imageUrl"];
            
            NSString *types = [obj valueForKey:@"type"];
            NSArray *typeList = [types componentsSeparatedByString:@", "];
            
            NSNumber *lat = [obj valueForKey:@"lat"];
            NSNumber *lng = [obj valueForKey:@"lng"];
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
            [dic1 setObject:lat forKey:@"lat"];
            [dic1 setObject:lng forKey:@"lng"];
            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
            [dic2 setObject:dic1 forKey:@"location"];
            
            
            [dic setObject:name forKey:@"name"];
            [dic setObject:location forKey:@"vicinity"];
            [dic setObject:imgurl forKey:@"icon"];
            [dic setObject:typeList forKey:@"types"];
            [dic setObject:dic2 forKey:@"geometry"];
            
            [dataSource addObject:dic];
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
