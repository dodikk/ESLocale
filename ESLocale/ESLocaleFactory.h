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
*/
+(NSDateFormatter*)posixDateFormatter;

/**
*/
+(NSDateFormatter*)ansiDateFormatter;


/**
*/
+(NSDateFormatter*)ansiDatetimeFormatter;


/**
*/
+(NSDateFormatter*)ansiTimestampFormatter;

/**
*/
+(NSCalendar*)gregorianCalendarWithLocaleId:( NSString* )localeIdentifier_;


/**
*/
+(NSCalendar*)gregorianCalendarWithLocale:( NSLocale* )locale_;



/**
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


