#import <Foundation/Foundation.h>
#import <ESLocale/Calendar/ESDateResolutionType.h>


/**
A class to convert the date to NSRange. It can be useful to build timeline selection GUI components.

It supports the following resolutions
 
* day
* week
* month
* quarter
* half year
* year

Note : The dates must be aligned to a given resolution
*/
@interface ESDatesToRangeConverter : NSObject


/**
A designated initializer.
Note : dates must be aligned to a given resolution

@param globalBegin_ The beginning of a timeline range.
@param globalEnd_ The end of a timeline range.
@param locale_ The locale for calendar computations.
Note : It will have the highest impact on week calculations.

@return A properly initialized ESDatesToRangeConverter object.
*/
-(instancetype)initWithTimelineStartDate:( NSDate* )globalBegin_
                         timelineEndDate:( NSDate* )globalEnd_
                                  locale:( NSLocale* )locale_;

/**
A start date of the selected timeline range.
*/
@property ( nonatomic ) NSDate* startDate;

/**
An end date of the selected timeline range.
*/
@property ( nonatomic ) NSDate* endDate  ;

/**
Resolution to scale dates against.
*/
@property ( nonatomic ) ESDateResolution resolution;

/**
Calculates the sub-range of the start and end date in given units.

```
result.location = (startDate - globalBegin_) / resolution

result.length = (endDate - startDate) / resolution
```

@return A sub-range for the given dates and resolution.
*/
-(NSRange)getTimelineRange;

@end


