//
//  JFWeatherManager.m
//  JFOpenWeatherMapManager
//
//  Created by Jonathan Field on 27/10/2013.
//  Copyright (c) 2013 Jonathan Field. All rights reserved.
//

#import "JFWeatherManager.h"

@implementation JFWeatherManager

- (void)fetchWeatherDataForLatitude:(double)latitude andLongitude:(double)longitude withAPIKeyOrNil:(NSString *)apiKey :(void (^)(JFWeatherData *))completionBlock{
    
    NSString *destinationURL = apiKey == nil ? [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f",latitude, longitude] : [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&APPID=%@",latitude, longitude,apiKey];
    
    NSURL *URL = [NSURL URLWithString:destinationURL];
    NSLog(@"Calling Weather API on %@",URL);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock([JFWeatherData modelObjectWithDictionary:responseObject]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

@end
