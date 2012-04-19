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
   NSDateFormatter* result_ = [ NSDateFormatter new ];
   
   NSCalendar* posixCalendar_ = [ self posixCalendar ];
   NSLocale*   posixLocale_   = posixCalendar_.locale;
   
   
   result_.locale   = posixLocale_  ;
   result_.calendar = posixCalendar_;
   
   return result_;
}

@end
