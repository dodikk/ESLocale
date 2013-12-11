#import "DatesToRangeConverterTest.h"

#import "ESLocaleFactory.h"
#import "ESDatesToRangeConverter.h"

@implementation DatesToRangeConverterTest
{
    NSDateFormatter* _ansi;
    NSLocale* _posix;
}

-(void)setUp
{
    self->_ansi = [ ESLocaleFactory ansiDateFormatter ];
    self->_posix = [ ESLocaleFactory posixLocale ];
}

-(void)testNegativeRangesAreConvertedToEmptyRange
{
    NSRange result_ = { 100, 500 };
    
    NSDate* begin_ = nil;
    NSDate* end_   = nil;
    
    NSDate* globalBegin_ = nil;
    NSDate* globalEnd_   = nil;
    
    {
        globalBegin_ = [ self->_ansi dateFromString: @"2012-08-06" ];
        globalEnd_   = [ self->_ansi dateFromString: @"2012-12-13" ];
        
        begin_ = [ self->_ansi dateFromString: @"2011-01-01" ];
        end_   = [ self->_ansi dateFromString: @"2012-12-31" ];
        
    
        ESDatesToRangeConverter* convert_ =
        [ [ ESDatesToRangeConverter alloc ] initWithTimelineStartDate: globalBegin_
                                                      timelineEndDate: globalEnd_
                                                               locale: self->_posix ];
        
        convert_.startDate = begin_;
        convert_.endDate   = end_  ;
        convert_.resolution = 5;
        
        result_ = [ convert_ getTimelineRange ];
        XCTAssertTrue( 0 == result_.location, @"invalid range mismatch" );
        XCTAssertTrue( 0 == result_.length  , @"invalid range mismatch" );
    }
}

@end
