#import <ESLocale/StringLocalizer/ESStringLocalizer.h>

/**
An implementation of ESStringLocalizer protocol that does nothing.
It is used mostly for unit testing.
*/
@interface ESStringLocalizerStub : NSObject< ESStringLocalizer >


/**
This implementation does nothing and returns the key as is.


@param key Localization key string.

@return key.
*/
-(NSString*)localizedStringForKey:( NSString* )key;

@end


