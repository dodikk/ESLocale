//
//  WeekBasedNewYearTest.m
//  ESLocaleTest
//
//  Created by Oleksandr Dodatko on 11/25/13.
//  Copyright (c) 2013 dodikk. All rights reserved.
//

@interface WeekBasedNewYearTest : GHTestCase
@end

@implementation WeekBasedNewYearTest
{
    NSCalendar     * _cal   ;
    NSLocale       * _locale;
    NSDateFormatter* _df    ;
    
    NSDateFormatter* _ansi;
    
    NSDate* _date;
}


-(void)setUp
{
    [ super setUp ];

    self->_ansi = [ ESLocaleFactory ansiDateFormatter ];
    self->_date = [ self->_ansi dateFromString: @"2010-12-27" ];
    
    self->_locale = [ NSLocale localeWithLocaleIdentifier: @"ru_RU" ];
    self->_cal = [ ESLocaleFactory gregorianCalendarWithLocale: self->_locale ];
    
    self->_df = [ NSDateFormatter new ];
    [ ESLocaleFactory setCalendar: self->_cal
                 forDateFormatter: self->_df ];
}

-(void)tearDown
{
    self->_cal    = nil;
    self->_locale = nil;
    self->_df     = nil;
    
    [ super tearDown ];
}

-(void)testRussianFormatter
{
    [ self->_cal setMinimumDaysInFirstWeek: 4 ];
    
    NSCalendarUnit unit_ = NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;
    NSDateComponents* components_ = [ self->_cal components: unit_
                                                   fromDate: self->_date ];
    
    GHAssertTrue( 2010 == [ components_ yearForWeekOfYear ], @"year mismatch" );
}


-(void)testRussianCalendar
{
    static const NSUInteger MONDAY = 2;
    GHAssertTrue( MONDAY == [ self->_cal firstWeekday ], @"first weekday mismatch" );
    
    GHAssertTrue( 4 == [ self->_cal minimumDaysInFirstWeek ], @"first week rule mismatch" );
}

-(void)testAnsiCalendar
{
    static const NSUInteger SUNDAY = 1;
    GHAssertTrue( SUNDAY == [ self->_ansi.calendar firstWeekday ], @"first weekday mismatch" );
    
    GHAssertTrue( 1 == [ self->_ansi.calendar minimumDaysInFirstWeek ], @"first week rule mismatch" );
}

@end
