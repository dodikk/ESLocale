#import "ESLocaleFactory.h"

#import "testDateUtils.h"

#import "NSCalendar+DateAlignment.h"

#import <XCTest/XCTest.h>

@interface DateAlignmentTest : XCTestCase
@end

@implementation DateAlignmentTest

//////////////////// PAST ////////////////////

//March 2011
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testPastMar31_2011_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];

    date_ = [ calendar_ alignToPastDate: date_
                             resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"2011-01-01", @"ok" );
}

//November 2010
//Su Mo Tu We Th Fr Sa
//   1  2  3  4  5  6
//7  8  9 10 11 12 13
//14 15 16 17 18 19 20
//21 22 23 24 25 26 27
//28 29 30
-(void)testPastNov01_2010_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2010-10-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToPastDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"2010-07-01", @"ok" );
}

//December 2012
//Su Mo Tu We Th Fr Sa
//                  1
//2  3  4  5  6  7  8
//9 10 11 12 13 14 15
//16 17 18 19 20 21 22
//23 24 25 26 27 28 29
//30 31
-(void)testPastDec31_2012_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-12-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToPastDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"2012-07-01", @"ok" );
}

//June 2012
//Su Mo Tu We Th Fr Sa
//               1  2
//3  4  5  6  7  8  9
//10 11 12 13 14 15 16
//17 18 19 20 21 22 23
//24 25 26 27 28 29 30
-(void)testPastJun30_2012_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2012-06-30" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToPastDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"2012-01-01", @"ok" );
}

//////////////////// FUTURE ////////////////////

//March 2011
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testFutureMar31_2011_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-03-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToFutureDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"2011-06-30", @"ok" );
}

//August 1986
//Su Mo Tu We Th Fr Sa
//               1  2
//3  4  5  6  7  8  9
//10 11 12 13 14 15 16
//17 18 19 20 21 22 23
//24 25 26 27 28 29 30
//31
-(void)testFutureAug18_1986_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"1986-08-18" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToFutureDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"1986-12-31", @"ok" );
}

//July 2011
//Su Mo Tu We Th Fr Sa
//               1  2
//3  4  5  6  7  8  9
//10 11 12 13 14 15 16
//17 18 19 20 21 22 23
//24 25 26 27 28 29 30
//31
-(void)testFutureJul01_2011_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"2011-07-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToFutureDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"2011-12-31", @"ok" );
}

//January 1987
//Su Mo Tu We Th Fr Sa
//            1  2  3
//4  5  6  7  8  9 10
//11 12 13 14 15 16 17
//18 19 20 21 22 23 24
//25 26 27 28 29 30 31
-(void)testFutureJan01_1987_HalfYearDateResolution
{
    NSDate* date_ = dateFromString( @"1987-01-01" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    date_ = [ calendar_ alignToFutureDate: date_ resolution: ESHalfYearDateResolution ];

    NSString* result_ = stringFromDate( date_ );

    XCTAssertEqualObjects( result_, @"1987-06-30", @"ok" );
}

@end
