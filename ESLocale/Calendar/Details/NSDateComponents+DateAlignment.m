#import "NSDateComponents+DateAlignment.h"

@implementation NSDateComponents (DateAlignment)

-(void)weekAlignToFuture:( BOOL )toFuture_
                calendar:( NSCalendar* )calendar_
{
    NSParameterAssert( calendar_ );

    if ( toFuture_ )
    {
        [ self setWeekday: 7 ];
    }
    else
    {
        [ self setWeekday: 1 ];
    }
}

-(void)yearAlignToFuture:( BOOL )toFuture_
                calendar:( NSCalendar* )calendar_
{
    if ( toFuture_ )
    {
        [ self setYear: [ self year ] + 1 ];
    }
//    else
//    {
////        NSDateComponents* subtractOneDay_ = [ NSDateComponents new ];
////        subtractOneDay_.day = -1;
//        [ self setDay: [ self day ] - 1 ];
//
////        result_ = [ self dateByAddingComponents: subtractOneDay_
////                                         toDate: result_
////                                        options: 0 ];
//    }
}

@end
