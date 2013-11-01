//
//  Main.h
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Main : NSObject <NSCoding>

@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double tempMax;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double pressure;

+ (Main *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
