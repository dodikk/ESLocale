#import <Foundation/Foundation.h>
#import <ESLocale/Calendar/ESDateResolutionType.h>




/**
A class to convert the NSRange a pair of NSDate ofjects. It can be useful to build timeline selection GUI components.

It supports the following resolutions
* day
* week
* month
* quarter
* half year
* year

Note : The dates must be aligned to a given resolution
*/
@interface ESRangeToDatesConverter : NSObject



/**
A designated initializer.
Note : dates must be aligned to a given resolution

@param globalBegin_ The beginning of a timeline range.
@param globalEnd_ The end of a timeline range.
@param resolution_ Resolution to scale dates against.
@param locale_ The locale for calendar computations.
Note : It will have the highest impact on week calculations.

@return A properly initialized ESDatesToRangeConverter object.
*/
-(instancetype)initWithTimelineStartDate:( NSDate* )globalBegin_
              		 timelineEndDate:( NSDate* )globalEnd_
              		      resolution:( ESDateResolution )resolution_
               		          locale:( NSLocale* )locale_;

/**
An NSRange of the user's input relative to [globalBegin_; globalEnd_] dates range.
*/
@property ( nonatomic ) NSRange timelineRange;

/**
A date for the beginning of the range.

```
result = globalBegin_ + timelineRange.location * resolution_
```

*/
-(NSDate*)getStartDate;


/**
A date for the end of the range.

```
result = globalBegin_ + ( timelineRange.location + timelineRange.length ) * resolution_
```

*/
-(NSDate*)getEndDate;

@end


