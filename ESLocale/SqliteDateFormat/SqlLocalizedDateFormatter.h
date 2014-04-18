#import <Foundation/Foundation.h>


/**
 A class that ensures correct conversion of the ANSI date format to any given format.
 The locale is used to convert the target date.
 
 This class implements the "command" pattern and caches its results.
 */
@interface SqlLocalizedDateFormatter : NSObject


/**
 Creates an instance of the formatter object and populates it with parameters for lazy evaluation.

 @param strDate_ A date string in ANSI format : "yyyy-MM-dd".
 @param format_  A target format
 @param localeIdentifier_ an identifier of the target locale for formatting.
 Note : The "en_US_POSIX" locale will be used to convert "strDate_" from NSString to NSDate
 
 @return SqlLocalizedDateFormatter instance.
 */
-(id)initWithDate:( NSString* )strDate_
           format:( NSString* )format_
           locale:( NSString* )localeIdentifier_;


/**
 Returns a formatted date.
 
 @return A string of a date in the given format.
 Note : If localeIdentifier_ is invalid then "nil" is returned.
 */
-(NSString*)getFormattedDate;


@end


