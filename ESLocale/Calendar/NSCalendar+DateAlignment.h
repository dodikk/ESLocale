#import <Foundation/Foundation.h>

//STODO remove enum
typedef enum
{
    ESDateResolutionUndefined
    , ESWeekDateResolution
    , ESMonthDateResolution
    , ESQuarterDateResolution
    , ESHalfYearDateResolution
    , ESYearDateResolution//tested
} ESDateResolution;

@interface NSCalendar (DateAlignment)

-(NSDate*)toPast:( NSDate* )date_ forResolution:( ESDateResolution )resolution_;
-(NSDate*)toFuture:( NSDate* )date_ forResolution:( ESDateResolution )resolution_;

@end
