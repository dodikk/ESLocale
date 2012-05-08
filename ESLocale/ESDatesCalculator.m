#import "ESDatesCalculator.h"
#import "ESLocaleFactory.h"

@implementation ESDatesCalculator
{
@private
    NSInteger _resolution;
    NSDate*   _startDate ;
    NSDate*   _endDate   ;    
}

@synthesize resolution = _resolution;
@synthesize startDate  = _startDate ;
@synthesize endDate    = _endDate   ;


-(id)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(id)initWithResolution:( NSInteger )resolution_
              startDate:( NSDate* )startDate_
                endDate:( NSDate* )endDate_
{
    BOOL resolutionOk_ = ( 0 != resolution_  );
    BOOL startDateOk_  = ( nil != startDate_ );
    BOOL endDateOk_    = ( nil != endDate_   );
    BOOL dateRangeOk_  = ( NSOrderedDescending != [ startDate_ compare: endDate_ ] );

    NSParameterAssert( resolutionOk_ );
    NSParameterAssert( startDateOk_  );
    NSParameterAssert( endDateOk_    );
    NSParameterAssert( dateRangeOk_  );
    if ( !resolutionOk_ || !startDateOk_ || !endDateOk_ || !dateRangeOk_ )
    {
        return nil;
    }
    

    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }

    self->_resolution = resolution_;
    self->_startDate  = startDate_ ;
    self->_endDate    = endDate_   ;

    return self;
}

@end
