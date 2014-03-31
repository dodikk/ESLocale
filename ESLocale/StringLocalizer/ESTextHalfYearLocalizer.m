#import "ESTextHalfYearLocalizer.h"

#import "ESHalfYearLocalizerPOD.h"

@implementation ESTextHalfYearLocalizer
{
    id<ESStringLocalizer>   _localizer;
    ESHalfYearLocalizerPOD* _halfYearLocalizer;
}

-(instancetype)initWithStringLocalizer:( id<ESStringLocalizer> )localizer
                      firstHalfYearKey:( NSString* )firstHalfKey
                     secondHalfYearKey:( NSString* )secondHalfKey
                              yearMode:( ESYearMode )yearMode
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }
    
    self->_localizer = localizer;
    
    
    
    NSString* yearModeString = [ self stringForYearMode: yearMode ];
    NSString* firstHalfFormat  = [ localizer localizedStringForKey: firstHalfKey  ];
    NSString* secondHalfFormat = [ localizer localizedStringForKey: secondHalfKey ];
    
    
    self->_halfYearLocalizer =
    [ [ ESHalfYearLocalizerPOD alloc ] initWithFirstHalfFormat: firstHalfFormat
                                              secondHalfFormat: secondHalfFormat
                                            yearTruncationMode: yearModeString ];
    
    return self;
}

-(NSString*)stringForYearMode:( ESYearMode )yearMode
{
    switch ( yearMode )
    {
        case ESYearModeUndefined:
            return nil;
            break;
            
        case ESYearModeLong:
            return @"long";
            break;
            
        case ESYearModeShort:
            return @"short";
            break;
            
        default:
            return nil;
            break;
    }
}


#pragma mark -
#pragma mark ESStringLocalizer
-(NSString*)localizedStringForKey:( NSString* )key
{
    return [ self->_localizer localizedStringForKey: key ];
}


#pragma mark -
#pragma mark ESHalfYearLocalizer
-(NSString*)formatForFirstHalfYear
{
    return [ self->_halfYearLocalizer formatForFirstHalfYear ];
}

-(NSString*)formatForSecondHalfYear
{
    return [ self->_halfYearLocalizer formatForSecondHalfYear ];
}

-(NSString*)yearTruncationMode
{
    return [ self->_halfYearLocalizer yearTruncationMode ];
}

-(BOOL)shouldTruncateYear
{
    return [ self->_halfYearLocalizer shouldTruncateYear ];
}


@end
