#import "ESNowDateMock.h"

#import "ESLocaleFactory.h"
#import "NSDate+ES_Now.h"

static NSString* MOCK_ANSI_DATE = nil;
static NSDate* MOCK_ANSI_DATE_DATETYPE = nil;
@implementation ESNowDateMock
{
    SEL _realSel;
    SEL _mockSel;
    
    Method _realMethod;
    Method _mockMethod;
    
    BOOL _mockEnabled;
}

-(void)dealloc
{
    [ self disableMock ];
}

-(id)init
{
    // adk - just not to fix lots of existing tests
    return [ self initWithAnsiDateString: @"2012-10-02" ];
}

-(void)setupRuntime
{
    self->_realSel = @selector(nowDate);
    self->_mockSel = @selector(mockNowDate);
    
    self->_realMethod = class_getClassMethod( [ NSDate class ], self->_realSel );
    self->_mockMethod = class_getClassMethod( [ self class ], self->_mockSel );
}

-(id)initWithAnsiDateString:( NSString* )dateStr_
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }

    // adk - do not make an ivar from it
    MOCK_ANSI_DATE = dateStr_;
    [ self setupRuntime ];

    return self;
}

-(id)initWithAnsiDate:( NSDate* )date_
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }
    
    // adk - do not make an ivar from it
    MOCK_ANSI_DATE_DATETYPE = date_;
    [ self setupRuntime ];
    
    self->_mockSel = @selector(mockNowDateDATETYPE);
    self->_mockMethod = class_getClassMethod( [ self class ], self->_mockSel );
    
    
    return self;
}

+(NSDate*)mockNowDateDATETYPE
{
    NSDate* date_ = MOCK_ANSI_DATE_DATETYPE;
    if ( nil == date_ )
    {
        date_ = [NSDate date];
    }
    
    return date_;
}

+(NSDate*)mockNowDate
{
    NSString* date_ = MOCK_ANSI_DATE;
    if ( nil == date_ )
    {
        date_ = @"2012-10-02";
    }
    
    return [ [ ESLocaleFactory ansiDateFormatter ] dateFromString: date_ ];
}

-(void)enableMock
{
    if ( self->_mockEnabled )
    {
        return;
    }
    
    method_exchangeImplementations( self->_realMethod, self->_mockMethod );
    self->_mockEnabled = YES;
}

-(void)disableMock
{
    if ( !self->_mockEnabled )
    {
        return;
    }
    
    method_exchangeImplementations( self->_realMethod, self->_mockMethod );
    self->_mockEnabled = NO;
}

@end
