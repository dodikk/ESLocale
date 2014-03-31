#import <ESLocale/SqliteDateFormat/SqlArgumentParsers/ESYearMode.h>
#import <Foundation/Foundation.h>

@interface ESYearModeParser : NSObject

+(ESYearMode)parseYearModeString:( NSString* )yearMode
                           error:( NSError** )outError;

@end
