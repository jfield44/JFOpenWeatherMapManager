//
//  Snow.m
//
//  Created by Jonathan Field on 31/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Snow.h"


NSString *const kSnow3h = @"3h";


@interface Snow ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Snow

@synthesize threeHour = _threeHour;


+ (Snow *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Snow *instance = [[Snow alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.threeHour = [[self objectOrNilForKey:kSnow3h fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.threeHour] forKey:kSnow3h];

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

    self.threeHour = [aDecoder decodeDoubleForKey:kSnow3h];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_threeHour forKey:kSnow3h];
}


@end
