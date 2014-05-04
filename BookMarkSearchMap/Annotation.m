//
//  Annotation.m
//  BookMarkSearchMap
//
//  Created by MENG-YI HSU on 4/7/14.
//  Copyright (c) 2014 Marcus. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation


-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D C;
    C.latitude = self.lat;
    C.longitude = self.lng;
    return C;
}

@end
