#import "NSDateComponents+DateAlignment.h"

#include "CalendarAlignmentConstants.h"
#import "NSDateComponents+Constants.h"

@implementation NSDate (DateAlignment)

+(id)dayAlignComponentsToFuture:( BOOL )toFuture_
                           date:( NSDate* )date_
                       calendar:( NSCalendar* )calendar_
{
    if ( !toFuture_ )
        return date_;

    NSDateComponents* components_ = [ NSDateComponents getAddOneDayComponents ];

    NSDate* result_ = [ calendar_ dateByAddingComponents: components_
                                                  toDate: date_
                                                 options: 0 ];

    return result_;
}

+(id)weekAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSCalendarUnitYearForWeekOfYear | NSCalendarUnitWeekOfYear;
    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    NSInteger firstWeekday_ = (NSInteger)[ calendar_ firstWeekday ];
    [ components_ setWeekday: firstWeekday_ ];

    if ( toFuture_ )
    {
        [ components_ setWeekOfYear: [ components_ weekOfYear ] + 1 ];
    }

    return [ calendar_ dateFromComponents: components_ ];
}

+(id)monthAlignComponentsToFuture:( BOOL )toFuture_
                             date:( NSDate* )date_
                         calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSCalendarUnitYear | NSCalendarUnitMonth;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    if ( toFuture_ )
    {
        [ components_ setMonth: [ components_ month ] + 1 ];
    }

    return [ calendar_ dateFromComponents: components_ ];
}

+(id)quarterAlignComponentsToFuture:( BOOL )toFuture_
                               date:( NSDate* )date_
                           calendar:( NSCalendar* )calendar_
{
    //NSDateComponents.quarter property does not work properly,
    //so own range calulation used here
    //TODO: try to use NSQuarterCalendarUnit

    NSCalendarUnit unit_ = NSCalendarUnitYear | NSCalendarUnitMonth;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    NSInteger quarterStartMonth_ = ( [ components_ month ] - 1 )
    / ESCalendarMonthPerQuarter * ESCalendarMonthPerQuarter + 1;
    if ( toFuture_ )
    {
        quarterStartMonth_ += ESCalendarMonthPerQuarter;
    }
    [ components_ setMonth: quarterStartMonth_ ];

    return [ calendar_ dateFromComponents: components_ ];
}

+(id)halfYearAlignComponentsToFuture:( BOOL )toFuture_
                                date:( NSDate* )date_
                            calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSCalendarUnitYear | NSCalendarUnitMonth;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    NSInteger monthStart_ = ( [ components_ month ] - 1 ) / ESCalendarMonthPerHalfYear * ESCalendarMonthPerHalfYear + 1;
    if ( toFuture_ )
    {
        monthStart_ += ESCalendarMonthPerHalfYear;
    }
    [ components_ setMonth: monthStart_ ];

    return [ calendar_ dateFromComponents: components_ ];
}

+(id)yearAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSCalendarUnitYear;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    if ( toFuture_ )
    {
        [ components_ setYear: [ components_ year ] + 1 ];
    }

    return [ calendar_ dateFromComponents: components_ ];
}

@end
