#import <Foundation/Foundation.h>


/**
A few factory methods to make date alignment and date arythmetics easier.
*/
@interface NSDateComponents (Constants)

+(NSDateComponents*)getAddOneDayComponents;
+(NSDateComponents*)getAddOneMonthComponents;
+(NSDateComponents*)getAddOneYearComponents;
+(NSDateComponents*)getSubtractOneDayComponents;

@end
