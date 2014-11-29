#import "ESLocaleFactory.h"

@implementation ESLocaleFactory

+(NSLocale*)posixLocale
{
    static NSLocale* result = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^void()
    {
        result = [ [ NSLocale alloc ] initWithLocaleIdentifier: @"en_US_POSIX" ];
    });

    return result;
}

+(NSCalendar*)gregorianCalendar
{
    NSCalendar* result_ = [ [ NSCalendar alloc ] initWithCalendarIdentifier: NSCalendarIdentifierGregorian ];
    [ result_ setTimeZone: [ [ NSTimeZone alloc ] initWithName: @"GMT" ] ];
    return result_;
}

+(NSCalendar*)posixCalendar
{
    NSCalendar* result_ = [ self gregorianCalendar ];
    result_.locale = [ self posixLocale ];

    return result_;
}

+(NSDateFormatter*)posixDateFormatter
{
    NSDateFormatter* result_ = [ self gregorianDateFormatterWithLocale: [ self posixLocale ] ];
    return result_;
}

+(NSDateFormatter*)ansiDateFormatter
{
    // !!! Register matters : http://unicode.org/reports/tr35/tr35-10.html#Date_Format_Patterns

    NSDateFormatter* result_ = [ self posixDateFormatter ];
    result_.dateFormat = @"yyyy-MM-dd";

    return result_;
}

+(NSDateFormatter*)ansiDatetimeFormatter
{
    NSDateFormatter* result_ = [ self posixDateFormatter ];
    result_.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    return result_;
}

+(NSDateFormatter*)ansiTimestampFormatter
{
    NSDateFormatter* result_ = [ self posixDateFormatter ];
    result_.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    
    return result_;
}

+(NSCalendar*)gregorianCalendarWithLocaleId:( NSString* )localeIdentifier_
{
    NSLocale* locale_ = [ [ NSLocale alloc ] initWithLocaleIdentifier: localeIdentifier_ ];
    return [ self gregorianCalendarWithLocale: locale_ ];
}

+(NSCalendar*)gregorianCalendarWithLocale:( NSLocale* )locale_
{
    NSCalendar* result_ = [ self gregorianCalendar ];
    result_.locale = locale_;

    return result_;
}

+(NSDateFormatter*)gregorianDateFormatterWithLocale:( NSLocale* )locale_
{
    // @adk - Information about governmental standards
    // http://www.pjh2.de/datetime/weeknumber/wnd.php?l=en
    NSDateFormatter* result_ = [ NSDateFormatter new ];

    NSCalendar* calendar_ = [ self gregorianCalendarWithLocale: locale_ ];

    [ self setCalendar: calendar_
      forDateFormatter: result_ ];

    return result_;
}

+(void)setCalendar:( NSCalendar* )calendar_
  forDateFormatter:( NSDateFormatter* )result_
{
    result_.calendar = calendar_;
    result_.locale = calendar_.locale;
    result_.timeZone = calendar_.timeZone;
}

@end
