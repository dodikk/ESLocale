#import <ESLocale/StringLocalizer/ESStringLocalizer.h>


/**
This class implements the ESStringLocalizer protocol by searching the value in the given dictionary.
*/
@interface ESDictionaryLocalizer : NSObject< ESStringLocalizer >


/**
A designated initializer.

@param rawLocalization_ A dictionary for mock localized strings lookup.

@return The localizer object.
*/
-(id)initWithDictionary:( NSDictionary* )rawLocalization_;


/**
Initializer not supported. Throws an exception when invoked.

@return nil. It should not return unless assertions are disabled.
*/
-(id)init;


/**
Finds the localized value for the given key in the dictionary specified in [ESDictionaryLocalizer initWithDictionary:]

@param key_ A localization key string.

@return rawLocalization_[key_]
*/
-(NSString*)localizedStringForKey:( NSString* )key_;

@end



