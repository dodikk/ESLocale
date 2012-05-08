#import "ESDatesCalculatorTest.h"
#import <ESLocale/ESLocale.h>

@implementation ESDatesCalculatorTest

-(void)testDatesCalcRejectsInit
{
    STAssertThrows
    (
        [ [ ESDatesCalculator alloc ] init ],
        @"ESDatesCalculator->init must fail"
    );
}

-(void)testDatesCalcRequiresDatesRangeAndStep
{
    ESDatesCalculator* result_ = nil;
    
    {
        result_ = [ [ ESDatesCalculator alloc ] initWithResolution: 1
                                                         startDate: [ NSDate date ]
                                                           endDate: [ NSDate date ] ];
        
        STAssertNotNil( result_, @"valid object expected" );
    }

    {
        STAssertThrows
        (
             [ [ ESDatesCalculator alloc ] initWithResolution: 1
                                                    startDate: nil
                                                      endDate: [ NSDate date ] ],
              @"Assert nil expected"
        );
    }

    {
        STAssertThrows
        (
             [ [ ESDatesCalculator alloc ] initWithResolution: 1
                                                    startDate: [ NSDate date ]
                                                      endDate: nil ],
             @"Assert nil expected"
         );
    }
}

-(void)testDatesCalcZeroResolutionIsForbidden
{
    STAssertThrows
    (
        [ [ ESDatesCalculator alloc ] initWithResolution: 0
                                               startDate: [ NSDate date ]
                                                 endDate: [ NSDate date ] ],
        @"Zero resolution is undefined. ESDatesCalculator can't stand it"
    );
}

-(void)testInitStoresCorrectvalues
{
    ESDatesCalculator* result_ = nil;
    NSDate* beg_ = nil;
    NSDate* fin_ = nil;    
    
    
    NSDateFormatter* df_ = [ ESLocaleFactory posixDateFormatter ];
    df_.dateFormat = @"yyyy-MM-dd";
    
    {
        beg_ = [ df_ dateFromString: @"2011-05-08" ];
        fin_ = [ df_ dateFromString: @"2011-08-24" ];
        
        result_ = [ [ ESDatesCalculator alloc ] initWithResolution: 1
                                                         startDate: beg_
                                                           endDate: fin_ ];
        
        STAssertTrue( 1 == result_.resolution, @"resolution mismatch - %d != %d", 1, result_.resolution );
        STAssertTrue( [ beg_ isEqualToDate: result_.startDate ], @"startDate mismatch - %@ != %@", beg_, result_.startDate );
        STAssertTrue( [ fin_ isEqualToDate: result_.endDate   ], @"endDate   mismatch - %@ != %@", fin_, result_.endDate   );
    }
    
    
    {
        beg_ = [ df_ dateFromString: @"1648-04-29" ];
        fin_ = [ df_ dateFromString: @"2011-10-23" ];
        
        result_ = [ [ ESDatesCalculator alloc ] initWithResolution: 222333222
                                                         startDate: beg_
                                                           endDate: fin_ ];
        
        STAssertTrue( 222333222 == result_.resolution, @"resolution mismatch - %d != %d", 222333222, result_.resolution );
        STAssertTrue( [ beg_ isEqualToDate: result_.startDate ], @"startDate mismatch - %@ != %@", beg_, result_.startDate );
        STAssertTrue( [ fin_ isEqualToDate: result_.endDate   ], @"endDate   mismatch - %@ != %@", fin_, result_.endDate   );
    }    
}

-(void)testStartDateShouldBeLessThanEndDate
{
    NSDate* beg_ = nil;
    NSDate* fin_ = nil;    
    
    
    NSDateFormatter* df_ = [ ESLocaleFactory posixDateFormatter ];
    df_.dateFormat = @"yyyy-MM-dd";
    
    {
        beg_ = [ df_ dateFromString: @"1648-04-29" ];
        fin_ = [ df_ dateFromString: @"2011-10-23" ];
        
        STAssertThrows
        (
             [ [ ESDatesCalculator alloc ] initWithResolution: 222333222
                                                    startDate: fin_
                                                      endDate: beg_ ],
             @"Invalid dates range"
         );
    }  
}

@end
