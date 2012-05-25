#import "SqlitePersistentDateFormatter.h"

#import "ESLocaleFactory.h"

#include <utility>

typedef std::pair<NSInteger, NSInteger> ESYearAndQuarter ;
typedef std::pair<NSInteger, NSInteger> ESYearAndHalfYear;

#define QUARTER_UNIT_DOES_NOT_WORK

static const NSInteger yearAndQuarterMask_ = NSQuarterCalendarUnit | 
                                             NSYearCalendarUnit    ;

static const NSInteger yearMonthMask_ = NSYearCalendarUnit  | 
                                        NSMonthCalendarUnit ;

static SqlitePersistentDateFormatter* instance_ = nil;


@implementation SqlitePersistentDateFormatter
{
@private
    NSDateFormatter* ansiFormatter  ;
    NSDateFormatter* targetFormatter;
    NSCalendar*      targetCalendar ;
}

@synthesize validateLocale ;
@synthesize checkSameLocale;

#pragma mark -
#pragma mark Singletone
+(SqlitePersistentDateFormatter*)instance
{
    if ( nil == instance_ )
    {
        @synchronized ( self )
        {
            if ( nil == instance_ )
            {
                instance_ = [ SqlitePersistentDateFormatter new ];
            }
        }
    }

    return instance_;
}

+(void)freeInstance
{
    @synchronized ( self )
    {
        instance_ = nil;
    }
}

-(id)init
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }
    
    self->ansiFormatter = [ ESLocaleFactory ansiDateFormatter ];
    
    return self;
}



#pragma mark -
#pragma mark LazyLoad
-(BOOL)setFormat:( NSString* )dateFormat_
          locale:( NSString* )locale_
{
    NSParameterAssert( nil != locale_ );
    
    BOOL isNoFormatter_ = ( nil == self->targetFormatter );
    BOOL isOtherLocale_ = NO;
    if ( self.checkSameLocale )
    {
        isOtherLocale_ = ![ self->targetFormatter.locale.localeIdentifier isEqualToString: locale_ ];
    }
    
    
    if ( isNoFormatter_ || isOtherLocale_ )
    {
        if ( self.validateLocale ) 
        {
            NSArray* validlocaleIdentifiers_ = [ NSLocale availableLocaleIdentifiers ];
            if ( ![ validlocaleIdentifiers_ containsObject: locale_ ] )
            {
                NSLog( @"Invalid locale error" );
                return NO;
            }
        }        

        NSLog( @"SqlitePersistentDateFormatter : Locale mismatch - setting a new one" );
        self->targetCalendar = [ ESLocaleFactory gregorianCalendarWithLocaleId: locale_ ];       
        
        self->targetFormatter = [ NSDateFormatter new ];
        [ ESLocaleFactory setCalendar: self->targetCalendar 
                     forDateFormatter: self->targetFormatter ];  
    }
    
    if ( nil != dateFormat_ )
    {
        self->targetFormatter.dateFormat = dateFormat_;
    }

    return YES;
}

+(NSInteger)halfYearForDate:( NSDate* )date_
              usingCalendar:( NSCalendar* )calendar_
{
    // This class must not throw ever
    if ( nil == date_ ) 
    {
        return -1;
    }
    else if ( nil == calendar_ )
    {
        return -2;
    }


    NSDateComponents* dateComp_ = [ calendar_ components: yearMonthMask_ 
                                                fromDate: date_ ];
    

    // Gregorian calendar hard code
    
    static const NSInteger june_ = 6;
    if ( dateComp_.month <= june_ )
    {
        return 1;
    }
    else 
    {
        return 2;
    }

    return 0;
}


#pragma mark -
#pragma mark Getters
-(NSString*)getFormattedDate:( NSString* )strDate_
{
    NSDate*   date_   = [ self->ansiFormatter   dateFromString: strDate_ ];
    NSString* result_ = [ self->targetFormatter stringFromDate: date_    ];

    return result_;
}


-(ESYearAndQuarter)getRawYearAndQuarter:( NSDate* )date_
{
    // http://openradar.appspot.com/9270112       
    //    NSQuarterCalendarUnit does not work
    //Originator:	victor.jalencas	
    //Number:	rdar://9270112	Date Originated:	2011-04-12
    //Status:	Open	Resolved:	
    //Product:	iPhone SDK	Product Version:	4.2
    //Classification:	Other bug	Reproducible:	Always        
#ifdef QUARTER_UNIT_DOES_NOT_WORK
    
    //gregorian calendar hard code
    NSDateComponents* result_ = [ self->targetCalendar components: yearMonthMask_ 
                                                         fromDate: date_ ];    
    
    
    static const NSInteger monthsInQuarter_ = 3;
    NSInteger quarter_ = (result_.month - 1) / monthsInQuarter_;
    NSInteger quarterStartingWithOne_ = 1 + quarter_;    
#else
    NSDateComponents* result_ = [ self->targetCalendar components: yearAndQuarterMask_ 
                                                         fromDate: date_ ];
    
    NSInteger quarterStartingWithOne_ = 1 + result_.quarter;
#endif

    
    ESYearAndQuarter ret_;
    ret_.first = result_.year;
    ret_.second = quarterStartingWithOne_;
    
    return ret_;
}

-(ESYearAndHalfYear)getRawYearAndHalfYear:( NSDate* )date_
{
    NSInteger hYear_ = [ [ self class ] halfYearForDate: date_ 
                                          usingCalendar: self->targetCalendar ];
    
    NSDateComponents* result_ = [ self->targetCalendar components: NSYearCalendarUnit 
                                                         fromDate: date_ ];
    
    ESYearAndHalfYear ret_;
    ret_.first = result_.year;
    ret_.second = hYear_;
    
    return ret_;
}


-(NSString*)getYearAndQuarter:( NSString* )strDate_
{
    NSDate* date_ = [ self->ansiFormatter dateFromString: strDate_ ];
    if ( nil == date_ )
    {
        return nil;
    }
    
    ESYearAndQuarter result_ = [ self getRawYearAndQuarter: date_ ];
    
    NSInteger shortYear_ = result_.first % 100;
    return [ NSString stringWithFormat: @"Q%d '%02d", result_.second, shortYear_ ];
}

-(NSString*)getYearAndHalfYear:( NSString* )strDate_
{
    NSDate* date_ = [ self->ansiFormatter dateFromString: strDate_ ];
    if ( nil == date_ )
    {
        return nil;
    }
    
    ESYearAndHalfYear result_ = [ self getRawYearAndHalfYear: date_ ];
    NSInteger shortYear_ = result_.first % 100;
    
    return [ NSString stringWithFormat: @"H%d '%02d", result_.second, shortYear_ ];
}

-(NSString*)getFullYearAndQuarter:( NSString* )strDate_  //throw()
{
    NSDate* date_ = [ self->ansiFormatter dateFromString: strDate_ ];
    if ( nil == date_ )
    {
        return nil;
    }
    
    ESYearAndQuarter result_ = [ self getRawYearAndQuarter: date_ ];
    return [ NSString stringWithFormat: @"%d-%d", result_.first, result_.second ];
}

-(NSString*)getFullYearAndHalfYear:( NSString* )strDate_ //throw()
{
    NSDate* date_ = [ self->ansiFormatter dateFromString: strDate_ ];
    if ( nil == date_ )
    {
        return nil;
    }

    ESYearAndHalfYear result_ = [ self getRawYearAndHalfYear: date_ ];
    return [ NSString stringWithFormat: @"%d-%d", result_.first, result_.second ];
}

@end
