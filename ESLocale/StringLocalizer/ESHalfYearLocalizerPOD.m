#import "ESHalfYearLocalizerPOD.h"

@implementation ESHalfYearLocalizerPOD


-(instancetype)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(instancetype)initWithFirstHalfFormat:( NSString* )firstHalfFormat
                      secondHalfFormat:( NSString* )secondHalfFormat
                    yearTruncationMode:( NSString* )yearTruncationMode
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }

    self->_formatForFirstHalfYear  = firstHalfFormat   ;
    self->_formatForSecondHalfYear = secondHalfFormat  ;
    self->_yearTruncationMode      = yearTruncationMode;
    
    return self;
}

#pragma mark -
#pragma mark Factory methods
+(instancetype)shortEnglishLocalizer
{
    return [ [ [ self class ] alloc ] initWithFirstHalfFormat: @"H1 '%@"
                                             secondHalfFormat: @"H2 '%@"
                                           yearTruncationMode: @"short" ];
}

+(instancetype)longJapaneseLocalizer
{
    return [ [ [ self class ] alloc ] initWithFirstHalfFormat: @"%@ 年 上半期"
                                             secondHalfFormat: @"%@ 年 下半期"
                                           yearTruncationMode: @"long" ];
}

@end
