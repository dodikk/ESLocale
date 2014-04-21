#import <ESLocale/SqliteDateFormat/SqlArgumentParsers/ESYearMode.h>
#import <Foundation/Foundation.h>



/**
A class to convert the error mode string from SQL function to the ESYearMode enum.
*/
@interface ESYearModeParser : NSObject


/**
A method to convert the error mode string from SQL function to the ESYearMode enum.

@param yearMode year mode strin from the SQL function.

@param outError An output parameter NSError object. Accepts NULL although we recommend handling all errors.

@return ESYearModeUndefined if parsing failed.
ESYearModeShort or ESYearModeLong otherwise.
*/
+(ESYearMode)parseYearModeString:( NSString* )yearMode
                           error:( NSError** )outError;

@end


