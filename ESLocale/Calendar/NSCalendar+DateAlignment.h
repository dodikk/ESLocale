#include <ESLocale/Calendar/ESDateResolutionType.h>

#import <Foundation/Foundation.h>

/**
Calendar methods for aligning dates to some particular units.
Used for timeline UI widget implementation.
*/
@interface NSCalendar (DateAlignment)

/**
Aligns date to the beginning of the current unit.

For example
Month : '2013-12-03' --> '2013-12-01'

@param date_ A date to align
@param resolution_ Resolution to align dates against

@return Aligned date.
*/
-(NSDate*)alignToPastDate:( NSDate* )date_ resolution:( ESDateResolution )resolution_;


/**
Aligns date to the beginning of the next unit.

For example
Month : '2013-12-03' --> '2014-01-01'

@param date_ A date to align
@param resolution_ Resolution to align dates against

@return Aligned date.
*/
-(NSDate*)alignToFutureDate:( NSDate* )date_ resolution:( ESDateResolution )resolution_;


/**
Aligns the time range. The new range contains a specified one completely. 

Warning : Unsafe function. The parameters are in-out. Does in-place replacement.
Note : does not accept NULL parameters and invalid time ranges.


@param fromDate_ The beginning of the range to align.
Aligned to **past**.

@param toDate_ Theend of the range to align.
Aligned to **future**.

@param resolution_ Resolution to align dates against

*/
-(void)alignDateRangeFromDate:( inout NSDate** )fromDate_
                       toDate:( inout NSDate** )toDate_
                   resolution:( ESDateResolution )resolution_;


/**
Adds some units to a given date.

```
result =  date_ + intervals_ * resolution_
```


@param intervals_ Count of the intervals to add. Subtracts the intervals if a negative number is passed.

@param date_ A base date for computations.

@param resolution_ Unit to add or subtract

@result A date with added units.

*/
-(NSDate*)dateByAddingTimeIntervals:( NSInteger )intervals_
                             toDate:( NSDate* )date_
                         resolution:( ESDateResolution )resolution_;


/**
Calculates a maximal time interval that can fit into the dates range completely.

result = max( ESDateResolution )  
         : resolution <= ( toDate_ - fromDate_ )

@param fromDate_ The beginning of a time range.
@param toDate_ The end of a time range.

@return A unit for the maximal time interval.
*/
-(ESDateResolution)maximumResolutionFromDate:( NSDate* )fromDate_
                                      toDate:( NSDate* )toDate_;

@end

