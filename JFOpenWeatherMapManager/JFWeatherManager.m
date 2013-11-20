//
//  JFWeatherManager.m
//  JFOpenWeatherMapManager
//
//  Created by Jonathan Field on 27/10/2013.
//  Copyright (c) 2013 Jonathan Field. All rights reserved.
//

#import "JFWeatherManager.h"

@implementation JFWeatherManager

    static NSString *BASE_URL = @"http://api.openweathermap.org/data/2.5/weather";
    static NSString *SERVER_SIDE_ERROR = @"Request failed: server error (512)";


- (void)fetchWeatherDataForLatitude:(double)latitude andLongitude:(double)longitude withAPIKeyOrNil:(NSString *)apiKey :(void (^)(JFWeatherData *))completionBlock{
    
    NSURL *destinationUrl;
    if (apiKey == nil || [apiKey isEqualToString:@"YOUR_API_KEY_HERE"]) {
        destinationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?lat=%f&lon=%f",BASE_URL,latitude,longitude]];
    }
    else{
        destinationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?lat=%f&lon=%f&APPID=%@",BASE_URL,latitude,longitude,apiKey]];
    }
    
    NSLog(@"Calling Weather API on %@",destinationUrl);
    NSURLRequest *request = [NSURLRequest requestWithURL:destinationUrl];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock([JFWeatherData modelObjectWithDictionary:responseObject]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        NSLog(@"Error: %ld", (long)error.code);
        
        if ([[error localizedDescription]isEqualToString:SERVER_SIDE_ERROR]) {
            [[[UIAlertView alloc]initWithTitle:@"Server Error" message:@"There was an server side issue with OpenWeatherMap API, consider signing up for an API Key or if you have one please try again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil]show];
        }
        
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
}



@end
