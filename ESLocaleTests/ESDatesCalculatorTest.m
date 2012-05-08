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

@end
