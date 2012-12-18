#import "ESDatesToRangeConverter.h"

#import "ESLocaleFactory.h"
#import "NSCalendar+DateAlignment.h"


@implementation ESDatesToRangeConverter
{
@private
    NSDate*     _globalBegin;
    NSDate*     _globalEnd  ;
    NSLocale*   _locale     ;
    NSCalendar* _cal        ;


@private
    NSDate* _tmpBegin;
    NSDate* _tmpEnd  ;
    NSDate* _tmpStartDate;
    NSDate* _tmpEndDate;


@private
    BOOL _isResultValid;
    NSRange _range;
}


static NSCalendarUnit FAKE_CAL_UNIT = static_cast<NSCalendarUnit>( -1 );

-(id)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(id)initWithTimelineStartDate:( NSDate* )globalBegin_
               timelineEndDate:( NSDate* )globalEnd_
                        locale:( NSLocale* )locale_
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }
    
    self->_globalBegin = globalBegin_;
    self->_globalEnd   = globalEnd_  ;
    self->_locale      = locale_     ;
    self->_cal = [ ESLocaleFactory gregorianCalendarWithLocale: self->_locale ];
    
    return self;
}

-(void)setStartDate:( NSDate* )startDate_
{
    self->_startDate = startDate_;
    self->_isResultValid = NO;
}

-(void)setEndDate:( NSDate* )endDate_
{
    self->_endDate = endDate_;
    self->_isResultValid = NO;
}

-(void)setResolution:(ESDateResolution)resolution_
{
    self->_resolution = resolution_;
    self->_isResultValid = NO;
}

-(NSRange)getTimelineRange
{
    if ( !self->_isResultValid )
    {
        [ self calculateDates ];
        self->_isResultValid = YES;
    }
    
    return self->_range;
}

-(void)normalizeGlobalRange
{
    self->_tmpBegin     = [ self->_globalBegin copy ];
    self->_tmpEnd       = [ self->_globalEnd   copy ];
    self->_tmpStartDate = [ self->_startDate   copy ];
    self->_tmpEndDate   = [ self->_endDate     copy ];
    
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
    
    
    {
        tmpBegin_ = [ self->_startDate copy ];
        tmpEnd_   = [ self->_endDate   copy ];
        
        [ self->_cal alignDateRangeFromDate: &tmpBegin_
                                     toDate: &tmpEnd_
                                 resolution: self->_resolution ];
        
        self->_startDate = tmpBegin_;
        self->_endDate   = tmpEnd_  ;
    }
}

-(void)restoreGlobalRange
{
    self->_globalBegin = [ self->_tmpBegin     copy ];
    self->_globalEnd   = [ self->_tmpEnd       copy ];
    self->_startDate   = [ self->_tmpStartDate copy ];
    self->_endDate     = [ self->_tmpEndDate   copy ];
}

-(void)calculateDates
{
    [ self normalizeGlobalRange ];
    
    
    NSInteger rangeBegin_ = [ self intervalsFromDate: self->_globalBegin
                                            tillDate: self->_startDate
                                       forResolution: self->_resolution ];
    
    NSDate* end_ = [ self->_cal dateByAddingTimeIntervals: 1
                                                   toDate: self->_endDate
                                               resolution: ESDayDateResolution ];
    
    NSInteger rangeLength_ = [ self intervalsFromDate: self->_startDate
                                             tillDate: end_
                                        forResolution: self->_resolution ];
    
    if ( rangeBegin_ < 0 || rangeLength_ <= 0 )
    {
        self->_range = { 0, 0 };
    }
    else
    {
        self->_range = NSMakeRange
        (
           static_cast<NSUInteger>( rangeBegin_ ),
           static_cast<NSUInteger>( rangeLength_ )
        );
    }
    
    [ self restoreGlobalRange ];
}

-(NSInteger)intervalsFromDate:( NSDate* )begin_
                     tillDate:( NSDate* )end_
                forResolution:( ESDateResolution )resolution_
{
    NSCalendarUnit component_ = [ [ self class ] unitForResolution: resolution_ ];
    
    NSDateComponents* cPosition_ = [ self->_cal components: component_
                                                  fromDate: begin_
                                                    toDate: end_
                                                   options: 0 ];
    
    switch (resolution_)
    {
        case ESDayDateResolution:
        {
            return cPosition_.day;
            break;
        }
        case ESWeekDateResolution:
        {
            return cPosition_.week;
            break;
        }
        case ESMonthDateResolution:
        {
            return cPosition_.month;
            break;
        }
        case ESQuarterDateResolution:
        {
            static const NSInteger MONTH_IN_QUARTER = 3;
            
            return cPosition_.month / MONTH_IN_QUARTER;
            break;
        }
        case ESHalfYearDateResolution:
        {
            static const NSInteger MONTH_IN_HALF_YEAR = 6;
            
            return cPosition_.month / MONTH_IN_HALF_YEAR;
            break;
        }
        case ESYearDateResolution:
        {
            return cPosition_.year;
            break;
        }

        case ESDateResolutionUndefined:
        default:
        {
            NSAssert( NO, @"[SDFDatesToRangeConverter] : Undefined resolution" );
            break;
        }
    }
    
    return -1;
}

+(NSCalendarUnit)unitForResolution:( ESDateResolution )resolution_
{
    static const NSCalendarUnit units_[] =
    {
        FAKE_CAL_UNIT, // stub
        NSDayCalendarUnit,
        NSWeekCalendarUnit,
        NSMonthCalendarUnit,
        NSMonthCalendarUnit, // quarter
        NSMonthCalendarUnit, // hYear
        NSYearCalendarUnit
    };

    return units_[ resolution_ ];
}

@end
