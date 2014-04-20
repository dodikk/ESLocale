#import <Foundation/Foundation.h>


/**
A class to safely mock the [NSDate nowDate] method in unit tests.
*/
@interface ESNowDateMock : NSObject

/**
Constructs the mock that will always return the specified date.

@param dateStr_ An ANSI formatted date to return in the [NSDate nowDate] method.

@return A properly initialized mock object.
*/
-(id)initWithAnsiDateString:( NSString* )dateStr_;


/**
Constructs the mock that will always return the specified date.

@param date_ A date to return in the [NSDate nowDate] method.

@return A properly initialized mock object.
*/
-(id)initWithAnsiDate:( NSDate* )date_;


/**
Activates the mock. 
Note : Safe to invoke multiple times.
*/
-(void)enableMock;

/**
Removes the swizzling.
Note : Safe to invoke multiple times.
*/
-(void)disableMock;

@end


