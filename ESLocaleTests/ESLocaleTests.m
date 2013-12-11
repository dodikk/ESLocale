#import <ESLocale/ESLocale.h>

#import <XCTest/XCTest.h>

@interface ESLocaleTests : XCTestCase

@end

@implementation ESLocaleTests

-(void)testPosixLocaleIdentifier
{
   NSLocale* result_ = [ ESLocaleFactory posixLocale ];
   XCTAssertTrue( [ result_.localeIdentifier isEqualToString: @"en_US_POSIX" ], @"locale identifier mismatch" );
}

-(void)testGregCalendarIdentifier
{
   NSCalendar* result_ = [ ESLocaleFactory gregorianCalendar ];
   XCTAssertTrue( [ result_.calendarIdentifier isEqualToString: NSGregorianCalendar ], @"greg calendar mismatch" );
}

-(void)testPosixCalendarIsGregCalendar
{
   NSCalendar* result_ = [ ESLocaleFactory posixCalendar ];
   XCTAssertTrue( [ result_.calendarIdentifier isEqualToString: NSGregorianCalendar ], @"greg calendar mismatch" );
}

-(void)testPosixCalendarHasPosixLocale
{
   NSCalendar* result_ = [ ESLocaleFactory posixCalendar ];
   XCTAssertTrue( [ result_.locale.localeIdentifier isEqualToString: @"en_US_POSIX" ], @"posix calendar locale mismatch" );
}

-(void)testPosixDateFormatterHasPosixLocale
{
   NSDateFormatter* result_ = [ ESLocaleFactory posixDateFormatter ];
   XCTAssertTrue( [ result_.locale.localeIdentifier isEqualToString: @"en_US_POSIX" ], @"posix formatter locale mismatch" );
}

-(void)testPosixDateFormatterHasPosixCalendar
{
   NSDateFormatter* result_ = [ ESLocaleFactory posixDateFormatter ];

   XCTAssertTrue( [ result_.calendar.locale.localeIdentifier isEqualToString: @"en_US_POSIX" ], @"posix formatter calendar locale mismatch" );
   XCTAssertTrue( [ result_.calendar.calendarIdentifier isEqualToString: NSGregorianCalendar ], @"posix formatter calendar mismatch" );
}

@end
