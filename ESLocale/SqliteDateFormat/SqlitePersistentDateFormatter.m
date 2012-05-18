#import "SqlitePersistentDateFormatter.h"

#import "ESLocaleFactory.h"

static SqlitePersistentDateFormatter* instance_ = nil;


@implementation SqlitePersistentDateFormatter
{
@private
    NSDateFormatter* ansiFormatter  ;
    NSDateFormatter* targetFormatter;
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
        isOtherLocale_ = [ self->targetFormatter.locale.localeIdentifier isEqualToString: locale_ ];
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


        NSCalendar* cal_ = [ ESLocaleFactory gregorianCalendarWithLocaleId: locale_ ];       
        
        self->targetFormatter = [ NSDateFormatter new ];
        [ ESLocaleFactory setCalendar: cal_ 
                     forDateFormatter: self->targetFormatter ];  
    }
    
    self->targetFormatter.dateFormat = dateFormat_;

    return YES;
}

-(NSString*)getFormattedDate:( NSString* )strDate_;
{
    NSDate*   date_   = [ self->ansiFormatter   dateFromString: strDate_ ];
    NSString* result_ = [ self->targetFormatter stringFromDate: date_    ];

    return result_;
}

@end
