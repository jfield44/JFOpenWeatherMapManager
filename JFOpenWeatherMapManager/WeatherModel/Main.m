//
//  Main.m
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Main.h"


NSString *const kMainHumidity = @"humidity";
NSString *const kMainTempMax = @"temp_max";
NSString *const kMainTempMin = @"temp_min";
NSString *const kMainTemp = @"temp";
NSString *const kMainPressure = @"pressure";


@interface Main ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Main

@synthesize humidity = _humidity;
@synthesize tempMax = _tempMax;
@synthesize tempMin = _tempMin;
@synthesize temp = _temp;
@synthesize pressure = _pressure;


+ (Main *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Main *instance = [[Main alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.humidity = [[self objectOrNilForKey:kMainHumidity fromDictionary:dict] doubleValue];
            self.tempMax = [[self objectOrNilForKey:kMainTempMax fromDictionary:dict] doubleValue];
            self.tempMin = [[self objectOrNilForKey:kMainTempMin fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kMainPressure fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMax] forKey:kMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMin] forKey:kMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kMainPressure];

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

    self.humidity = [aDecoder decodeDoubleForKey:kMainHumidity];
    self.tempMax = [aDecoder decodeDoubleForKey:kMainTempMax];
    self.tempMin = [aDecoder decodeDoubleForKey:kMainTempMin];
    self.temp = [aDecoder decodeDoubleForKey:kMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kMainPressure];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kMainHumidity];
    [aCoder encodeDouble:_tempMax forKey:kMainTempMax];
    [aCoder encodeDouble:_tempMin forKey:kMainTempMin];
    [aCoder encodeDouble:_temp forKey:kMainTemp];
    [aCoder encodeDouble:_pressure forKey:kMainPressure];
}


@end
