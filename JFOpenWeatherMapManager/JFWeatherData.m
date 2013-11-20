//
//  JFWeatherData.m
//
//  Created by Jonathan Field on 27/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "JFWeatherData.h"


NSString *const kJFWeatherDataBase = @"base";
NSString *const kJFWeatherDataId = @"id";
NSString *const kJFWeatherDataDt = @"dt";
NSString *const kJFWeatherDataMain = @"main";
NSString *const kJFWeatherDataWind = @"wind";
NSString *const kJFWeatherDataCoord = @"coord";
NSString *const kJFWeatherDataSys = @"sys";
NSString *const kJFWeatherDataWeather = @"weather";
NSString *const kJFWeatherDataClouds = @"clouds";
NSString *const kJFWeatherDataCod = @"cod";
NSString *const kJFWeatherDataName = @"name";
NSString *const kJFWeatherDataRain = @"rain";
NSString *const kJFWeatherDataSnow = @"snow";


@interface JFWeatherData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JFWeatherData

@synthesize base = _base;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dt = _dt;
@synthesize main = _main;
@synthesize wind = _wind;
@synthesize coord = _coord;
@synthesize sys = _sys;
@synthesize weather = _weather;
@synthesize clouds = _clouds;
@synthesize cod = _cod;
@synthesize name = _name;
@synthesize rain = _rain;
@synthesize snow = _snow;


+ (JFWeatherData *)modelObjectWithDictionary:(NSDictionary *)dict
{
    JFWeatherData *instance = [[JFWeatherData alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.base = [self objectOrNilForKey:kJFWeatherDataBase fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kJFWeatherDataId fromDictionary:dict] doubleValue];
            self.dt = [[self objectOrNilForKey:kJFWeatherDataDt fromDictionary:dict] doubleValue];
            self.main = [Main modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataMain]];
            self.wind = [Wind modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataWind]];
            self.coord = [Coord modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataCoord]];
            self.sys = [Sys modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataSys]];
    NSObject *receivedJFWeather = [dict objectForKey:kJFWeatherDataWeather];
    NSMutableArray *parsedJFWeather = [NSMutableArray array];
    if ([receivedJFWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedJFWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedJFWeather addObject:[Weather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedJFWeather isKindOfClass:[NSDictionary class]]) {
       [parsedJFWeather addObject:[Weather modelObjectWithDictionary:(NSDictionary *)receivedJFWeather]];
    }

    self.weather = [NSArray arrayWithArray:parsedJFWeather];
            self.clouds = [Clouds modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataClouds]];
            self.cod = [[self objectOrNilForKey:kJFWeatherDataCod fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kJFWeatherDataName fromDictionary:dict];
            self.rain = [Rain modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataRain]];
            self.snow = [Snow modelObjectWithDictionary:[dict objectForKey:kJFWeatherDataSnow]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.base forKey:kJFWeatherDataBase];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kJFWeatherDataId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kJFWeatherDataDt];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kJFWeatherDataMain];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kJFWeatherDataWind];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kJFWeatherDataCoord];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kJFWeatherDataSys];
NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:@"kJFWeatherDataWeather"];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kJFWeatherDataClouds];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cod] forKey:kJFWeatherDataCod];
    [mutableDict setValue:self.name forKey:kJFWeatherDataName];
    [mutableDict setValue:[self.rain dictionaryRepresentation] forKey:kJFWeatherDataRain];
    [mutableDict setValue:[self.snow dictionaryRepresentation] forKey:kJFWeatherDataSnow];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.base = [aDecoder decodeObjectForKey:kJFWeatherDataBase];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kJFWeatherDataId];
    self.dt = [aDecoder decodeDoubleForKey:kJFWeatherDataDt];
    self.main = [aDecoder decodeObjectForKey:kJFWeatherDataMain];
    self.wind = [aDecoder decodeObjectForKey:kJFWeatherDataWind];
    self.coord = [aDecoder decodeObjectForKey:kJFWeatherDataCoord];
    self.sys = [aDecoder decodeObjectForKey:kJFWeatherDataSys];
    self.weather = [aDecoder decodeObjectForKey:kJFWeatherDataWeather];
    self.clouds = [aDecoder decodeObjectForKey:kJFWeatherDataClouds];
    self.cod = [aDecoder decodeDoubleForKey:kJFWeatherDataCod];
    self.name = [aDecoder decodeObjectForKey:kJFWeatherDataName];
    self.rain = [aDecoder decodeObjectForKey:kJFWeatherDataRain];
    self.snow = [aDecoder decodeObjectForKey:kJFWeatherDataSnow];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_base forKey:kJFWeatherDataBase];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kJFWeatherDataId];
    [aCoder encodeDouble:_dt forKey:kJFWeatherDataDt];
    [aCoder encodeObject:_main forKey:kJFWeatherDataMain];
    [aCoder encodeObject:_wind forKey:kJFWeatherDataWind];
    [aCoder encodeObject:_coord forKey:kJFWeatherDataCoord];
    [aCoder encodeObject:_sys forKey:kJFWeatherDataSys];
    [aCoder encodeObject:_weather forKey:kJFWeatherDataWeather];
    [aCoder encodeObject:_clouds forKey:kJFWeatherDataClouds];
    [aCoder encodeDouble:_cod forKey:kJFWeatherDataCod];
    [aCoder encodeObject:_name forKey:kJFWeatherDataName];
    [aCoder encodeObject:_rain forKey:kJFWeatherDataRain];
    [aCoder encodeObject:_snow forKey:kJFWeatherDataSnow];
}

- (NSString *)currentConditionsTextualDescription{
    
    NSString *retval;
    
    @try {
        NSArray *currentConditionsList = self.weather;
        Weather *currentConditions = [currentConditionsList objectAtIndex:0];
        retval = currentConditions.weatherDescription;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",exception);
        retval = nil;
    }
    
    return [retval capitalizedString];
    
}

- (double)temperatureInUnitFormat:(TemperatureUnit)temperatureUnit{
    
    double retval;
    
    switch (temperatureUnit) {
        case kTemperatureKelvin:
            retval = self.main.temp;
            break;
            
        case kTemperatureCelcius:
            retval = self.main.temp - 273.15;
            break;
            
        case kTemperatureFarenheit:
            retval = (self.main.temp - 273.15) * 1.8000 + 32.00;
            break;
    }
    
    return retval ? retval : 0.0;

    
}

- (double)pressureInUnitFormat:(PressureUnit)pressureUnit{
    
    double retval;
    
    switch (pressureUnit) {
        case kPressureHectopascal:
            retval = self.main.pressure;
            break;
            
        case kPressurePascal:
            retval = self.main.pressure / 100;
            break;
    }
    
    return retval ? retval : 0.0;
    
}

- (double)windSpeedInUnitFormat:(WindSpeedUnit)windSpeedUnit{
    
    double retval;
    
    switch (windSpeedUnit) {
        case kWindSpeedMPS:
            retval = self.wind.speed;
            break;
            
        case kWindSpeedMPH:
            retval = self.wind.speed * 2.2369;
            break;
            
        case kWindSpeedKPH:
            retval = self.wind.speed * 3.6;
            break;
    }
    
    return retval ? retval : 0.0;
    
    
}

- (NSString *)sunriseTime{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitudeCoordinateOfRequest longitude:self.longitudeCoordinateOfRequest];
    
    NSTimeInterval rawSunrise = (double)self.sys.sunrise;
    NSDate *sunriseUtcTimeStamp = [NSDate date];
    sunriseUtcTimeStamp = [NSDate dateWithTimeIntervalSince1970:rawSunrise];

    NSDateFormatter *localTimeZoneFormatter = [NSDateFormatter new];
    localTimeZoneFormatter.timeZone = location.timeZone;
    localTimeZoneFormatter.dateFormat = @"HH:mm";
    NSString *localSunriseTime = [localTimeZoneFormatter stringFromDate:sunriseUtcTimeStamp];
    
    return localSunriseTime;
    
}

- (NSString *)sunsetTime{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitudeCoordinateOfRequest longitude:self.longitudeCoordinateOfRequest];
    
    NSTimeInterval rawSunset = (double)self.sys.sunset;
    NSDate *sunsetUtcTimeStamp = [NSDate date];
    sunsetUtcTimeStamp = [NSDate dateWithTimeIntervalSince1970:rawSunset];
    
    NSDateFormatter *localTimeZoneFormatter = [NSDateFormatter new];
    localTimeZoneFormatter.timeZone = location.timeZone;
    localTimeZoneFormatter.dateFormat = @"HH:mm";
    NSString *localSunsetTime = [localTimeZoneFormatter stringFromDate:sunsetUtcTimeStamp];
    
    return localSunsetTime;
    
}

- (NSString *)dayLightHours{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *sunrise = [dateFormatter dateFromString:[self sunriseTime]];
    NSDate *sunset = [dateFormatter dateFromString:[self sunsetTime]];
    NSTimeInterval interval = [sunset timeIntervalSinceDate:sunrise];
    NSInteger hours = (NSInteger)interval / 3600;
    NSInteger minutes = (interval - (hours * 3600)) / 60;
    NSString *timeDiff = [NSString stringWithFormat:@"%ld:%02ld", (long)hours, (long)minutes];
    
    return timeDiff;
    
}

- (NSString *)humidityPercentage{
    
    return [NSString stringWithFormat:@"%0.f%%",self.main.humidity];
    
}

- (NSString *)cloudCovergePercentage{
    
    return [NSString stringWithFormat:@"%0.f%%",self.clouds.all];
    
}

- (double)windDirectionInDegrees{
    
    return self.wind.deg ? self.wind.deg : 0.0;
    
}

- (NSString *)windDirectionInGeographicalDirection{
    
    double directionInDegrees = [self windDirectionInDegrees];
    NSString *retval;
    
    if ((directionInDegrees >= 339) || (directionInDegrees <= 22)) {
        retval = @"N";
    }else if ((directionInDegrees > 23) && (directionInDegrees <= 68)) {
        retval = @"NE";
    }else if ((directionInDegrees > 69) && (directionInDegrees <= 113)) {
        retval = @"E";
    }else if ((directionInDegrees > 114) && (directionInDegrees <= 158)) {
        retval = @"SE";
    }else if ((directionInDegrees > 159) && (directionInDegrees <= 203)) {
        retval = @"S";
    }else if ((directionInDegrees > 204) && (directionInDegrees <= 248)) {
        retval = @"SW";
    }else if ((directionInDegrees > 249) && (directionInDegrees <= 293)) {
        retval = @"W";
    }else if ((directionInDegrees > 294) && (directionInDegrees <= 338)) {
        retval = @"NW";
    }
    
    return retval ? retval : @"N/A";
    
}

- (double)rainFallVolumeOver3HoursInMillimeters{
    
    return self.rain.threeHour ? self.rain.threeHour : 0.0;
    
}

- (double)snowFallVolumeOver3HoursInMillimeters{

    return self.snow.threeHour ? self.snow.threeHour : 0.0;
    
}

- (double)latitudeCoordinateOfRequest{
    
    return self.coord.lat ? self.coord.lat : 0.0;
    
}

- (double)longitudeCoordinateOfRequest{
    
    return self.coord.lon ? self.coord.lon : 0.0;
    
}

- (NSString *)countryCode{
    
    return self.sys.country ? self.sys.country : @"N/A";
    
}

@end
