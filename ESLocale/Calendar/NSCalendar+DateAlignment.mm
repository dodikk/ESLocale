#import "NSCalendar+DateAlignment.h"

#import "NSDateComponents+Constants.h"
#import "NSDateComponents+DateAlignment.h"
#import "NSDateComponents+AddingTimeIntervals.h"

#import "ESLocaleFactory.h"

typedef std::vector< SEL > ESDateComponentsSelectorsType;

static const ESDateComponentsSelectorsType& getDateComponentSelectors()
{
    static ESDateComponentsSelectorsType dateComponentSelectors_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        {
            dateComponentSelectors_.push_back( NULL );
        }

        {
            SEL selector_ = @selector( dayAlignComponentsToFuture:date:calendar: );
            dateComponentSelectors_.push_back( selector_ );
        }

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

static const ESDateComponentsSelectorsType& getAddingDateComponentSelectors()
{
    static ESDateComponentsSelectorsType dateAddingComponentSelectors_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        {
            dateAddingComponentSelectors_.push_back( NULL );
        }

        {
            SEL selector_ = @selector( dayComponentsWithTimeInterval: );
            dateAddingComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( weekComponentsWithTimeInterval: );
            dateAddingComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( monthComponentsWithTimeInterval: );
            dateAddingComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( quarterComponentsWithTimeInterval: );
            dateAddingComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( halfYearComponentsWithTimeInterval: );
            dateAddingComponentSelectors_.push_back( selector_ );
        }

        {
            SEL selector_ = @selector( yearAlignComponentsWithTimeInterval: );
            dateAddingComponentSelectors_.push_back( selector_ );
        }
    } );

    return dateAddingComponentSelectors_;
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

    size_t resolutionIndex_ = static_cast<size_t>( resolution_ );
    auto selector_ = getDateComponentSelectors().at( resolutionIndex_ );

    if ( NULL == selector_ )
    {
        NSAssert( NO, @"does not implemented yet" );
        return nil;
    }

    typedef NSDate* (*AlignMsgSendFunction)( id, SEL, BOOL, NSDate*, NSCalendar* );
    static const AlignMsgSendFunction alignFunction = (AlignMsgSendFunction)objc_msgSend;
    
    NSDate* result_ = alignFunction( [ NSDate class ]
                                   , selector_
                                   , alignToFuture_
                                   , date_
                                   , self );

    return result_;
}

-(NSDate*)alignToPastDate:( NSDate* )date_
               resolution:( ESDateResolution )resolution_
{
    return [ self alignDate: date_
                 resolution: resolution_
                   toFuture: NO ];
}

-(NSDate*)alignToFutureDate:( NSDate* )date_
                 resolution:( ESDateResolution )resolution_
{
    NSDate* result_ = [ self alignDate: date_
                            resolution: resolution_
                              toFuture: YES ];

    return [ self dateByAddingComponents: [ NSDateComponents getSubtractOneDayComponents ]
                                  toDate: result_
                                 options: 0 ];
}

-(ESDateResolution)maximumResolutionFromDate:( NSDate* )fromDate_
                                      toDate:( NSDate* )toDate_
{
    static const NSInteger monthsInYear_ = 12;

    toDate_ = [ self dateByAddingComponents: [ NSDateComponents getAddOneDayComponents ]
                                     toDate: toDate_
                                    options: 0 ];

    NSDateComponents* components_ = [ self components: NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit
                                             fromDate: fromDate_
                                               toDate: toDate_
                                              options: 0 ];

    if ( components_.year > 0 )
    {
        return ESYearDateResolution;
    }
    else if ( components_.month >= monthsInYear_ / 2 )
    {
        return ESHalfYearDateResolution;
    }
    else if ( components_.month >= monthsInYear_ / 4 )
    {
        return ESQuarterDateResolution;
    }
    else if ( components_.month > 0 )
    {
        return ESMonthDateResolution;
    }
    else if ( components_.weekOfYear > 0 )
    {
        return ESWeekDateResolution;
    }

    return ESDayDateResolution;
}

-(void)alignDateRangeFromDate:( inout NSDate** )fromDate_
                       toDate:( inout NSDate** )toDate_
                   resolution:( ESDateResolution )resolution_
{
    BOOL resolutionOk_ = ( resolution_ <= ESYearDateResolution );
    BOOL startDateOk_  = ( NULL != fromDate_ && nil != *fromDate_ );
    BOOL endDateOk_    = ( NULL != toDate_   && nil != *toDate_   );
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

    if ( 0 == resolution_ )
    {
        resolution_ = ESYearDateResolution;
    }

    NSInteger tmpResolution_ = resolution_;
    NSDate* tmpFromDate_ = nil;
    NSDate* tmpToDate_   = nil;

    {
        tmpFromDate_ = [ self alignToPastDate: *fromDate_
                                   resolution: static_cast<ESDateResolution>( tmpResolution_ ) ];

        tmpToDate_ = [ self alignToFutureDate: *toDate_
                                   resolution: static_cast<ESDateResolution>( tmpResolution_ ) ];
    }

    resolution_ = static_cast<ESDateResolution>( tmpResolution_ );
    if ( resolution_ != ESDateResolutionUndefined )
    {
        *fromDate_ = tmpFromDate_;
        *toDate_   = tmpToDate_;
    }
}

-(NSDate*)dateByAddingTimeIntervals:( NSInteger )intervals_
                             toDate:( NSDate* )date_
                         resolution:( ESDateResolution )resolution_
{
    auto resolutionOk_ = ( ESDateResolutionUndefined <= resolution_ && resolution_ <= ESYearDateResolution );
    NSParameterAssert( resolutionOk_ );
    if ( !resolutionOk_ )
    {
        return nil;
    }

    size_t resolutionIndex_ = static_cast<size_t>( resolution_ );
    auto selector_ = getAddingDateComponentSelectors()[ resolutionIndex_ ];

    
    typedef NSDateComponents* (*GetDateComponentsMsgSendFunction)( id, SEL, NSInteger );
    static const GetDateComponentsMsgSendFunction GetDateComponents = (GetDateComponentsMsgSendFunction)objc_msgSend;
    
    
    NSDateComponents* components_ = GetDateComponents( [ NSDateComponents class ]
                                                 , selector_
                                                 , intervals_ );

    return [ self dateByAddingComponents: components_
                                  toDate: date_
                                 options: 0 ];
}

@end
