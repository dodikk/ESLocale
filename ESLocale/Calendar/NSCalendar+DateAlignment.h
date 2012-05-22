#import <Foundation/Foundation.h>

//STODO remove enum
typedef enum
{
    ESDateResolutionUndefined
    , ESWeekDateResolution
    , ESMonthDateResolution//testing
    , ESQuarterDateResolution//todo test
    , ESHalfYearDateResolution//todo test
    , ESYearDateResolution//tested
} ESDateResolution;

@interface NSCalendar (DateAlignment)

-(NSDate*)toPast:( NSDate* )date_ forResolution:( ESDateResolution )resolution_;
-(NSDate*)toFuture:( NSDate* )date_ forResolution:( ESDateResolution )resolution_;

@end
