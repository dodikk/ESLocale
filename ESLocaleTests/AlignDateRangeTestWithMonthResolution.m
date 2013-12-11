#import <XCTest/XCTest.h>

#import "testDateUtils.h"

#import "ESLocaleFactory.h"

#import "NSCalendar+DateAlignment.h"

@interface AlignDateRangeTestWithMonthResolution : XCTestCase
@end

@implementation AlignDateRangeTestWithMonthResolution

/////////////////// RESULT: Quarter RESOLUTION ///////////////////

-(void)testAlignDates_Sep20_2011_Mar31_2012_toFourMonthResolution
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

/////////////////// RESULT: SEVERAL DAYS ///////////////////

//May 2012
//Su Mo Tu We Th Fr Sa
//      1  2  3  4  5
//6  7  8  9 10 11 12
//13 14 15 16 17 18 19
//20 21 22 23 24 25 26
//27 28 29 30 31
-(void)testAlignDates_May14_2012_May17_2012_toTwoWeekResolution
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

@end
