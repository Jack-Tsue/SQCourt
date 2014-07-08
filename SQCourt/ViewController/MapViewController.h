//
//  MapViewController.h
//  SQCourt
//
//  Created by Jack on 11/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@end
