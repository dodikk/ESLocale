#import "ESYearModeParser.h"

#import "ESLocaleFactory.h"
#import "ESUnknownYearModeError.h"

@implementation ESYearModeParser

+(ESYearMode)parseYearModeString:( NSString* )yearMode
                           error:( NSError** )outError
{
    NSString* lowercaseMode = [ yearMode lowercaseStringWithLocale: [ ESLocaleFactory posixLocale ] ];
 
    if ( [ lowercaseMode isEqualToString: @"short" ] )
    {
        return ESYearModeShort;
    }
    else if ( [ lowercaseMode isEqualToString: @"long" ] )
    {
        return ESYearModeLong;
    }
    
    
    if ( NULL != outError )
    {
        *outError = [ [ ESUnknownYearModeError alloc ] initWithYearMode: lowercaseMode ];
    }
    return ESYearModeUndefined;
}

@end
