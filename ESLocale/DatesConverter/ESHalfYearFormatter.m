#import "ESHalfYearFormatter.h"

#import "ESLocaleFactory.h"

@implementation ESHalfYearFormatter

-(instancetype)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}


-(instancetype)initWithFirstHalfFormat:( NSString* )firstHalfFormat
                      secondHalfFormat:( NSString* )secondHalfFormat
                    shouldTruncateYear:( BOOL )isShortYear
{
    NSParameterAssert( 0 != [ firstHalfFormat  length ] );
    NSParameterAssert( 0 != [ secondHalfFormat length ] );
    
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }

    self->_firstHalfFormat  = firstHalfFormat ;
    self->_secondHalfFormat = secondHalfFormat;
    self->_isShortYear      = isShortYear     ;

    return self;
}

-(NSString*)stringFromYearAndHalfYear:( ESYearAndHalfYearPOD )dateInfo
{
    NSString* formatString = nil;
    if ( 1 == dateInfo.halfYear )
    {
        formatString = self->_firstHalfFormat;
    }
    else if ( 2 == dateInfo.halfYear )
    {
        formatString = self->_secondHalfFormat;
    }
    else
    {
        NSAssert1( NO, @"Invalid value of half year : %@", @( dateInfo.halfYear ) );
    }
    
    NSInteger year = dateInfo.year;
    if ( self->_isShortYear )
    {
        static NSInteger const TWO_YEAR_DIGITS = 100;
        year = year % TWO_YEAR_DIGITS;
    }
    
    NSString* strYear = [ NSString stringWithFormat: @"%02ld"    , (long)year ];
    NSString* result  = [ NSString stringWithFormat: formatString, strYear    ];

    return result;
}

@end
