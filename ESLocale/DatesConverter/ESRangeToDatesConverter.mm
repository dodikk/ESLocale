#import "ESRangeToDatesConverter.h"

#import "ESLocaleFactory.h"
#import "NSCalendar+DateAlignment.h"

@implementation ESRangeToDatesConverter
{
@private
    NSDate*     _globalBegin;
    NSDate*     _globalEnd  ;
    NSInteger   _resolution ;
    NSLocale*   _locale     ;
    NSCalendar* _cal        ;

@private
    NSDate* _tmpBegin;
    NSDate* _tmpEnd  ;

    
@private
    NSDate* _begin;
    NSDate* _end  ;
    
@private
    BOOL _isResultValid;
}


-(id)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(id)initWithTimelineStartDate:( NSDate* )globalBegin_
               timelineEndDate:( NSDate* )globalEnd_
                    resolution:( ESDateResolution )resolution_
                        locale:( NSLocale* )locale_
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }
    
    self->_globalBegin = globalBegin_;
    self->_globalEnd   = globalEnd_  ;
    self->_resolution  = resolution_ ;
    self->_locale      = locale_     ;
    self->_cal = [ ESLocaleFactory gregorianCalendarWithLocale: self->_locale ];
    
    return self;
}

-(void)setTimelineRange:(NSRange)timelineRange_
{
    self->_timelineRange = timelineRange_;
    self->_isResultValid = NO;
}

-(NSDate*)getStartDate
{
    if ( !self->_isResultValid )
    {
        [ self calculateDates ];
        self->_isResultValid = YES;
    }
    
    return self->_begin;
}

-(NSDate*)getEndDate
{
    if ( self->_isResultValid )
    {
        [ self calculateDates ];
        self->_isResultValid = YES;
    }
    
    return self->_end;
}

-(void)normalizeGlobalRange
{
    self->_tmpBegin = [ self->_globalBegin copy ];
    self->_tmpEnd   = [ self->_globalEnd   copy ];
    
    NSDate* tmpBegin_ = nil;
    NSDate* tmpEnd_   = nil;
    
    // adk - just for sure
    {
        tmpBegin_ = [ self->_globalBegin copy ];
        tmpEnd_   = [ self->_globalEnd   copy ];
        
        [ self->_cal alignDateRangeFromDate: &tmpBegin_
                                     toDate: &tmpEnd_
                                 resolution: self->_resolution ];
        
        self->_globalBegin = tmpBegin_;
        self->_globalEnd   = tmpEnd_  ;
    }
}

-(void)restoreGlobalRange
{
    self->_globalBegin = [ self->_tmpBegin copy ];
    self->_globalEnd   = [ self->_tmpEnd   copy ];
}

-(void)calculateDates
{
    [ self normalizeGlobalRange ];
    
    
    self->_begin = [ self->_cal dateByAddingTimeIntervals: static_cast<NSInteger>( self->_timelineRange.location )
                                             toDate: self->_globalBegin
                                         resolution: self->_resolution ];
    
    self->_end = [ self->_cal dateByAddingTimeIntervals: static_cast<NSInteger>( self->_timelineRange.length )
                                           toDate: self->_begin
                                       resolution: self->_resolution ];
    
    self->_end = [ self->_cal dateByAddingTimeIntervals: -1
                                           toDate: self->_end
                                       resolution: ESDayDateResolution ];
    
    [ self restoreGlobalRange ];
}

@end
