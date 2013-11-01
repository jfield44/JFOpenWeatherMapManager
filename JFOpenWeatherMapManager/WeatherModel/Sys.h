//
//  Sys.h
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Sys : NSObject <NSCoding>

@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) double sunrise;
@property (nonatomic, assign) double sunset;

+ (Sys *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
