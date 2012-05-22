#import "NSCalendar+DateAlignment.h"

#include <vector>

typedef std::vector< std::pair< NSUInteger, SEL > > ESDateComponentsSelectorsType;

static const ESDateComponentsSelectorsType& getDateComponentSelectors2()
{
    static ESDateComponentsSelectorsType dateComponentSelectors_;

    if ( dateComponentSelectors_.size() == 0 )
    {
        dateComponentSelectors_.push_back( std::make_pair( NSYearCalendarUnit, @selector( year ) ) );
        dateComponentSelectors_.push_back( std::make_pair( 0, (SEL)NULL ) );//ESHalfYearDateResolution resolution
        dateComponentSelectors_.push_back( std::make_pair( NSQuarterCalendarUnit, @selector( quarter ) ) );
        dateComponentSelectors_.push_back( std::make_pair( NSMonthCalendarUnit  , @selector( month   ) ) );
        dateComponentSelectors_.push_back( std::make_pair( NSWeekCalendarUnit   , @selector( week    ) ) );
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

    std::pair< NSUInteger, SEL > selectors_ = getDateComponentSelectors2()[ resolution_ ];
    NSCalendarUnit unit_ = selectors_.first;

    if ( 0 == unit_ )
    {
        NSAssert( NO, @"ESYearDateResolution: Not implemented yet" );
        return nil;
    }

    NSDateComponents* components_ = [ self components: unit_
                                             fromDate: date_ ];

    if ( difference_ )
    {
        SEL getSelector_ = selectors_.second;
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
