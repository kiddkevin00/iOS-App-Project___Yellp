//
//  ViewController.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//
@import MapKit;
#import <COMSMapManager/COMSMapManager.h>
//#import "AnnotationDelegate.h"
#import "ViewController.h"
#import "Annotation.h"
#import "AnotherViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong,nonatomic)CLLocationManager *manager;
@property (nonatomic) CLLocationCoordinate2D cur;

//@property(nonatomic) MKCoordinateRegion region;
//@property (nonatomic, strong) NSMutableArray* resultData;
@end

@implementation ViewController
//@synthesize manager,map,region,cur,resultData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[CLLocationManager alloc]init];
	self.manager.delegate = self;
    self.map.delegate = self;
    
    self.resultList = [[NSMutableArray alloc] init];
    
    
    //self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //[self.manager startUpdatingLocation];
    
    //    region.center.latitude = 40.748647;
    //    region.center.longitude = -73.984726;
    //
    //
    //    map.mapType = MKMapTypeStandard;
    //    map.zoomEnabled = YES;
    //    MKCoordinateSpan span;
    //    span.latitudeDelta = .1;
    //    span.longitudeDelta = .1;
    //    region.span =span;
    //    [map setRegion:region animated:YES];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.map showsUserLocation];
    [self.manager startUpdatingLocation];
    
}

//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"location mananger error : %@", error);
//}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.cur = ((CLLocation *)locations[0]).coordinate;
    NSLog(@"User location updated, current locaiton:\nlat: %f, lng: %f\n", self.cur.latitude, self.cur.longitude);
    [self.manager stopUpdatingLocation];
    [GoogleMapManager nearestVenuesForLatLong:self.cur withinRadius:self.radius forQuery:self.name queryType:self.type  googleMapsAPIKey:@" PLEASE_ENTER_YOUR_API_KEY_HERE " searchCompletion:^(NSMutableArray *results)
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
                 //AnnotationDelegate * annotation = [[AnnotationDelegate alloc] initWithLocation:newCoordinate];
                 // annotation.title = name;
                 //annotation.subtiltle = vicinity;
                 
                 //[resultData addObject:annotation];
                 
                 
             }
             
             // Send tasks to UI thread to relfect immediate update of UI
             //[self performSelectorOnMainThread:@selector(addAnnotationsToMap:) withObject:resultData waitUntilDone:true];
             self.status.text = [NSString stringWithFormat:@"  Here's the results you want !!"];
             
         }else{
             NSLog(@"Nothing found");
             self.status.text = [NSString stringWithFormat:@"  Sorry,There is Nothing found !!"];
         }
     }];
    
    
    
    //NSLog(@"LocationManager callback : %@", locations);
    
    //[self performSearch];
    //if([locations[0] isKindOfClass:[CLLocation class]]){
    // [self.manager stopUpdatingLocation];
    //cur = ((CLLocation *)locations[0]).coordinate;
    //	region.center.latitude = 40.748647;
    //	region.center.longitude = -73.984726;
    
    //        cur = region.center ;
    //
    //        map.mapType = MKMapTypeStandard;
    //        map.zoomEnabled = YES;
    //        MKCoordinateSpan span;
    //        span.latitudeDelta = .1;
    //        span.longitudeDelta = .1;
    //        region.span =span;
    //        [map setRegion:region animated:YES];
    
    
    
    
    //}
    
}
/*
 - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation{
 //Declare annotation view
 NSLog(@"Calling for pinView for %@", annotation);
 MKPinAnnotationView* aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationDelegate"];
 aView.canShowCallout = YES;
 //aView.centerOffset = CGPointMake(10, -20);
 return aView;
 
 
 }
 */

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"list"])  {
//        
//        AnotherViewController *dest = segue.destinationViewController;
//        
//        dest.list = [[NSMutableArray alloc] init];
//        [dest.list addObjectsFromArray:self.resultList];
//        NSLog(@"list: %@",self.resultList);
//    }
//}

@end
