#import "SqlLocalizedDateFormatter.h"

#import <ESLocale/ESLocaleFactory.h>
#import <Foundation/Foundation.h>

@implementation SqlLocalizedDateFormatter
{
@private
    NSString* _strDate;
    NSString* _format;
    NSString* _localeIdentifier;
    
    NSString* _result;
}


-(id)init
{
    [ self doesNotRecognizeSelector: _cmd ];
    return nil;
}

-(id)initWithDate:( NSString* )strDate_
           format:( NSString* )format_
           locale:( NSString* )localeIdentifier_
{
    self = [ super init ];
    if ( nil == self )
    {
        return nil;
    }

    self->_strDate          = strDate_         ;
    self->_format           = format_          ;
    self->_localeIdentifier = localeIdentifier_;

    return self;
}

-(NSString*)doGetFormattedDate
{
    NSString* strDate_          = self->_strDate         ;
    NSString* format_           = self->_format          ;
    NSString* localeIdentifier_ = self->_localeIdentifier;

    
    NSDateFormatter* ansiFormatter_ = [ ESLocaleFactory posixDateFormatter ];
    ansiFormatter_.dateFormat = @"yyyy-MM-dd";
    
    NSDate* date_ = [ ansiFormatter_ dateFromString: strDate_ ];
    NSLocale* locale_ = [ [ NSLocale alloc ] initWithLocaleIdentifier: localeIdentifier_ ];
    
    
    NSDateFormatter* targetFormatter_ = [ ESLocaleFactory gregorianDateFormatterWithLocale: locale_ ];
    targetFormatter_.dateFormat = format_;
    
    
    NSString* result_ = [ targetFormatter_ stringFromDate: date_ ];
    return result_;
}

-(NSString*)getFormattedDate
{
    if ( nil == self->_result ) 
    {
        self->_result = [ self doGetFormattedDate ];
    }

    return self->_result;
}

@end
