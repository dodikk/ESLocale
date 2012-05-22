#import "NSCalendar+DateAlignment.h"

#include <vector>

static const std::vector< NSUInteger >& getCalendarUnit()
{
    static std::vector< NSUInteger > calendarUnit_;

    if ( calendarUnit_.size() == 0 )
    {
        calendarUnit_.push_back( NSYearCalendarUnit );
        calendarUnit_.push_back( 0 );//ESHalfYearDateResolution resolution
        calendarUnit_.push_back( NSQuarterCalendarUnit );
        calendarUnit_.push_back( NSMonthCalendarUnit );
        calendarUnit_.push_back( NSWeekCalendarUnit );
    }

    return calendarUnit_;
}

static const std::vector< SEL >& getDateComponentSelectors()
{
    static std::vector< SEL > dateComponentSelectors_;

    if ( dateComponentSelectors_.size() == 0 )
    {
        dateComponentSelectors_.push_back( @selector( year ) );
        dateComponentSelectors_.push_back( NULL );//ESHalfYearDateResolution resolution
        dateComponentSelectors_.push_back( @selector( quarter ) );
        dateComponentSelectors_.push_back( @selector( month   ) );
        dateComponentSelectors_.push_back( @selector( week    ) );
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

    BOOL isValidResolution_ = ( ESYearDateResolution <= resolution_ || ESWeekDateResolution >= resolution_ );
    if ( !isValidResolution_ )
    {
        NSAssert( NO, @"Invalid resolution argument" );
        return NO;
    }

    return YES;
}

-(NSDate*)floorDate:( NSDate* )date_
      forResolution:( ESDateResolution )resolution_
     dateDifference:( NSInteger )difference_
{
    [ [ self class ] validateArgumentsDate: date_
                                resolution: resolution_ ];

    NSCalendarUnit unit_ = getCalendarUnit()[ resolution_ ];

    if ( 0 == unit_ )
    {
        NSAssert( NO, @"ESYearDateResolution: Not implemented yet" );
        return nil;
    }

    NSDateComponents* components_ = [ self components: unit_
                                             fromDate: date_ ];

    if ( difference_ )
    {
        SEL getSelector_ = getDateComponentSelectors()[ resolution_ ];
        NSInteger someComponents_ = (NSInteger)objc_msgSend( components_, getSelector_ );
        NSString* setSelectorStr_ = [ NSStringFromSelector( getSelector_ ) propertySetNameForPropertyName ];
        SEL setSelector_ = NSSelectorFromString( setSelectorStr_ );
        objc_msgSend( components_, setSelector_, someComponents_ + difference_ );
    }

    return [ self dateFromComponents: components_ ];
}

-(NSDate*)floorDate:( NSDate* )date_
      forResolution:( ESDateResolution )resolution_
{
    return [ self floorDate: date_
              forResolution: resolution_
             dateDifference: 0 ];
}

-(NSDate*)ceilDate:( NSDate* )date_
     forResolution:( ESDateResolution )resolution_
{
    return [ self floorDate: date_
              forResolution: resolution_
             dateDifference: 1 ];
}

@end
