#import <ESLocale/StringLocalizer/ESStringLocalizer.h>


/**
This class implements the ESStringLocalizer protocol bu invoking the NSLocalizedString() macro.
*/
@interface ESStringLocalizer_Apple : NSObject< ESStringLocalizer >


/**
A method to return the localized string for a given key.

@param key_ A localization key from the Localizable.strings file.

@return NSLocalizedString( key_, nil )
*/
-(NSString*)localizedStringForKey:( NSString* )key_;

@end



