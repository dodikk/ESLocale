#import "NSCalendar+DateAlignment.h"

#include <vector>

static NSDateComponents* getAddOneDayComponents()
{
    static NSDateComponents* addOneDay_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        addOneDay_ = [ NSDateComponents new ];
        addOneDay_.day = 1;
    } );

    return addOneDay_;
}

static NSDateComponents* getSubtractOneDayComponents()
{
    static NSDateComponents* subtractOneDay_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        subtractOneDay_ = [ NSDateComponents new ];
        subtractOneDay_.day = -1;
    } );

    return subtractOneDay_;
}

typedef std::vector< SEL > ESDateComponentsSelectorsType;

static const ESDateComponentsSelectorsType& getDateComponentSelectors()
{
    static ESDateComponentsSelectorsType dateComponentSelectors_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        //undefined resolution
        dateComponentSelectors_.push_back( static_cast<SEL>( NULL ) );

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
    } );

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

-(NSDate*)alignDate:( NSDate* )date_
         resolution:( ESDateResolution )resolution_
           toFuture:( BOOL )alignToFuture_
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

-(NSDate*)alignToPastDate:( NSDate* )date_
               resolution:( ESDateResolution )resolution_
{
    //add one day to round last weak/month etc. date to the same date
    //example: firstDateOfMonth( "Aug 31" + 1 day ) == Sep 01 => "Sep 01" - 1 day = Aug 31
    date_ = [ self dateByAddingComponents: getAddOneDayComponents()
                                   toDate: date_
                                  options: 0 ];

    NSDate* result_ = [ self alignDate: date_
                            resolution: resolution_
                              toFuture: NO ];

    //subtract one day
    result_ = [ self dateByAddingComponents: getSubtractOneDayComponents()
                                     toDate: result_
                                    options: 0 ];

    return result_;
}

-(NSDate*)alignToFutureDate:( NSDate* )date_
                 resolution:( ESDateResolution )resolution_
{
    date_ = [ self dateByAddingComponents: getSubtractOneDayComponents()
                                   toDate: date_
                                  options: 0 ];

    return [ self alignDate: date_
                 resolution: resolution_
                   toFuture: YES ];
}

-(void)alignDateRangeFromDate:( inout NSDate** )fromDate_
                       toDate:( inout NSDate** )toDate_
                   resolution:( inout ESDateResolution* )resolution_
{
    BOOL resolutionOk_ = ( NULL != resolution_ && *resolution_ <= ESYearDateResolution );
    BOOL startDateOk_  = ( NULL != fromDate_   && nil != *fromDate_ );
    BOOL endDateOk_    = ( NULL != toDate_     && nil != *toDate_   );
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
    NSDate* tmpFromDate_ = nil;
    NSDate* tmpToDate_   = nil;

    while ( tmpResolution_ != 0 )
    {
        tmpFromDate_ = [ self alignToFutureDate: *fromDate_
                                     resolution: static_cast<ESDateResolution>( tmpResolution_ ) ];

        tmpToDate_ = [ self alignToPastDate: *toDate_
                                 resolution: static_cast<ESDateResolution>( tmpResolution_ ) ];

        if ( NSOrderedAscending == [ tmpFromDate_ compare: tmpToDate_ ] )
            break;

        tmpResolution_ -= 1;
    }

    *resolution_ = static_cast<ESDateResolution>( tmpResolution_ );
    if ( *resolution_ != ESDateResolutionUndefined )
    {
        *fromDate_ = tmpFromDate_;
        *toDate_   = tmpToDate_;
    }
}

@end
