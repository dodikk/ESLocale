#import <XCTest/XCTest.h>

#import "testDateUtils.h"

#import "ESLocaleFactory.h"

#import "NSCalendar+DateAlignment.h"

@interface AlignDateRangeTestWithHalfYearResolution : XCTestCase
@end

@implementation AlignDateRangeTestWithHalfYearResolution

/////////////////// RESULT: HALF YEAR RESOLUTION ///////////////////

-(void)testAlignDates_May20_2010_May15_2011_toHalfYearResolution
{
    NSDate* startDate_ = dateFromString( @"2010-05-20" );
    NSDate* endDate_   = dateFromString( @"2011-05-15" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESHalfYearDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2010-01-01", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2011-06-30", @"ok" );
}

-(void)testAlignDates_Sep20_2011_Mar19_2012_toOneHalfYearResolution
{
    NSDate* startDate_ = dateFromString( @"2011-09-20" );
    NSDate* endDate_   = dateFromString( @"2012-03-19" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESHalfYearDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2011-07-01", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-06-30", @"ok" );
}

/////////////////// RESULT: QUARTER RESOLUTION ///////////////////

-(void)testAlignDates_Sep20_2011_Mar18_2012_toTwoQuarterResolution
{
    NSDate* startDate_ = dateFromString( @"2011-09-20" );
    NSDate* endDate_   = dateFromString( @"2012-03-18" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESQuarterDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2011-07-01", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-03-31", @"ok" );
}

-(void)testAlignDates_Oct01_2011_Apr01_2012_toOneQuarterResolution
{
    NSDate* startDate_ = dateFromString( @"2012-01-01" );
    NSDate* endDate_   = dateFromString( @"2012-04-01" );
    
    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];
    
    XCTAssertEqual( ESQuarterDateResolution, resolution_, @"ok" );
    
    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );
    
    XCTAssertEqualObjects( startDateStr_, @"2012-01-01", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-06-30", @"ok" );
}

-(void)testAlignDates_Sep20_2011_Mar31_2012_toQuarterResolution
{
    NSDate* startDate_ = dateFromString( @"2011-10-02" );
    NSDate* endDate_   = dateFromString( @"2012-03-30" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESQuarterDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2011-10-01", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-03-31", @"ok" );
}

//May 2012
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testAlignDates_May01_2012_May31_2012_oneMonthResolution
{
    NSDate* startDate_ = dateFromString( @"2012-05-01" );
    NSDate* endDate_   = dateFromString( @"2012-05-31" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESMonthDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2012-05-01", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-05-31", @"ok" );
}

/////////////////// RESULT: WEEK RESOLUTION ///////////////////

//May 2012
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testAlignDates_May02_2012_May24_2012_toTwoWeekResolution
{
    NSDate* startDate_ = dateFromString( @"2012-05-02" );
    NSDate* endDate_   = dateFromString( @"2012-05-24" );
    
    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];
    
    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESWeekDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2012-04-29", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-05-26", @"ok" );
}

//May 2012
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testAlignDates_May13_2012_May19_2012_oneTwoWeekResolution
{
    NSDate* startDate_ = dateFromString( @"2012-05-13" );
    NSDate* endDate_   = dateFromString( @"2012-05-19" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESWeekDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2012-05-13", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-05-19", @"ok" );
}

/////////////////// RESULT: SEVERAL DAYS ///////////////////

//May 2012
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testAlignDates_May14_2012_May17_2012_DayResolution
{
    NSDate* startDate_ = dateFromString( @"2012-05-14" );
    NSDate* endDate_   = dateFromString( @"2012-05-17" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESDayDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2012-05-14", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-05-17", @"ok" );
}

//May 2012
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testAlignDates_May14_2012_May14_2012_DayResolution
{
    NSDate* startDate_ = dateFromString( @"2012-05-14" );
    NSDate* endDate_   = dateFromString( @"2012-05-14" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = [ calendar_ maximumResolutionFromDate: startDate_ toDate: endDate_ ];

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: resolution_ ];

    XCTAssertEqual( ESDayDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    XCTAssertEqualObjects( startDateStr_, @"2012-05-14", @"ok" );
    XCTAssertEqualObjects( endDateStr_  , @"2012-05-14", @"ok" );
}

@end
