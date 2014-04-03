#import <ESLocale/StringLocalizer/ESHalfYearLocalizer.h>
#import <Foundation/Foundation.h>

@interface ESHalfYearLocalizerPOD : NSObject<ESHalfYearLocalizer>

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
