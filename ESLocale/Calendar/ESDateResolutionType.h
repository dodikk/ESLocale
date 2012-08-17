#ifndef ESLocale_ESDateResolutionType_h
#define ESLocale_ESDateResolutionType_h

#import <Foundation/Foundation.h>

enum ESDateResolutionEnum
{
    ESDateResolutionUndefined = 0
    , ESDayDateResolution
    , ESWeekDateResolution
    , ESMonthDateResolution
    , ESQuarterDateResolution
    , ESHalfYearDateResolution
    , ESYearDateResolution
};
typedef NSInteger ESDateResolution;

#endif //ESLocale_ESDateResolutionType_h
