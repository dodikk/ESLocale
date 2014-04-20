#import <ESLocale/StringLocalizer/ESHalfYearLocalizer.h>
#import <Foundation/Foundation.h>


/**
A **plain old data** structure that implements the ESHalfYearLocalizer protocol.
*/
@interface ESHalfYearLocalizerPOD : NSObject<ESHalfYearLocalizer>

/**
Unsupported initializer. Throws an exception.

@return nil if asserts are disabled.
*/
-(instancetype)init;



/**
@param firstHalfFormat  First half year format string. For example, 
* @"%@ 年 上半期"
* @"H1 '%@"

@param secondHalfFormat Second half year format string. For example, 
* @"%@ 年 下半期"
* @"H2 '%@"

@param yearTruncationMode An identifier from the SQL function.
It chould be 'short' or 'long'
Note : year mode is **case insensitive**

@return A properly initialized ESHalfYearLocalizerPOD object.
*/
-(instancetype)initWithFirstHalfFormat:( NSString* )firstHalfFormat
                      secondHalfFormat:( NSString* )secondHalfFormat
                    yearTruncationMode:( NSString* )yearTruncationMode;

/**
  A value passed in the constructor.

  First half year format string. For example, 
* @"%@ 年 上半期"
* @"H1 '%@"

*/
@property ( nonatomic, readonly ) NSString* formatForFirstHalfYear ;

/**
A value passed in the constructor.

Second half year format string. For example, 
* @"%@ 年 下半期"
* @"H2 '%@"

*/
@property ( nonatomic, readonly ) NSString* formatForSecondHalfYear;

/**
An identifier from the SQL function.
It chould be 'short' or 'long'
Note : year mode is **case insensitive**
*/
@property ( nonatomic, readonly ) NSString* yearTruncationMode     ;


/**
A boolean representation of the [ESHalfYearLocalizerPOD yearTruncationMode].
Throws an exception for the invalid format.
*/
@property ( nonatomic, readonly ) BOOL      shouldTruncateYear;


/**
@return A default english formatter

H1 '14
H2 '14
*/
+(instancetype)shortEnglishLocalizer;

/**
@return A default Japanese formatter.

@"2014 年 下半期"
@"2014 年 下半期"
*/
+(instancetype)longJapaneseLocalizer;

@end


