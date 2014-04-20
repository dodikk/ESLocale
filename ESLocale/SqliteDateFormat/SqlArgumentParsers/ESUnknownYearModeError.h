#import <Foundation/Foundation.h>


/**
An error of parsing the half year mode SQL function argument
*/
@interface ESUnknownYearModeError : NSError

/**
A designated initializer.

@param yearMode A year mode passed to the SQL function.

@return A properly initialized error object.
*/
-(instancetype)initWithYearMode:( NSString* )yearMode;


/**
A year mode passed to the SQL function.
*/
@property ( nonatomic, readonly ) NSString* actualYearMode;

@end


