#import <Foundation/Foundation.h>


/**
Performs conversions using the @synchronized keyword.
*/
@interface NSDateFormatter (MultiThreading)

/**
Converts a date to a string.

@param date_ A date to convert.

@return A formatted string.
*/
-(NSString*)synchronizedStringFromDate:( NSDate* )date_;


/**
Converts a string to a date.

@param string_ A string to convert.

@return A corresponding NSDate object.
*/
-(NSDate*)synchronizedDateFromString:( NSString* )string_;

@end
