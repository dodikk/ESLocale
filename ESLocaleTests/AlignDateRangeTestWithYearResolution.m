#import <SenTestingKit/SenTestingKit.h>

#import "testDateUtils.h"

#import "ESLocaleFactory.h"

#import "NSCalendar+DateAlignment.h"

@interface AlignDateRangeTestWithYearResolution : SenTestCase
@end

@implementation AlignDateRangeTestWithYearResolution

//STODO test asserts

-(void)testAlignDates_May20_2010_May15_2011_toHalfYear
{
    NSDate* startDate_ = dateFromString( @"2010-05-20" );
    NSDate* endDate_   = dateFromString( @"2011-05-15" );

    NSCalendar* calendar_ = [ ESLocaleFactory gregorianCalendar ];
    ESDateResolution resolution_ = ESYearDateResolution;

    [ calendar_ alignDateRangeFromDate: &startDate_
                                toDate: &endDate_
                            resolution: &resolution_ ];

    STAssertEquals( ESHalfYearDateResolution, resolution_, @"ok" );

    NSString* startDateStr_ = stringFromDate( startDate_ );
    NSString* endDateStr_   = stringFromDate( endDate_ );

    STAssertEqualObjects( startDateStr_, @"2010-07-01", @"ok" );
    STAssertEqualObjects( endDateStr_  , @"2010-12-31", @"ok" );
}

@end
