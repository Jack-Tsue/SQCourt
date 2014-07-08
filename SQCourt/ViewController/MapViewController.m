//
//  MapViewController.m
//  SQCourt
//
//  Created by Jack on 11/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    [_mapView setDelegate:self];
    //设置地图中心
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 33.9608565991f;
    coordinate.longitude = 118.2634449005f;
    
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = coordinate;
    [ann setTitle:@"宿迁市中级人民法院"];
    [ann setSubtitle:@"江苏省宿迁市宿城区洪泽湖路135号"];
    //触发viewForAnnotation
    [_mapView addAnnotation:ann];
    
    MKCoordinateRegion region;
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    region.center = coordinate;
    // 设置显示位置(动画)
    [_mapView setRegion:region animated:YES];
    // 设置地图显示的类型及根据范围进行显示
    [_mapView regionThatFits:region];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
