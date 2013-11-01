//
//  JFRain.h
//
//  Created by Jonathan Field on 27/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Rain : NSObject <NSCoding>

@property (nonatomic, assign) double threeHour;

+ (Rain *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
