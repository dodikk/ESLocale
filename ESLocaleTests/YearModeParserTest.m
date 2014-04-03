#import <XCTest/XCTest.h>

#import <ESLocale/ESLocale.h>
#import "ESYearModeParser.h"

@interface YearModeParserTest : XCTestCase
@end


@implementation YearModeParserTest

-(void)testShortFormatIsCaseInsensitive
{
    NSError* error = nil;
    
    ESYearMode result = ESYearModeUndefined;
    
    {
        result = [ ESYearModeParser parseYearModeString: @"short"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeShort == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
    

    {
        result = [ ESYearModeParser parseYearModeString: @"SHORT"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeShort == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
    
    {
        result = [ ESYearModeParser parseYearModeString: @"Short"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeShort == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
    
    
    {
        result = [ ESYearModeParser parseYearModeString: @"shoRT"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeShort == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
}


-(void)testLongFormatIsCaseInsensitive
{
    NSError* error = nil;
    
    ESYearMode result = ESYearModeUndefined;
    
    {
        result = [ ESYearModeParser parseYearModeString: @"long"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeLong == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
    
    
    {
        result = [ ESYearModeParser parseYearModeString: @"LONG"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeLong == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
    
    {
        result = [ ESYearModeParser parseYearModeString: @"Long"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeLong == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
    
    
    {
        result = [ ESYearModeParser parseYearModeString: @"lONg"
                                                  error: &error ];
        XCTAssertTrue( ESYearModeLong == result, @"year mode mismatch" );
        XCTAssertNil( error, @"unexpected error" );
    }
}

-(void)testOtherStringsProduceError
{
    NSError* error = nil;
    ESUnknownYearModeError* castedError = nil;
    
    ESYearMode result = ESYearModeUndefined;
    
    {
        NSString* input = @"do re mi";
        result = [ ESYearModeParser parseYearModeString: input
                                                  error: &error ];
        XCTAssertTrue( ESYearModeUndefined == result, @"year mode mismatch" );
        XCTAssertNotNil( error, @"Error should be returned" );
        
        XCTAssertEqualObjects( error.domain, @"org.ESLocale.YearModeParser", @"domain mismatch" );
        XCTAssertTrue( 1 == error.code, @"code mismatch" );
        
        XCTAssertTrue( [ error isMemberOfClass: [ ESUnknownYearModeError class ] ], @"error class mismatch" );
        castedError = (ESUnknownYearModeError*)error;
        
        XCTAssertEqualObjects( castedError.actualYearMode, input, @"user input mismatch" );
    }

    
    {
        NSString* input = @"hi-hi, ha-ha, ulala";
        result = [ ESYearModeParser parseYearModeString: input
                                                  error: &error ];
        XCTAssertTrue( ESYearModeUndefined == result, @"year mode mismatch" );
        XCTAssertNotNil( error, @"Error should be returned" );
        
        XCTAssertEqualObjects( error.domain, @"org.ESLocale.YearModeParser", @"domain mismatch" );
        XCTAssertTrue( 1 == error.code, @"code mismatch" );
        
        XCTAssertTrue( [ error isMemberOfClass: [ ESUnknownYearModeError class ] ], @"error class mismatch" );
        castedError = (ESUnknownYearModeError*)error;
        
        XCTAssertEqualObjects( castedError.actualYearMode, input, @"user input mismatch" );
    }
}

-(void)testErrorObjectCanBeNull
{
    ESYearMode result = ESYearModeUndefined;
    
    {
        NSString* input = @"do re mi";
        XCTAssertNoThrow
        (
            result = [ ESYearModeParser parseYearModeString: input
                                                      error: NULL ],
             @"unexpected crash"
        );
        XCTAssertTrue( ESYearModeUndefined == result, @"year mode mismatch" );
    }
    
    
    {
        NSString* input = @"hi-hi, ha-ha, ulala";

        XCTAssertNoThrow
        (
         result = [ ESYearModeParser parseYearModeString: input
                                                   error: NULL ],
         @"unexpected crash"
         );
        XCTAssertTrue( ESYearModeUndefined == result, @"year mode mismatch" );
    }
}

@end
