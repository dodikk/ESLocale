#import <ESLocale/StringLocalizer/ESHalfYearLocalizer.h>
#import <ESLocale/StringLocalizer/ESStringLocalizer.h>
#import <ESLocale/SqliteDateFormat/SqlArgumentParsers/ESYearMode.h>
#import <Foundation/Foundation.h>

@class ESHalfYearLocalizerPOD;

@interface ESTextHalfYearLocalizer : NSObject<ESHalfYearLocalizer, ESStringLocalizer>

-(instancetype)initWithStringLocalizer:( id<ESStringLocalizer> )localizer
                      firstHalfYearKey:( NSString* )firstHalfKey
                     secondHalfYearKey:( NSString* )secondHalfKey
                              yearMode:( ESYearMode )yearMode;

@property ( nonatomic, readonly ) ESHalfYearLocalizerPOD* halfYearLocalizer;

@end
