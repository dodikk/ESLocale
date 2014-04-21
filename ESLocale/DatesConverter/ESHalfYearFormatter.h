#import <ESLocale/SqliteDateFormat/ESDateComponents.h>
#import <Foundation/Foundation.h>


/**
A class to format first and second half year strings separately.
This is the case for the Japanese language.

H1 '14 ===> @"2014 年 上半期"
H2 '14 ===> @"2014 年 下半期"
*/
@interface ESHalfYearFormatter : NSObject

/**
Unsupported initializer. Throws an exception.

@return nil if asserts are disabled.
*/
-(instancetype)init;

/**
A designated initializer.

@param firstHalfFormat  First half year format string. For example, 
* @"%@ 年 上半期"
* @"H1 '%@"

@param secondHalfFormat Second half year format string. For example, 
* @"%@ 年 下半期"
* @"H2 '%@"

@param isShortYear YES for two digit year.
NO for four digit year.

@return A properly initialized ESHalfYearFormatter object.
*/
-(instancetype)initWithFirstHalfFormat:( NSString* )firstHalfFormat
                      secondHalfFormat:( NSString* )secondHalfFormat
                    shouldTruncateYear:( BOOL )isShortYear;
// NS_DESIGNATED_INITIALIZER
//__attribute__((objc_designated_initializer));



/**
  A value passed in the constructor.

  First half year format string. For example, 
* @"%@ 年 上半期"
* @"H1 '%@"

*/
@property ( nonatomic, readonly ) NSString* firstHalfFormat ;

/**
A value passed in the constructor.

Second half year format string. For example, 
* @"%@ 年 下半期"
* @"H2 '%@"

*/
@property ( nonatomic, readonly ) NSString* secondHalfFormat;

/**
A value passed in the constructor.

YES for two digit year.
NO for four digit year.
*/
@property ( nonatomic, readonly ) BOOL      isShortYear     ;


/**
Converts a struct into a proper half year representation.

@param dateInfo A structure with parsed year and half year.

@return A formatted string 
*/
-(NSString*)stringFromYearAndHalfYear:( ESYearAndHalfYearPOD )dateInfo;

@end

