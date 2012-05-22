#import "NSDateComponents+DateAlignment.h"

@implementation NSDateComponents (DateAlignment)

-(void)weekAlignToFuture:( BOOL )toFuture_
{
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

-(void)monthAlignToFuture:( BOOL )toFuture_
{
    if ( toFuture_ )
    {
        [ self setMonth: [ self month ] + 1 ];
    }
}

-(void)yearAlignToFuture:( BOOL )toFuture_
{
    if ( toFuture_ )
    {
        [ self setYear: [ self year ] + 1 ];
    }
}

@end
