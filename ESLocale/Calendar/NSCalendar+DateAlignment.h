#import <Foundation/Foundation.h>

typedef enum
{
    ESYearDateResolution
    , ESHalfYearDateResolution
    , ESQuarterDateResolution
    , ESMonthDateResolution
    , ESWeekDateResolution
} ESDateResolution;

@interface NSCalendar (DateAlignment)

-(NSDate*)floorDate:( NSDate* )date_ forResolution:( ESDateResolution )resolution_;
-(NSDate*)ceilDate:( NSDate* )date_ forResolution:( ESDateResolution )resolution_;

@end
