//
//  Coord.m
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Coord.h"


NSString *const kCoordLon = @"lon";
NSString *const kCoordLat = @"lat";


@interface Coord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coord

@synthesize lon = _lon;
@synthesize lat = _lat;


+ (Coord *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Coord *instance = [[Coord alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lon = [[self objectOrNilForKey:kCoordLon fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kCoordLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lon] forKey:kCoordLon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kCoordLat];

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

    self.lon = [aDecoder decodeDoubleForKey:kCoordLon];
    self.lat = [aDecoder decodeDoubleForKey:kCoordLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lon forKey:kCoordLon];
    [aCoder encodeDouble:_lat forKey:kCoordLat];
}


@end
