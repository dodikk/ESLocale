#import "NSCalendar+DateAlignment.h"

#include <vector>

typedef std::vector< SEL > ESDateComponentsSelectorsType;

static const ESDateComponentsSelectorsType& getDateComponentSelectors()
{
    static ESDateComponentsSelectorsType dateComponentSelectors_;

    if ( dateComponentSelectors_.size() == 0 )
    {
        dateComponentSelectors_.push_back( static_cast<SEL>( NULL ) );//undefined resolution

        {
            SEL selector_ = @selector( weekAlignComponentsToFuture:date:calendar: );
            dateComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( monthAlignComponentsToFuture:date:calendar: );
            dateComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( quarterAlignComponentsToFuture:date:calendar: );
            dateComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( halfYearAlignComponentsToFuture:date:calendar: );
            dateComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( yearAlignComponentsToFuture:date:calendar: );
            dateComponentSelectors_.push_back( selector_ );
        }
    }

    return dateComponentSelectors_;
}

@implementation NSCalendar (DateAlignment)

+(BOOL)validateArgumentsDate:( NSDate* )date_
                  resolution:( ESDateResolution )resolution_
{
    NSParameterAssert( date_ );
    BOOL validDate_ = !date_;
    if ( !validDate_ )
        return NO;

    BOOL isValidResolution_ = ( ESDateResolutionUndefined < resolution_ || resolution_ <= ESYearDateResolution );
    if ( !isValidResolution_ )
    {
        NSAssert( NO, @"Invalid resolution argument" );
        return NO;
    }

    return YES;
}

-(NSDate*)toPast:( NSDate* )date_
   forResolution:( ESDateResolution )resolution_
   alignToFuture:( BOOL )alignToFuture_
{
    [ [ self class ] validateArgumentsDate: date_
                                resolution: resolution_ ];

    auto selector_ = getDateComponentSelectors()[ resolution_ ];

    NSDateComponents* components_ = objc_msgSend( [ NSDateComponents class ]
                                                 , selector_
                                                 , alignToFuture_
                                                 , date_
                                                 , self );

    return [ self dateFromComponents: components_ ];
}

-(NSDate*)toPast:( NSDate* )date_
   forResolution:( ESDateResolution )resolution_
{
    //add one day to round last weak/month etc. date to the same date
    //example: firstDateOfMonth( "Aug 31" + 1 day ) == Sep 01 => "Sep 01" - 1 day = Aug 31
    {
        NSDateComponents* subtractOneDay_ = [ NSDateComponents new ];
        subtractOneDay_.day = 1;

        date_ = [ self dateByAddingComponents: subtractOneDay_
                                       toDate: date_
                                      options: 0 ];
    }

    NSDate* result_ = [ self toPast: date_
                      forResolution: resolution_
                      alignToFuture: NO ];

    //subtract one day
    {
        NSDateComponents* subtractOneDay_ = [ NSDateComponents new ];
        subtractOneDay_.day = -1;

        result_ = [ self dateByAddingComponents: subtractOneDay_
                                         toDate: result_
                                        options: 0 ];
    }

    return result_;
}

-(NSDate*)toFuture:( NSDate* )date_
     forResolution:( ESDateResolution )resolution_
{
    //subtract one day
    {
        NSDateComponents* subtractOneDay_ = [ NSDateComponents new ];
        subtractOneDay_.day = -1;

        date_ = [ self dateByAddingComponents: subtractOneDay_
                                         toDate: date_
                                        options: 0 ];
    }

    return [ self toPast: date_
           forResolution: resolution_
           alignToFuture: YES ];
}

-(void)alignDateRangeFromDate:( inout NSDate** )fromDate_
                       toDate:( inout NSDate** )toDate_
                   resolution:( inout ESDateResolution* )resolution_
{
    BOOL resolutionOk_ = ( NULL != resolution_ );
    BOOL startDateOk_  = ( NULL != fromDate_   && nil != *fromDate_  );
    BOOL endDateOk_    = ( NULL != toDate_     && nil != *toDate_    );
    BOOL dateRangeOk_  = startDateOk_ && endDateOk_
        && ( NSOrderedDescending != [ *fromDate_ compare: *toDate_ ] );

    NSParameterAssert( resolutionOk_ );
    NSParameterAssert( startDateOk_  );
    NSParameterAssert( endDateOk_    );
    NSParameterAssert( dateRangeOk_  );
    if ( !resolutionOk_ || !startDateOk_ || !endDateOk_ || !dateRangeOk_ )
    {
        return;
    }

    if ( 0 == *resolution_ )
    {
        *resolution_ = ESYearDateResolution;
    }

    NSUInteger tmpResolution_ = *resolution_;
    while ( tmpResolution_ != 0 )
    {
        *fromDate_ = [ self toFuture: *fromDate_
                       forResolution: static_cast<ESDateResolution>( tmpResolution_ ) ];

        *toDate_ = [ self toPast: *toDate_
                   forResolution: static_cast<ESDateResolution>( tmpResolution_ ) ];

        if ( NSOrderedAscending == [ *fromDate_ compare: *toDate_ ] )
            break;

        tmpResolution_ -= 1;
    }

    *resolution_ = static_cast<ESDateResolution>( tmpResolution_ );
}

@end
