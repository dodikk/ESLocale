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

-(void)quarterAlignToFuture:( BOOL )toFuture_
{
    NSInteger month_ = [ self month ];
    static NSInteger const monthPerQuarter_ = 3;
    month_ = ( month_ - 1 ) / monthPerQuarter_ * monthPerQuarter_ + 1;
    if ( toFuture_ )
    {
        month_ += monthPerQuarter_;
    }
    [ self setMonth: month_ ];
}

-(void)halfYearAlignToFuture:( BOOL )toFuture_
{
    NSInteger month_ = [ self month ];
    static NSInteger const monthPerHalfYear_ = 6;
    month_ = ( month_ - 1 ) / monthPerHalfYear_ * monthPerHalfYear_ + 1;
    if ( toFuture_ )
    {
        month_ += monthPerHalfYear_;
    }
    [ self setMonth: month_ ];
}

-(void)yearAlignToFuture:( BOOL )toFuture_
{
    if ( toFuture_ )
    {
        [ self setYear: [ self year ] + 1 ];
    }
}

@end
