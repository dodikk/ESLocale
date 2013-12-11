#import "ESLocaleFactory.h"
#import "SqlLocalizedDateFormatter.h"

#import <XCTest/XCTest.h>

@interface SqlFormatterTest : XCTestCase

@end

@implementation SqlFormatterTest

-(void)test2011_01_02US
{
    SqlLocalizedDateFormatter* fmt_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: @"2011-01-02"
                                                                                  format: @"YYYY-ww"
                                                                                  locale: @"en_US" ];    
    NSString* result_ = [ fmt_ getFormattedDate ];
    NSString* expected_ = @"2011-02";
    XCTAssertTrue( [ result_ isEqualToString: expected_ ], @"Week mismatch. %@ != %@", result_, expected_ );
}


-(void)test2011_01_02RUS
{
    {
        SqlLocalizedDateFormatter* fmt_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: @"2011-01-02"
                                                                                      format: @"YYYY-ww"
                                                                                      locale: @"ru_RU" ];    
        NSString* result_ = [ fmt_ getFormattedDate ];
        NSString* expected_ = @"2011-01";
        XCTAssertTrue( [ result_ isEqualToString: expected_ ], @"Week mismatch. %@ != %@", result_, expected_ );
    }


    {
        SqlLocalizedDateFormatter* fmt_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: @"2010-12-30"
                                                                                      format: @"YYYY-ww"
                                                                                      locale: @"ru_RU" ];    
        NSString* result_ = [ fmt_ getFormattedDate ];
        NSString* expected_ = @"2011-01";
        XCTAssertTrue( [ result_ isEqualToString: expected_ ], @"Week mismatch. %@ != %@", result_, expected_ );
    }
}

-(void)test2010_12_26BelongsTo2010_RUS
{
    SqlLocalizedDateFormatter* fmt_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: @"2010-12-26"
                                                                                  format: @"YYYY-ww"
                                                                                  locale: @"ru_RU" ];    
    NSString* result_ = [ fmt_ getFormattedDate ];
    NSString* expected_ = @"2010-52";
    XCTAssertTrue( [ result_ isEqualToString: expected_ ], @"Week mismatch. %@ != %@", result_, expected_ );
}

-(void)testFormatterRejectsInit
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
    XCTAssertThrows
    (
        [ [ SqlLocalizedDateFormatter alloc ] init ],
        @"Unexpected init"
    );
#pragma clang diagnostic pop
}

-(void)testFormatterRejectsNilInput
{
    SqlLocalizedDateFormatter* result_ = nil;
    
    
    result_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: nil
                                                          format: @"YYYY-ww"
                                                          locale: @"ru_RU" ];
    XCTAssertNil( result_, @"nil input should not be valid" );
    
    
    result_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: @"2011-01-02"
                                                          format: nil
                                                          locale: @"ru_RU" ];
    XCTAssertNil( result_, @"nil input should not be valid" );
    
    
    result_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: @"2011-01-02"
                                                          format: @"YYYY-ww"
                                                          locale: nil ];
    XCTAssertNil( result_, @"nil input should not be valid" );
}

@end
