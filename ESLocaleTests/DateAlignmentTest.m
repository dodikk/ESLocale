#import "ESLocaleFactory.h"

#import "testDateUtils.h"

#import "NSCalendar+DateAlignment.h"

#import <SenTestingKit/SenTestingKit.h>

@interface DateAlignmentTest : SenTestCase
@end

@implementation DateAlignmentTest

//////////////////// MONTH PAST ////////////////////

//January 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6  7
//8  9 10 11 12 13 14
//15 16 17 18 19 20 21
//22 23 24 25 26 27 28
//29 30 31
-(void)testPastJan01_2012_MonthDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESMonthDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-12-31", @"ok" );
}

//May 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testPastMay22_2012_MonthDateResolution
{
    NSDate* date_ = dateFromString( @"2012-05-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESMonthDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-04-30", @"ok" );
}

//December 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30 31
-(void)testPastDec31_2012_MonthDateResolution
{
    NSDate* date_ = dateFromString( @"2011-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESMonthDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-12-31", @"ok" );
}

//////////////////// MONTH FUTURE ////////////////////

//January 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6  7
//8  9 10 11 12 13 14
//15 16 17 18 19 20 21
//22 23 24 25 26 27 28
//29 30 31
-(void)testFutureJan01_2012_MonthDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESMonthDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

//December 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30 31
-(void)testFutureDec28_2012_MonthDateResolution
{
    NSDate* date_ = dateFromString( @"2011-12-28" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESMonthDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

//January 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6  7
//8  9 10 11 12 13 14
//15 16 17 18 19 20 21
//22 23 24 25 26 27 28
//29 30 31
-(void)testFutureJan11_2012_MonthDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-11" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESMonthDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-02-01", @"ok" );
}

//////////////////// QUARTER PAST ////////////////////

//January 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6  7
//8  9 10 11 12 13 14
//15 16 17 18 19 20 21
//22 23 24 25 26 27 28
//29 30 31
-(void)testPastJan01_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-12-31", @"ok" );
}

//May 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testPastMay22_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-05-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-03-31", @"ok" );
}

//September 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30
-(void)testPastSep22_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-09-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-06-30", @"ok" );
}

//October 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6
//7  8  9 10 11 12 13
//14 15 16 17 18 19 20
//21 22 23 24 25 26 27
//28 29 30 31
-(void)testPastOct22_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-10-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-09-30", @"ok" );
}

//December 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30 31
-(void)testPastDec31_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-03-31", @"ok" );
}

//////////////////// QUARTER FUTURE ////////////////////

//January 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6  7
//8  9 10 11 12 13 14
//15 16 17 18 19 20 21
//22 23 24 25 26 27 28
//29 30 31
-(void)testFutureJan01_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

//January 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6  7
//8  9 10 11 12 13 14
//15 16 17 18 19 20 21
//22 23 24 25 26 27 28
//29 30 31
-(void)testFutureJan02_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-01-02" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-04-01", @"ok" );
}

//May 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testFutureMay22_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-05-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-07-01", @"ok" );
}

//September 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30
-(void)testFutureSep22_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-09-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-10-01", @"ok" );
}

//October 2012
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6
//7  8  9 10 11 12 13
//14 15 16 17 18 19 20
//21 22 23 24 25 26 27
//28 29 30 31
-(void)testFutureOct22_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-10-22" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2013-01-01", @"ok" );
}

//December 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30 31
-(void)testFutureDec31_2012_QuarterDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESQuarterDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2013-01-01", @"ok" );
}

//////////////////// HALF YEAR PAST ////////////////////

//March 2011
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testPastMar31_2011_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2010-12-31", @"ok" );
}

//November 2010
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5  6
//7  8  9 10 11 12 13
//14 15 16 17 18 19 20
//21 22 23 24 25 26 27
//28 29 30
-(void)testPastNov01_2010_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2010-10-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2010-06-30", @"ok" );
}

//December 2012
//Su Mo Tu We Th Fr Sa
//1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30 31
-(void)testPastDec31_2012_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-12-31", @"ok" );
}

//June 2012
//Su Mo Tu We Th Fr Sa
//1  2
//3  4  5  6  7  8  9
//10 11 12 13 14 15 16
//17 18 19 20 21 22 23
//24 25 26 27 28 29 30
-(void)testPastJun30_2012_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-06-30" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toPast: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2012-06-30", @"ok" );
}

//////////////////// HALF YEAR FUTURE ////////////////////

//March 2011
//Su Mo Tu We Th Fr Sa
//1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testFutureMar31_2011_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-07-01", @"ok" );
}

//August 1986
//Su Mo Tu We Th Fr Sa
//1  2
//3  4  5  6  7  8  9
//10 11 12 13 14 15 16
//17 18 19 20 21 22 23
//24 25 26 27 28 29 30
//31
-(void)testFutureAug18_1986_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"1986-08-18" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"1987-01-01", @"ok" );
}

//July 2011
//Su Mo Tu We Th Fr Sa
//1  2
//3  4  5  6  7  8  9
//10 11 12 13 14 15 16
//17 18 19 20 21 22 23
//24 25 26 27 28 29 30
//31
-(void)testFutureJul01_2011_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-07-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"2011-07-01", @"ok" );
}

//January 1987
//Su Mo Tu We Th Fr Sa
//1  2  3
//4  5  6  7  8  9 10
//11 12 13 14 15 16 17
//18 19 20 21 22 23 24
//25 26 27 28 29 30 31
-(void)testFutureJan01_1987_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"1987-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ toFuture: date_ forResolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    STAssertEqualObjects( result_, @"1987-01-01", @"ok" );
}

@end
