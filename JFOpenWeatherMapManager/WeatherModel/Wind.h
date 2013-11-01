//
//  Wind.h
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Wind : NSObject <NSCoding>

@property (nonatomic, assign) double speed;
@property (nonatomic, assign) double deg;

+ (Wind *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
