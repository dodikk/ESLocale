#import "ESUnknownYearModeError.h"

@implementation ESUnknownYearModeError

-(instancetype)initWithYearMode:(NSString *)yearMode
{
    self =  [ super initWithDomain: @"org.ESLocale.YearModeParser"
                              code: 1
                          userInfo: nil ];
    if ( nil == self )
    {
        return nil;
    }
    
    self->_actualYearMode = yearMode;
    
    return self;
}

-(instancetype)initWithDomain:(NSString *)domain
                         code:(NSInteger)code
                     userInfo:(NSDictionary *)dict
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(instancetype)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

@end
