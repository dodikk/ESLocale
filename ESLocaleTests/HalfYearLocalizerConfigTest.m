#import <XCTest/XCTest.h>
#import <ESLocale/ESLocale.h>


@interface HalfYearLocalizerConfigTest : XCTestCase

@end


@implementation HalfYearLocalizerConfigTest

-(void)testLocalizerConfigRejectsInit
{
    XCTAssertThrows
    (
        [ ESHalfYearLocalizerPOD new ],
        @"assert expected"
    );
}

-(void)testLocalizerConfigRequiresFirstHalfFormat
{
    XCTAssertThrows
    (
     [[ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: nil
                                              secondHalfFormat: @"x"
                                            yearTruncationMode: @"short" ],
     @"assert expected"
     );
}


-(void)testLocalizerConfigRequiresSecondHalfFormat
{
    XCTAssertThrows
    (
     [[ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: @"z"
                                              secondHalfFormat: nil
                                            yearTruncationMode: @"long" ],
     @"assert expected"
     );
}

-(void)testLocalizerConfigRequiresYearMode
{
    XCTAssertThrows
    (
     [[ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: @"z"
                                              secondHalfFormat: @"x"
                                            yearTruncationMode: nil ],
     @"assert expected"
     );
}

-(void)testShortMode
{
    ESHalfYearLocalizerPOD* config =
    [[ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: @"H1 '%@"
                                             secondHalfFormat: @"H2 '%@"
                                           yearTruncationMode: @"short" ];
    
    XCTAssertTrue( [ config shouldTruncateYear ], @"short mode mismatch" );
}

-(void)testLongMode
{
    ESHalfYearLocalizerPOD* config =
    [[ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: @"H1 '%@"
                                             secondHalfFormat: @"H2 '%@"
                                           yearTruncationMode: @"long" ];
    
    XCTAssertFalse( [ config shouldTruncateYear ], @"short mode mismatch" );
}

-(void)testOtherModesCauseCrash
{
    ESHalfYearLocalizerPOD* config =
    [[ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: @"H1 '%@"
                                             secondHalfFormat: @"H2 '%@"
                                           yearTruncationMode: @"non existing mode" ];
    
    XCTAssertThrows( [ config shouldTruncateYear ], @"assert expected" );
    
}

@end
