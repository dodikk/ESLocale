#import <Foundation/Foundation.h>


/**
A few factory methods to make date alignment and date arythmetics easier.
*/
@interface NSDateComponents (Constants)

/**
A component for "one day" time interval.

```
 result = [ NSDateComponents new ];
 
 result.day = 1;
```
 */
+(NSDateComponents*)getAddOneDayComponents;


/**
 A component for "one month" time interval.
 
```
 result = [ NSDateComponents new ];
 
 result.month = 1;
```
*/
+(NSDateComponents*)getAddOneMonthComponents;


/**
 A component for "one year" time interval.
 
 ```
 result = [ NSDateComponents new ];
 
 result.year = 1;
 ```
 */
+(NSDateComponents*)getAddOneYearComponents;


/**
 A component for "one day" time interval.
 
 ```
 result = [ NSDateComponents new ];
 
 result.day = -1;
 ```
 */
+(NSDateComponents*)getSubtractOneDayComponents;

@end
