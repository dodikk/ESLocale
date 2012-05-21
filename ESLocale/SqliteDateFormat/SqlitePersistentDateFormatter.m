#import "SqlitePersistentDateFormatter.h"

#import "ESLocaleFactory.h"

static const NSInteger yearAndQuarterMask_ = NSQuarterCalendarUnit | 
                                             NSYearCalendarUnit    ;

static const NSInteger yearMonthDayMask_ = NSYearCalendarUnit  | 
                                           NSMonthCalendarUnit |
                                           NSDayCalendarUnit   ;


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
    NSDateComponents* dateComp_ = [ calendar_ components: yearMonthDayMask_ 
                                                           fromDate: date_ ];
    
    
    NSDateComponents* yearBeginDC_ = [ dateComp_ copy ];
    yearBeginDC_.month = 1;
    yearBeginDC_.day   = 1;
    
    NSDateComponents* yearEndDC_ = [ yearBeginDC_ copy ];
    ++yearEndDC_.year;
    
    
    // TODO : fix one day error if required
    
    //    NSDateComponents* minusOneDay_ = [ NSDateComponents new ];
    //    minusOneDay_.day = -1;
    //    NSDate* yearEnd_ = [ self->targetCalendar dateByAddingComponents: minusOneDay_ 
    //                                                              toDate: yearEnd_
    //                                                             options: 0 ];
    
    NSDate* yearEnd_   = [ calendar_ dateFromComponents: yearEndDC_   ]; 
    NSDate* yearBegin_ = [ calendar_ dateFromComponents: yearBeginDC_ ];
    
    NSTimeInterval yearTI_  = [ yearEnd_ timeIntervalSinceDate: yearBegin_ ];
    NSTimeInterval hYearTI_ = yearTI_ / 2.f;
    
    NSTimeInterval dateTI_ = [ date_ timeIntervalSinceDate: yearBegin_ ];
    if ( dateTI_ <= hYearTI_ )
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

-(NSString*)getYearAndQuarter:( NSString* )strDate_
{
    NSDate* date_ = [ self->ansiFormatter dateFromString: strDate_ ];

    NSDateComponents* result_ = [ self->targetCalendar components: yearAndQuarterMask_ 
                                                         fromDate: date_ ];

    return [ NSString stringWithFormat: @"Q%d %d", result_.quarter, result_.year ];
}

-(NSString*)getYearAndHalfYear:( NSString* )strDate_
{
    NSDate* date_ = [ self->ansiFormatter dateFromString: strDate_ ];    
    NSInteger hYear_ = [ [ self class ] halfYearForDate: date_ 
                                          usingCalendar: self->targetCalendar ];

    NSDateComponents* result_ = [ self->targetCalendar components: NSYearCalendarUnit 
                                                         fromDate: date_ ];

    return [ NSString stringWithFormat: @"H%d %d", hYear_, result_.year ];
}

@end
