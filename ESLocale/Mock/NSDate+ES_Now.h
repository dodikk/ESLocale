#import <Foundation/Foundation.h>


/**
A category adding a "Current Date" method that can be safely overriden.
Warning : do not use [NSDate new] explicitly. Swizzling this method is a bad idea since many unit test frameworks rely on it.
*/
@interface NSDate (ES_Now)

/**
@return The date and time at the moment of calling.
*/
+(NSDate*)nowDate;

@end


