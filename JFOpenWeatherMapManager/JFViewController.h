//
//  JFViewController.h
//  JFOpenWeatherMapManager
//
//  Created by Jonathan Field on 27/10/2013.
//  Copyright (c) 2013 Jonathan Field. All rights reserved.
//

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
