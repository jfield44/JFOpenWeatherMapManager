//
//  JFWeatherManager.h
//  JFOpenWeatherMapManager
//
//  Created by Jonathan Field on 27/10/2013.
//  Copyright (c) 2013 Jonathan Field. All rights reserved.
//  http://jonathanfield.me
//  https://github.com/jfield44/JFOpenWeatherMapManager

#import <Foundation/Foundation.h>
#import "JFWeatherData.h"
#import "DataModels.h"
#import "AFNetworking.h"

@class JFWeatherManager;

@interface JFWeatherManager : NSObject

/*
 This function will retrieve the OpenWeatherMap API response based on the parameters provided
 latitude : Latitude Coordinate to retrieve weather for
 longitude : Longitude Coordinate to retrieve weather for
 apiKey : If you use an API for OpenWeatherMap API you should send this, if you do not, pass nil
 completitionBlock: When the API call has been completed, use the outcome of this block to manipulate WeatherData
 */
- (void)fetchWeatherDataForLatitude:(double)latitude andLongitude:(double)longitude withAPIKeyOrNil:(NSString *)apiKey :(void(^)(JFWeatherData *returnedWeatherData))completionBlock;


@end
