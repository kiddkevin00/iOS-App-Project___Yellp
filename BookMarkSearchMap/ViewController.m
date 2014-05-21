//
//  ViewController.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//
@import MapKit;
#import <COMSMapManager/COMSMapManager.h>
#import "ViewController.h"
#import "Annotation.h"
#import "AnotherViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong,nonatomic)CLLocationManager *manager;
@property (nonatomic) CLLocationCoordinate2D cur;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[CLLocationManager alloc]init];
	self.manager.delegate = self;
    self.map.delegate = self;
    
    self.resultList = [[NSMutableArray alloc] init];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.map showsUserLocation];
    [self.manager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.cur = ((CLLocation *)locations[0]).coordinate;
    NSLog(@"User location updated, current locaiton:\nlat: %f, lng: %f\n", self.cur.latitude, self.cur.longitude);
    [self.manager stopUpdatingLocation];
    [GoogleMapManager nearestVenuesForLatLong:self.cur withinRadius:self.radius forQuery:self.name queryType:self.type  googleMapsAPIKey:@" PLEASE_ENTER_YOUR_GOOGLE_MAP_API_KEY " searchCompletion:^(NSMutableArray *results)
     {
         if ([results count] != 0) {
             [self.resultList addObjectsFromArray:results];
             NSLog(@"results: %@",results);
             NSLog(@"resultsList: %@",self.resultList);
             // Extract infos from results
             NSLog(@"We've found : ");
             
             AnotherViewController *listView = [[[self.tabBarController.viewControllers objectAtIndex:1] viewControllers]objectAtIndex:0];
             listView.list = [[NSMutableArray alloc] init];
             [listView.list addObjectsFromArray:results];
             
             [listView.myTableView reloadData];
             
             for(id entry in results)    {
                 NSLog(@"%@",entry);
                 NSDictionary *dicEntry = entry;
                 NSDictionary *geometry = dicEntry[@"geometry"];
                 NSDictionary *location = geometry[@"location"];
                 NSString *name = dicEntry[@"name"];
                 //NSString *vicinity = dicEntry[@"vicinity"];
                 double lat = [location[@"lat"] doubleValue];
                 double lng = [location[@"lng"] doubleValue];
                 NSLog(@"%@, which is at ( %f, %f ) ", name,lat,lng);
                 //CLLocationCoordinate2D newCoordinate;
                 //newCoordinate.latitude = lat;
                 //newCoordinate.longitude = lng;
                 Annotation *annotation = [[Annotation alloc] init];
                 annotation.lat =lat;
                 annotation.lng =lng;
                 
                 [self.map addAnnotation:annotation];
                 [self.map showAnnotations:self.map.annotations animated:YES];
                 
             }
             
            
             self.status.text = [NSString stringWithFormat:@"  Here's the results you want !!"];
             
         }else{
             NSLog(@"Nothing found");
             self.status.text = [NSString stringWithFormat:@"  Sorry,There is Nothing found !!"];
         }
     }];
    
}

    
@end
