#import "NSDateComponents+DateAlignment.h"

@implementation NSDateComponents (DateAlignment)

-(void)weekAlignToFuture:( BOOL )toFuture_
                calendar:( NSCalendar* )calendar_
{
    NSParameterAssert( calendar_ );

    if ( toFuture_ )
    {
        [ self setWeekday: 1 ];
        [ self setWeek: [ self week ] + 1 ];
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
}

@end
