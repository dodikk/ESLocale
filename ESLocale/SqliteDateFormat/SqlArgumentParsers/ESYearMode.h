#ifndef ESLocale_ESYearMode_h
#define ESLocale_ESYearMode_h

#import <Foundation/Foundation.h>

/**
Year mode for half year formatter.
*/
typedef NS_ENUM( NSInteger, ESYearMode )
{
    /**
    In case we did not manage to parse the SQL function argument.
    */
    ESYearModeUndefined = -1,

    /**
    Short year mode. For example, 'H1 '14'
    */
    ESYearModeShort     =  0,

    /**
    Long year mode. For example, 'H1 2014'
    */
    ESYearModeLong
};
#endif

