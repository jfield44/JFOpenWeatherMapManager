//
//  Sys.m
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Sys.h"


NSString *const kSysCountry = @"country";
NSString *const kSysSunrise = @"sunrise";
NSString *const kSysSunset = @"sunset";


@interface Sys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Sys

@synthesize country = _country;
@synthesize sunrise = _sunrise;
@synthesize sunset = _sunset;


+ (Sys *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Sys *instance = [[Sys alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.country = [self objectOrNilForKey:kSysCountry fromDictionary:dict];
            self.sunrise = [[self objectOrNilForKey:kSysSunrise fromDictionary:dict] doubleValue];
            self.sunset = [[self objectOrNilForKey:kSysSunset fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.country forKey:kSysCountry];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunrise] forKey:kSysSunrise];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunset] forKey:kSysSunset];

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

    self.country = [aDecoder decodeObjectForKey:kSysCountry];
    self.sunrise = [aDecoder decodeDoubleForKey:kSysSunrise];
    self.sunset = [aDecoder decodeDoubleForKey:kSysSunset];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_country forKey:kSysCountry];
    [aCoder encodeDouble:_sunrise forKey:kSysSunrise];
    [aCoder encodeDouble:_sunset forKey:kSysSunset];
}


@end
