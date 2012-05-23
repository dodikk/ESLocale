#import "NSDateComponents+DateAlignment.h"

@implementation NSDateComponents (DateAlignment)

+(id)weekAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSYearForWeekOfYearCalendarUnit | NSWeekOfYearCalendarUnit;
    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    NSInteger firstWeekday_ = (NSInteger)[ calendar_ firstWeekday ];
    [ components_ setWeekday: firstWeekday_ ];

    if ( toFuture_ )
    {
        [ components_ setWeekOfYear: [ components_ weekOfYear ] + 1 ];
    }

    return components_;
}

+(id)monthAlignComponentsToFuture:( BOOL )toFuture_
                             date:( NSDate* )date_
                         calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSYearCalendarUnit | NSMonthCalendarUnit;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    if ( toFuture_ )
    {
        [ components_ setMonth: [ components_ month ] + 1 ];
    }

    return components_;
}

+(id)quarterAlignComponentsToFuture:( BOOL )toFuture_
                               date:( NSDate* )date_
                           calendar:( NSCalendar* )calendar_
{
    //NSDateComponents.quarter property does not work properly,
    //so own range calulation used here
    //TODO: try to use NSQuarterCalendarUnit

    NSCalendarUnit unit_ = NSYearCalendarUnit | NSMonthCalendarUnit;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    //3 month per Quarter harcode used here for gregorian calendar only
    static NSInteger const monthPerQuarter_ = 3;
    NSInteger quarterStartMonth_ = ( [ components_ month ] - 1 ) / monthPerQuarter_ * monthPerQuarter_ + 1;
    if ( toFuture_ )
    {
        quarterStartMonth_ += monthPerQuarter_;
    }
    [ components_ setMonth: quarterStartMonth_ ];

    return components_;
}

+(id)halfYearAlignComponentsToFuture:( BOOL )toFuture_
                                date:( NSDate* )date_
                            calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSYearCalendarUnit | NSMonthCalendarUnit;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    //6 month per halfYear harcode used here for gregorian calendar only
    static NSInteger const monthPerHalfYear_ = 6;
    NSInteger monthStart_ = ( [ components_ month ] - 1 ) / monthPerHalfYear_ * monthPerHalfYear_ + 1;
    if ( toFuture_ )
    {
        monthStart_ += monthPerHalfYear_;
    }
    [ components_ setMonth: monthStart_ ];

    return components_;
}

+(id)yearAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSYearCalendarUnit;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    if ( toFuture_ )
    {
        [ components_ setYear: [ components_ year ] + 1 ];
    }

    return components_;
}

@end
