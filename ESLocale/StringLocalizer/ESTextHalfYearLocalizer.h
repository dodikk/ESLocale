#import <ESLocale/StringLocalizer/ESHalfYearLocalizer.h>
#import <ESLocale/StringLocalizer/ESStringLocalizer.h>
#import <ESLocale/SqliteDateFormat/SqlArgumentParsers/ESYearMode.h>
#import <Foundation/Foundation.h>

@class ESHalfYearLocalizerPOD;


/**
A half year localizer that gets format strings from a given text localizer.
Typically, the source is NSLocalizedString() macro.
*/
@interface ESTextHalfYearLocalizer : NSObject
<
   ESHalfYearLocalizer, 
   ESStringLocalizer
>

/**
Unsupported initializer. Throws an exception.

@return nil if asserts are disabled.
*/
-(instancetype)init;


/**
A designated initializer

@param localizer A key-value storage for localized strings.
@param firstHalfKey a key for the localized first half year format.
@param secondHalfKey a key for the localized second half year format.
@param yearMode ESYearModeShort or ESYearModeLong

@return A properly initialized ESTextHalfYearLocalizer object.
*/
-(instancetype)initWithStringLocalizer:( id<ESStringLocalizer> )localizer
                      firstHalfYearKey:( NSString* )firstHalfKey
                     secondHalfYearKey:( NSString* )secondHalfKey
                              yearMode:( ESYearMode )yearMode;

/**
The storage of the half year format strings.
*/
@property ( nonatomic, readonly ) ESHalfYearLocalizerPOD* halfYearLocalizer;

@end

