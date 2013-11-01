//
//  Snow.h
//
//  Created by Jonathan Field on 31/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Snow : NSObject <NSCoding>

@property (nonatomic, assign) double threeHour;

+ (Snow *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
