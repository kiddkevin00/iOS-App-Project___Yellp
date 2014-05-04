//
//  ViewController.h
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *type;
@property (nonatomic) double radius;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) NSMutableArray *resultList;

@end
