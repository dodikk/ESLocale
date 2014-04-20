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
A designated initializer.

@param
@param
@param

@return
*/
-(instancetype)initWithFirstHalfFormat:( NSString* )firstHalfFormat
                      secondHalfFormat:( NSString* )secondHalfFormat
                    yearTruncationMode:( NSString* )yearTruncationMode;

@property ( nonatomic, readonly ) NSString* formatForFirstHalfYear ;
@property ( nonatomic, readonly ) NSString* formatForSecondHalfYear;
@property ( nonatomic, readonly ) NSString* yearTruncationMode     ;
@property ( nonatomic, readonly ) BOOL      shouldTruncateYear;


+(instancetype)shortEnglishLocalizer;
+(instancetype)longJapaneseLocalizer;

@end







