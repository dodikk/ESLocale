#import "DayOfWeekTest.h"
#import "ESLocaleFactory.h"

@implementation DayOfWeekTest

-(void)testUSAWeekStartsOnSunday
{
   NSLocale* usLocale_ = [ [ NSLocale alloc ] initWithLocaleIdentifier: @"en_US" ];
   NSCalendar* usCal_ = [ ESLocaleFactory gregorianCalendarWithLocale: usLocale_ ];

   //(1 == Sunday and 7 == Saturday)
   // http://stackoverflow.com/questions/1106943/nscalendar-first-day-of-week
   STAssertTrue( usCal_.firstWeekday == 1, @"US week should start on Sunday. %d", usCal_.firstWeekday ); 
}

-(void)testRussianWeekStartsOnMonday
{
   NSLocale* ruLocale_ = [ [ NSLocale alloc ] initWithLocaleIdentifier: @"ru_RU" ];
   NSCalendar* ruCal_ = [ ESLocaleFactory gregorianCalendarWithLocale: ruLocale_ ];
   
   STAssertTrue( ruCal_.firstWeekday == 2, @"US week should start on Monday. %d", ruCal_.firstWeekday ); 
}

@end
