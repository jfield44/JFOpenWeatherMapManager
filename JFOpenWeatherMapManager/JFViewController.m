//
//  JFViewController.m
//  JFOpenWeatherMapManager
//
//  Created by Jonathan Field on 27/10/2013.
//  Copyright (c) 2013 Jonathan Field. All rights reserved.
//

#import "JFViewController.h"

static NSString *API_KEY = @"YOUR_API_KEY_HERE";

@interface JFViewController ()

@end

@implementation JFViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    tableViewContents = [[NSMutableArray alloc]initWithCapacity:15];
    
    for (NSInteger i=0; i<15; i++) {
        [tableViewContents addObject:@"TBC"];
    }
    
	[self.mapView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.mapView setShowsUserLocation:TRUE];
    [self addGestureRecogniserToMapView];
    
    weatherManager = [[JFWeatherManager alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch ([indexPath row]) {
        case 0:
            [cell.textLabel setText:@"Latitude"];
            break;
            
        case 1:
            [cell.textLabel setText:@"Longitude"];
            break;
            
        case 2:
            [cell.textLabel setText:@"Conditions"];
            break;
            
        case 3:
            [cell.textLabel setText:@"Temperature (°C)"];
            break;
            
        case 4:
            [cell.textLabel setText:@"Sunrise"];
            break;
            
        case 5:
            [cell.textLabel setText:@"Sunset"];
            break;
            
        case 6:
            [cell.textLabel setText:@"Hours of Day Light"];
            break;
            
        case 7:
            [cell.textLabel setText:@"Humidity"];
            break;
            
        case 8:
            [cell.textLabel setText:@"Pressure (hPA)"];
            break;
            
        case 9:
            [cell.textLabel setText:@"Wind Speed (MPH)"];
            break;
            
        case 10:
            [cell.textLabel setText:@"Wind Direction"];
            break;
            
        case 11:
            [cell.textLabel setText:@"Cloud Coverage"];
            break;
            
        case 12:
            [cell.textLabel setText:@"Rain"];
            break;
            
        case 13:
            [cell.textLabel setText:@"Snow"];
            break;
            
        case 14:
            [cell.textLabel setText:@"Country"];
            break;
    }
    
    [cell.detailTextLabel setText:[tableViewContents objectAtIndex:[indexPath row]]];
    
    return cell;
}


- (void)addGestureRecogniserToMapView{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5; //
    [self.mapView addGestureRecognizer:lpgr];
    
}

- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *toAdd = [[MKPointAnnotation alloc]init];
    
    toAdd.coordinate = touchMapCoordinate;
    toAdd.title = @"Dropped Pin";
    
    //Set your API Key at the top of this class, if you do not want to use an API key pass in nil
    [weatherManager fetchWeatherDataForLatitude:toAdd.coordinate.latitude andLongitude:toAdd.coordinate.longitude withAPIKeyOrNil:API_KEY :^(JFWeatherData *returnedWeatherData) {
        
        NSLog(@"Latitude %.3f",[returnedWeatherData latitudeCoordinateOfRequest]);
        NSLog(@"Longitude %.3f",[returnedWeatherData longitudeCoordinateOfRequest]);
        NSLog(@"Country %@",[returnedWeatherData countryCode]);
        NSLog(@"Conditions are %@",[returnedWeatherData currentConditionsTextualDescription]);
        NSLog(@"Temperature is %f",[returnedWeatherData temperatureInUnitFormat:kTemperatureCelcius]);
        NSLog(@"Sunrise is %@",[returnedWeatherData sunriseTime]);
        NSLog(@"Sunset is %@",[returnedWeatherData sunsetTime]);
        NSLog(@"Hours of Day Light are %@",[returnedWeatherData dayLightHours]);
        NSLog(@"Humidity is %@",[returnedWeatherData humidityPercentage]);
        NSLog(@"Pressure is %0.1f",[returnedWeatherData pressureInUnitFormat:kPressureHectopascal]);
        NSLog(@"Wind Speed is %0.1f",[returnedWeatherData windSpeedInUnitFormat:kWindSpeedMPH]);
        NSLog(@"Wind Direction is %@",[returnedWeatherData windDirectionInGeographicalDirection]);
        NSLog(@"Cloud Coverage %@",[returnedWeatherData cloudCovergePercentage]);
        NSLog(@"Rainfall Over Next 3h is %0.1fmm",[returnedWeatherData rainFallVolumeOver3HoursInMillimeters]);
        NSLog(@"SnowFall Over Next 3h is %0.1fmm",[returnedWeatherData snowFallVolumeOver3HoursInMillimeters]);
        
        [tableViewContents removeAllObjects];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.2f",[returnedWeatherData latitudeCoordinateOfRequest]]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.2f",[returnedWeatherData longitudeCoordinateOfRequest]]];
        [tableViewContents addObject:[returnedWeatherData currentConditionsTextualDescription]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.1f°",[returnedWeatherData temperatureInUnitFormat:kTemperatureCelcius]]];
        [tableViewContents addObject:[returnedWeatherData sunriseTime]];
        [tableViewContents addObject:[returnedWeatherData sunsetTime]];
        [tableViewContents addObject:[returnedWeatherData dayLightHours]];
        [tableViewContents addObject:[returnedWeatherData humidityPercentage]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.1f",[returnedWeatherData pressureInUnitFormat:kPressureHectopascal]]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.1f",[returnedWeatherData windSpeedInUnitFormat:kWindSpeedMPH]]];
        [tableViewContents addObject:[returnedWeatherData windDirectionInGeographicalDirection]];
        [tableViewContents addObject:[returnedWeatherData cloudCovergePercentage]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.1fmm",[returnedWeatherData rainFallVolumeOver3HoursInMillimeters]]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%.1fmm",[returnedWeatherData snowFallVolumeOver3HoursInMillimeters]]];
        [tableViewContents addObject:[NSString stringWithFormat:@"%@",[returnedWeatherData countryCode]]];
        
        [self.tableView reloadData];
        
    }];
    [self.mapView addAnnotation:toAdd];
    
}


@end
