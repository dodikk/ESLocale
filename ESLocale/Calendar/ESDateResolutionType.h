#ifndef ESLocale_ESDateResolutionType_h
#define ESLocale_ESDateResolutionType_h

#import <Foundation/Foundation.h>


/**
Resolution object to convert date to NSRange back and forth.
Not using NSDateComponents since some units are non-standard and other ones are not needed
*/
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


