#import <Foundation/Foundation.h>

//STODO remove enum
typedef enum
{
    ESDateResolutionUndefined
    , ESWeekDateResolution
    , ESMonthDateResolution
    , ESQuarterDateResolution
    , ESHalfYearDateResolution//testing
    , ESYearDateResolution
} ESDateResolution;

@interface NSCalendar (DateAlignment)

-(NSDate*)alignToPastDate:( NSDate* )date_ resolution:( ESDateResolution )resolution_;
-(NSDate*)alignToFutureDate:( NSDate* )date_ resolution:( ESDateResolution )resolution_;

-(void)alignDateRangeFromDate:( inout NSDate** )fromDate_
                       toDate:( inout NSDate** )toDate_
                   resolution:( inout ESDateResolution* )resolution_;

@end
