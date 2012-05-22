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

//////////////////// YEAR PAST ////////////////////

-(void)testPastMar31_2011_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2010-12-31", @"ok" );
}

-(void)testPastJan01_2010_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2010-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2009-12-31", @"ok" );
}

-(void)testPastDec31_2012_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-12-31", @"ok" );
}

//////////////////// YEAR FUTURE ////////////////////

-(void)testFutureMar31_2011_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

-(void)testFutureJan01_2010_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2010-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-01-01", @"ok" );
}

-(void)testFutureDec31_2012_YearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2013-01-01", @"ok" );
}

//////////////////// WEEK PAST ////////////////////

-(void)testPastMar31_2011_WeekDateResolution
{
    NSDate* date_ = dateFromString( @"2011-01-01" );//saturday

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESWeekDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-01-01", @"ok" );
}

-(void)testPastJan01_2010_WeekDateResolution
{
    NSDate* date_ = dateFromString( @"2012-05-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESWeekDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-05-19", @"ok" );
}

-(void)testPastDec31_2012_WeekDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESWeekDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-12-31", @"ok" );
}

//////////////////// WEAK FUTURE ////////////////////

/*-(void)testFutureMar31_2011_WeakDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESWeekDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

-(void)testFutureJan01_2010_WeakDateResolution
{
    NSDate* date_ = dateFromString( @"2010-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESWeekDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-01-01", @"ok" );
}

-(void)testFutureDec31_2012_WeakDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESWeekDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2013-01-01", @"ok" );
}*/

@end
