#import "ESLocaleFactory.h"

@implementation ESLocaleFactory

+(NSLocale*)posixLocale
{
   return [ [ NSLocale alloc ] initWithLocaleIdentifier: @"en_US_POSIX" ];
}

+(NSCalendar*)gregorianCalendar
{
   return [ [ NSCalendar alloc ] initWithCalendarIdentifier: NSGregorianCalendar ];
}


+(NSCalendar*)posixCalendar
{
   NSCalendar* result_ = [ self gregorianCalendar ];
   result_.locale = [ self posixLocale ];
   
   return result_;
}

+(NSDateFormatter*)posixDateFormatter
{
    return [ self gregorianDateFormatterWithLocale: [ self posixLocale ] ];
}



+(NSCalendar*)gregorianCalendarWithLocale:( NSLocale* )locale_
{
    NSCalendar* result_ = [ self gregorianCalendar ];
    result_.locale = locale_;
    
    return result_;
}

+(NSDateFormatter*)gregorianDateFormatterWithLocale:( NSLocale* )locale_
{
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
}

@end
