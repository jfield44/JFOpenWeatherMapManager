//
//  JFWeatherData.h
//
//  Created by Jonathan Field on 27/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//  http://jonathanfield.me
//  https://github.com/jfield44/JFOpenWeatherMapManager

#import <Foundation/Foundation.h>
#import "Main.h"
#import "Wind.h"
#import "Coord.h"
#import "Sys.h"
#import "Weather.h"
#import "Clouds.h"
#import "Rain.h"
#import "Snow.h"
#import "APTimeZones.h"

@class Main, Wind, Coord, Sys, Clouds, Rain, Snow;

typedef enum temperatureUnits {kTemperatureKelvin, kTemperatureCelcius, kTemperatureFarenheit} TemperatureUnit;
typedef enum pressureUnits {kPressureHectopascal, kPressurePascal} PressureUnit;
typedef enum windSpeedUnits {kWindSpeedMPS, kWindSpeedMPH, kWindSpeedKPH} WindSpeedUnit;

@interface JFWeatherData : NSObject <NSCoding>

@property (nonatomic, strong) NSString *base;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double dt;
@property (nonatomic, strong) Main *main;
@property (nonatomic, strong) Wind *wind;
@property (nonatomic, strong) Coord *coord;
@property (nonatomic, strong) Sys *sys;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) Clouds *clouds;
@property (nonatomic, assign) double cod;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Rain *rain;
@property (nonatomic, strong) Snow *snow;

+ (JFWeatherData *)modelObjectWithDictionary:(NSDictionary *)dict; //Create object from API Dictionary Response
- (instancetype)initWithDictionary:(NSDictionary *)dict; //**
- (NSDictionary *)dictionaryRepresentation;

- (NSString *)currentConditionsTextualDescription; //E.g. Broken Clouds
- (double)temperatureInUnitFormat:(TemperatureUnit)temperatureUnit; //Temperature with format specified as param
- (double)pressureInUnitFormat:(PressureUnit)pressureUnit; //Pressure with format specificed as param
- (NSString *)sunriseTime; //Time of SunRise (GMT only at the moment)
- (NSString *)sunsetTime; //Time of SunSet (GMT only at the moment)
- (NSString *)dayLightHours; //Hours and minutes of Daylight HH:mm
- (NSString *)humidityPercentage; //Humidty as a percentage
- (NSString *)cloudCovergePercentage; //Cloud coverage as a percentage
- (double)windSpeedInUnitFormat:(WindSpeedUnit)windSpeedUnit; //Wind Speed with format specified as param
- (double)windDirectionInDegrees; //Wind Direction in degrees
- (NSString *)windDirectionInGeographicalDirection; //Wind Direction as N/NE/E/SE
- (double)rainFallVolumeOver3HoursInMillimeters; //Amount of Rain Precipitation over next 3 hours in mm
- (double)snowFallVolumeOver3HoursInMillimeters; //Amount of Snow Precipitation over next 3 hours in mm
- (double)latitudeCoordinateOfRequest; //Latitude of Request
- (double)longitudeCoordinateOfRequest; //Longitude of Request
- (NSString *)countryCode; // E.g. GB / US / DE

@end
