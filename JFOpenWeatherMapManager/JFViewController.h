//
//  JFViewController.h
//  JFOpenWeatherMapManager
//
//  Created by Jonathan Field on 27/10/2013.
//  Copyright (c) 2013 Jonathan Field. All rights reserved.
//  http://jonathanfield.me
//  https://github.com/jfield44/JFOpenWeatherMapManager

/*
 This view controller provides a rough and ready example implementation of how to use JFOpenWeatherMapManager. The example consists of a mapview that on when a pin is dropped, will
 print out the local weather data for that latitude and latitude, once this has completed it will be displayed in the tableview below.
 */

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JFWeatherData.h"
#import "JFWeatherManager.h"
#import "DataModels.h"

@interface JFViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    JFWeatherManager *weatherManager;
    NSMutableArray *tableViewContents;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)addGestureRecogniserToMapView;
- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer;

@end
