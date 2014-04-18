#import <XCTest/XCTest.h>
#import <ESLocale/ESLocale.h>

@interface HalfYearFormatterTest : XCTestCase
@end

@implementation HalfYearFormatterTest
{
    ESHalfYearFormatter* _englishFormatter;
    ESHalfYearFormatter* _japaneseFormatter;
}


-(void)setUp
{
    [ super setUp ];
    
    {
        ESHalfYearLocalizerPOD* hYearConfigEn = [ ESHalfYearLocalizerPOD shortEnglishLocalizer ];
        
        self->_englishFormatter =
        [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: hYearConfigEn.formatForFirstHalfYear
                                               secondHalfFormat: hYearConfigEn.formatForSecondHalfYear
                                             shouldTruncateYear: hYearConfigEn.shouldTruncateYear ];
    }

    {
        ESHalfYearLocalizerPOD* hYearConfigJa = [ ESHalfYearLocalizerPOD longJapaneseLocalizer ];
        
        self->_japaneseFormatter =
        [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: hYearConfigJa.formatForFirstHalfYear
                                               secondHalfFormat: hYearConfigJa.formatForSecondHalfYear
                                             shouldTruncateYear: hYearConfigJa.shouldTruncateYear ];
    }
}

-(void)tearDown
{
    self->_englishFormatter  = nil;
    self->_japaneseFormatter = nil;
    
    [ super tearDown ];
}

-(void)testHalfYearFormatterRejectsInit
{
    XCTAssertThrows
    (
        [ ESHalfYearFormatter new ],
        @"Assert expected"
    );
}

-(void)testFirstHalfFormatIsRequired
{
    XCTAssertThrows
    (
        [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: nil
                                               secondHalfFormat: @"xxx"
                                             shouldTruncateYear: YES ],
         @"assert expected"
    );
    
    XCTAssertThrows
    (
     [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: @""
                                            secondHalfFormat: @"xxx"
                                          shouldTruncateYear: NO ],
     @"assert expected"
     );
}

-(void)testSecondHalfFormatIsRequired
{
    XCTAssertThrows
    (
     [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: @"akk"
                                            secondHalfFormat: nil
                                          shouldTruncateYear: NO ],
     @"assert expected"
     );
    
    XCTAssertThrows
    (
     [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: @"pititi"
                                            secondHalfFormat: @""
                                          shouldTruncateYear: YES ],
     @"assert expected"
     );
}


-(void)testFirstHalfYearEnglish
{
    ESYearAndHalfYearPOD dateInfo = { 2014, 1 };
    
    NSString* expected = @"H1 '14";
    NSString* result = [ self->_englishFormatter stringFromYearAndHalfYear: dateInfo ];
    
    XCTAssertEqualObjects( result, expected, @"Short year format failure" );
}

-(void)testSecondHalfYearEnglish
{
    ESYearAndHalfYearPOD dateInfo = { 2002, 2 };
    
    NSString* expected = @"H2 '02";
    NSString* result = [ self->_englishFormatter stringFromYearAndHalfYear: dateInfo ];
    
    XCTAssertEqualObjects( result, expected, @"Short year format failure" );
}

-(void)testFirstHalfYearJapanese
{
    ESYearAndHalfYearPOD dateInfo = { 2000, 1 };
    
    NSString* expected = @"2000 年 上半期";
    NSString* result = [ self->_japaneseFormatter stringFromYearAndHalfYear: dateInfo ];
    
    XCTAssertEqualObjects( result, expected, @"long year format failure" );
}

-(void)testSecondHalfYearJapanese
{
    ESYearAndHalfYearPOD dateInfo = { 1984, 2 };
    
    NSString* expected = @"1984 年 下半期";
    NSString* result = [ self->_japaneseFormatter stringFromYearAndHalfYear: dateInfo ];
    
    XCTAssertEqualObjects( result, expected, @"long year format failure" );
}

@end
