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
    NSString* result_ = [ self->_localization objectForKey: key_ ];
    if ( nil == result_ )
    {
        result_ = key_;
    }
    
    return result_;
}

@end
