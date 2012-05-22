#import "NSCalendar+DateAlignment.h"

#include <vector>

typedef std::vector< std::pair< NSUInteger, SEL > > ESDateComponentsSelectorsType;

static const ESDateComponentsSelectorsType& getDateComponentSelectors2()
{
    static ESDateComponentsSelectorsType dateComponentSelectors_;

    if ( dateComponentSelectors_.size() == 0 )
    {
        dateComponentSelectors_.push_back( std::make_pair( 0, (SEL)NULL ) );//undefined resolution

        {
            NSCalendarUnit unit_ = NSYearForWeekOfYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit;
            dateComponentSelectors_.push_back( std::make_pair( unit_, @selector( weekAlignToFuture:calendar: ) ) );
        }

        dateComponentSelectors_.push_back( std::make_pair( NSMonthCalendarUnit  , @selector( month   ) ) );
        dateComponentSelectors_.push_back( std::make_pair( NSQuarterCalendarUnit, @selector( quarter ) ) );
        dateComponentSelectors_.push_back( std::make_pair( 0, (SEL)NULL ) );//ESHalfYearDateResolution resolution
        dateComponentSelectors_.push_back( std::make_pair( NSYearCalendarUnit, @selector( yearAlignToFuture:calendar: ) ) );
    }

    return dateComponentSelectors_;
}

@implementation NSString (PropertyName_NSCalendar_DateAlignment)

-(id)propertySetNameForPropertyName
{
    static NSString* setterSuffix_ = @":";
    if ( [ self hasSuffix: setterSuffix_ ] )
        return nil;

    NSUInteger stringLength_ = [ self length ];
    NSString* propertyNamePart1_ = [ [ self substringWithRange: NSMakeRange( 0, 1 ) ] capitalizedString ];
    NSString* propertyNamePart2_ = [ self substringWithRange: NSMakeRange( 1, stringLength_ - 1 ) ];
    NSString* result_ = [ propertyNamePart1_ stringByAppendingString: propertyNamePart2_ ];

    return [ [ @"set" stringByAppendingString: result_ ] stringByAppendingString: setterSuffix_ ];
}

@end

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

    std::pair< NSUInteger, SEL > selectors_ = getDateComponentSelectors2()[ resolution_ ];
    NSCalendarUnit unit_ = selectors_.first;

    if ( resolution_ == ESHalfYearDateResolution )
    {
        NSAssert( NO, @"ESHalfYearDateResolution: Not implemented yet" );
        return nil;
    }
    if ( resolution_ == ESQuarterDateResolution )
    {
        NSAssert( NO, @"ESQuarterDateResolution: Not implemented yet" );
        return nil;
    }

    NSDateComponents* components_ = [ self components: unit_
                                             fromDate: date_ ];

    SEL selector_ = selectors_.second;
    objc_msgSend( components_, selector_, alignToFuture_, self );

    return [ self dateFromComponents: components_ ];
}

-(NSDate*)toPast:( NSDate* )date_
   forResolution:( ESDateResolution )resolution_
{
    //add one day
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
    return [ self toPast: date_
           forResolution: resolution_
           alignToFuture: YES ];
}

@end
