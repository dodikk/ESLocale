#import <Foundation/Foundation.h>


/**
A collection of factory methods that construct properly configured instances of NSDateFormatter, NSLocale and NSCalendar classes.
*/
@interface ESLocaleFactory : NSObject


/**
Creates a locale with "en_US_POSIX" identifier.

@return NSLocale instance.
*/
+(NSLocale*)posixLocale;


/**
Creates an instance of the gregorian calendar.

@return NSCalendar instance
*/
+(NSCalendar*)gregorianCalendar;


/**
Creates an instance of the gregorian calendar with "en_US_POSIX" locale.

@return NSCalendar instance
*/
+(NSCalendar*)posixCalendar;


/**
Creates an instance of NSDateFormatter class with [ESLocaleFactory gregorianCalendar] and [ESLocaleFactory posixLocale]

@return An instance of NSDateFormatter.
*/
+(NSDateFormatter*)posixDateFormatter;


/**
Creates an instance of NSDateFormatter class with [ESLocaleFactory gregorianCalendar] , [ESLocaleFactory posixLocale] and ANSI **date** format.

Note : ANSI date format is "yyyy-MM-dd"

@return An instance of NSDateFormatter.
*/
+(NSDateFormatter*)ansiDateFormatter;


/**
Creates an instance of NSDateFormatter class with [ESLocaleFactory gregorianCalendar] , [ESLocaleFactory posixLocale] and ANSI **datetime** format.

Note : ANSI date format is "yyyy-MM-dd HH:mm:ss"

@return An instance of NSDateFormatter.
*/
+(NSDateFormatter*)ansiDatetimeFormatter;


/**
Creates an instance of NSDateFormatter class with [ESLocaleFactory gregorianCalendar] , [ESLocaleFactory posixLocale] and ANSI **datetime** format. 

Additionally to [ESLocaleFactory ansiDatetimeFormatter] it includes ticks.

Note : ANSI date format is "yyyy-MM-dd HH:mm:ss.SSS"

@return An instance of NSDateFormatter.
*/
+(NSDateFormatter*)ansiTimestampFormatter;


/**
Creates a gregorian calendar and sets the locale with a corresponding identifier.

@param localeIdentifier_ A string that will be passed to the [NSLocale initWithLocaleIdentifier:] constructor (designated initializer).

@return An instance of NSCalendar.
*/
+(NSCalendar*)gregorianCalendarWithLocaleId:( NSString* )localeIdentifier_;


/**
Creates a gregorian calendar and sets the corresponding locale.

@param locale_ An instance of NSLocale class to set for the newly created NSCalendar object.

@return An instance of NSCalendar.
*/
+(NSCalendar*)gregorianCalendarWithLocale:( NSLocale* )locale_;



/**
Creates a properly configured instance of NSDateFormatter object with the gregorian calendar and a given NSLocale object.

@param locale_ An instance of NSLocale class to set for the newly created NSCalendar object.

@return An instance of NSDateFormatter.
*/
+(NSDateFormatter*)gregorianDateFormatterWithLocale:( NSLocale* )locale_;



/**
Synchronizes the locale of the given calendar and date formatter.
The NSCalendar object and its corresponding NSLocale object will be assigned to the properties of the NSDateFormatter instance.

@param calendar_ A calendar that will be assigned to the date formatter. Its locale will be assigned to the date formatter.

@param result_ A date formatter to configure.


```
NSLocale* locale = [ ESLocaleFactory posixLocale ];
NSCalendar* calendar = [ ESLocaleFactory gregorianCalendar ];
calendar.locale = locale;

NSDateFormatter* dateFormatter = [ NSDateFormatter new ];

[ ESLocaleFactory setCalendar: calendar 
             forDateFormatter: dateFormatter ];
```

*/
+(void)setCalendar:( NSCalendar* )calendar_
  forDateFormatter:( NSDateFormatter* )result_;

@end


