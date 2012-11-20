#import "ESStringLocalizer_Apple.h"

@implementation ESStringLocalizer_Apple

-(NSString*)localizedStringForKey:( NSString* )key_
{
    return NSLocalizedString( key_, nil );
}

@end
