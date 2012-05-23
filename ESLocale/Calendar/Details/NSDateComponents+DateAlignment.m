#import "NSDateComponents+DateAlignment.h"

@implementation NSDateComponents (DateAlignment)

+(id)weekAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSYearForWeekOfYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    [ components_ setWeekday: (NSInteger)[ calendar_ firstWeekday ] ];

    if ( toFuture_ )
    {
        [ components_ setWeek: [ components_ week ] + 1 ];
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
    NSCalendarUnit unit_ = NSYearCalendarUnit | NSMonthCalendarUnit;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    NSInteger month_ = [ components_ month ];
    static NSInteger const monthPerQuarter_ = 3;
    month_ = ( month_ - 1 ) / monthPerQuarter_ * monthPerQuarter_ + 1;
    if ( toFuture_ )
    {
        month_ += monthPerQuarter_;
    }
    [ components_ setMonth: month_ ];

    return components_;
}

+(id)halfYearAlignComponentsToFuture:( BOOL )toFuture_
                                date:( NSDate* )date_
                            calendar:( NSCalendar* )calendar_
{
    NSCalendarUnit unit_ = NSYearCalendarUnit | NSMonthCalendarUnit;

    NSDateComponents* components_ = [ calendar_ components: unit_
                                                  fromDate: date_ ];

    NSInteger month_ = [ components_ month ];
    static NSInteger const monthPerHalfYear_ = 6;
    month_ = ( month_ - 1 ) / monthPerHalfYear_ * monthPerHalfYear_ + 1;
    if ( toFuture_ )
    {
        month_ += monthPerHalfYear_;
    }
    [ components_ setMonth: month_ ];

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
