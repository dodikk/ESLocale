#import <Foundation/Foundation.h>

/**
A protocol that wraps the NSLocalizedString() macro to use it in libraries.

It may be used for mocking localization in unit tests and abstracting from the NSLocalizedString() macro. It may be useful to implement "localization in runtime" feature and other cool stuff.
*/
@protocol ESStringLocalizer <NSObject>


@required
/**
A method to return the localized string for a given key.


@param key_ A localization key. In most cases it is a key in the "*.strings" file.


@return A localized string that will be displayed to the user.
*/
-(NSString*)localizedStringForKey:( NSString* )key_;

@end


