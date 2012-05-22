#import "DateAlignmentTest.h"

#import "ESLocaleFactory.h"

#import "NSCalendar+DateAlignment.h"

static NSDate* dateFromString( NSString* date_ )
{
    NSDateFormatter* dateFormatter_ = [ ESLocaleFactory ansiDateFormatter ];
    return [ dateFormatter_ dateFromString: date_ ];
}

static NSString* stringFromDate( NSDate* string_ )
{
    NSDateFormatter* dateFormatter_ = [ ESLocaleFactory ansiDateFormatter ];
    return [ dateFormatter_ stringFromDate: string_ ];
}

@implementation DateAlignmentTest

//////////////////// YEAR FLOOR ////////////////////

-(void)testFloorMar31_2011_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ floorDate: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-01-01", @"ok" );
}

-(void)testFloorJan01_2010_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2010-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ floorDate: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2010-01-01", @"ok" );
}

-(void)testFloorDec31_2012_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ floorDate: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

//////////////////// YEAR CEIL ////////////////////

-(void)testCeilMar31_2011_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ ceilDate: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

-(void)testCeilJan01_2010_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2010-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ ceilDate: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-01-01", @"ok" );
}

-(void)testCeilDec31_2012_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ ceilDate: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2013-01-01", @"ok" );
}

@end
