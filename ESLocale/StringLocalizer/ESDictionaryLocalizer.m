#import "ESDictionaryLocalizer.h"

@implementation ESDictionaryLocalizer
{
@private
    NSDictionary* _localization;
}

-(id)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(id)initWithDictionary:( NSDictionary* )rawLocalization_
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }
    
    self->_localization = rawLocalization_;
    
    return self;
}

-(NSString*)localizedStringForKey:( NSString* )key_
{
    return [ self->_localization objectForKey: key_ ];
}

@end
