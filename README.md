JFOpenWeatherMapManager
=======================

Objective-C iOS / Mac OS X Wrapper to allow easy manipulation of the Open Weather Map API

Wrapper for Open Weather Map API + MapView example, add a pin to the map to retrieve the current weather data for that location

Add JFWeatherMapManager to your project

Import the following Header files
```Objective-C
#import "JFWeatherData.h"
#import "JFWeatherManager.h"
#import "DataModels.h"
```

If you are using the example project, be sure to set your API key in the View Controller, this is not mandatory and if you choose not to use an API key, simply pass nil to the fetch command later on
```Objective-C
static NSString *API_KEY = @"YOUR_API_KEY_HERE";
```

Create a Reference to a JFWeatherManager object and call the fetch function
```Objective-C
JFWeatherManager *weatherManager = [[JFWeatherManager alloc]init];

[weatherManager fetchWeatherDataForLatitude:toAdd.coordinate.latitude andLongitude:toAdd.coordinate.longitude withAPIKeyOrNil:API_KEY :^(JFWeatherData *returnedWeatherData){
        NSLog(@"Latitude %.3f",[returnedWeatherData latitudeCoordinateOfRequest]);
        NSLog(@"Longitude %.3f",[returnedWeatherData longitudeCoordinateOfRequest]);
        NSLog(@"Country %@",[returnedWeatherData countryCode]);
        NSLog(@"Conditions are %@",[returnedWeatherData currentConditionsTextualDescription]);
        NSLog(@"Temperature is %f",[returnedWeatherData temperatureInUnitFormat:kTemperatureCelcius]);
        NSLog(@"Sunrise is %@",[returnedWeatherData sunriseTime]);
        NSLog(@"Sunset is %@",[returnedWeatherData sunsetTime]);
        NSLog(@"Hours of Day Light are %@",[returnedWeatherData dayLightHours]);
        NSLog(@"Humidity is %@",[returnedWeatherData humidityPercentage]);
        NSLog(@"Pressure is %0.1f",[returnedWeatherData pressureInUnitFormat:kPressureHectopascal]);
        NSLog(@"Wind Speed is %0.1f",[returnedWeatherData windSpeedInUnitFormat:kWindSpeedMPH]);
        NSLog(@"Wind Direction is %@",[returnedWeatherData windDirectionInGeographicalDirection]);
        NSLog(@"Cloud Coverage %@",[returnedWeatherData cloudCovergePercentage]);
        NSLog(@"Rainfall Over Next 3h is %0.1fmm",[returnedWeatherData rainFallVolumeOver3HoursInMillimeters]);
        NSLog(@"SnowFall Over Next 3h is %0.1fmm",[returnedWeatherData snowFallVolumeOver3HoursInMillimeters]);
    }];
```
The data and format's that can be returned by the API are:
```Objective-C
- (NSString *)currentConditionsTextualDescription; //e.g Broken Clouds
- (double)temperatureInUnitFormat:(TemperatureUnit)temperatureUnit; //e.g 3.0°C , Temperature Available in Kelvin, Celsius and Fahrenheit
- (double)pressureInUnitFormat:(PressureUnit)pressureUnit; //e.g 1007.0 hPA , Pressure Available in Hectopascal, and Pascal
- (NSString *)sunriseTime; //e.g 06:33 (Time Shown is Localised based on Latitude and Longitude of the request)
- (NSString *)sunsetTime; //e.g 19:32 (Time Shown is Localised based on Latitude and Longitude of the request)
- (NSString *)dayLightHours; //e.g 12:15
- (NSString *)humidityPercentage; //e.g 88%
- (NSString *)cloudCovergePercentage; //e.g 32%
- (double)windSpeedInUnitFormat:(WindSpeedUnit)windSpeedUnit; //e.g 20.8 MPH, Wind Speed Available in Meters Per Second, Miles Per Hour, Kilometres Per Hour
- (double)windDirectionInDegrees; //e.g 320°
- (NSString *)windDirectionInGeographicalDirection; //e.g N (North)
- (double)rainFallVolumeOver3HoursInMillimeters; //e.g 3mm
- (double)snowFallVolumeOver3HoursInMillimeters; //e.g 7mm
- (double)latitudeCoordinateOfRequest; //e.g 32.79
- (double)longitudeCoordinateOfRequest; //e.g -96.0
- (NSString *)countryCode; // E.g. GB / US / DE
```

Temperature Formats (Kelvin, Celcius, Farenheit)
```Objective-C
typedef enum temperatureUnits {kTemperatureKelvin, kTemperatureCelcius, kTemperatureFarenheit} TemperatureUnit;
```

Pressure Formats (Hectopascal , Pascal)
```Objective-C
typedef enum pressureUnits {kPressureHectopascal, kPressurePascal} PressureUnit;
```

Wind Speed Units (MPS,MPH,KPH)
```Objective-C
typedef enum windSpeedUnits {kWindSpeedMPS, kWindSpeedMPH, kWindSpeedKPH} WindSpeedUnit;
```

=======================

Attribution (Special Thanks)

OpenWeatherMap API http://openweathermap.org for their great API!
AFNetworking for making the best network library on iOS and Mac OSX (Bundled with this project) http://afnetworking.com
APTimeZones for providing a great library for localizing the time zones based on latitude and longitude (Bundled with this project) https://github.com/Alterplay/APTimeZones

=======================

Contact - Jonathan Field | http://jonathanfield.me
