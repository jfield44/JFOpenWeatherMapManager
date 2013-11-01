//
//  Weather.h
//
//  Created by Jonathan Field on 26/10/2013
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Weather : NSObject <NSCoding>

@property (nonatomic, assign) double weatherIdentifier;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *weatherDescription;

+ (Weather *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
