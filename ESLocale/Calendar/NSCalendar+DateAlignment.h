#import <Foundation/Foundation.h>

#include <ESLocale/Calendar/ESDateResolutionType.h>

@interface NSCalendar (DateAlignment)

-(NSDate*)alignToPastDate:( NSDate* )date_ resolution:( ESDateResolution )resolution_;
-(NSDate*)alignToFutureDate:( NSDate* )date_ resolution:( ESDateResolution )resolution_;

-(void)alignDateRangeFromDate:( inout NSDate** )fromDate_
                       toDate:( inout NSDate** )toDate_
                   resolution:( inout ESDateResolution* )resolution_;

@end
