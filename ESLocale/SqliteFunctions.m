#import "SqliteFunctions.h"

#import <ESLocale/ESLocale.h>
#import <Foundation/Foundation.h>

void ObjcFormatAnsiDate( sqlite3_context* ctx_, int argc_, sqlite3_value** argv_ )
{
    if ( argc_ != 3 )
    {
        sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - too few parameters", 1 );
        return;
    }

    const unsigned char* rawDate_   = sqlite3_value_text( argv_[0] );
    const unsigned char* rawFormat_ = sqlite3_value_text( argv_[1] );
    const unsigned char* rawLocaleIdentifier_ = sqlite3_value_text( argv_[2] );



    NSString* strDate_ = [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawDate_
                                                           length: strlen( (const char*)rawDate_ )
                                                         encoding: NSUTF8StringEncoding
                                                     freeWhenDone: NO ];

    NSString* format_ = [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawFormat_
                                                          length: strlen( (const char*)rawFormat_ )
                                                        encoding: NSUTF8StringEncoding
                                                    freeWhenDone: NO ];

    NSString* localeIdentifier_ = [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawLocaleIdentifier_
                                                        length: strlen( (const char*)rawLocaleIdentifier_ )
                                                      encoding: NSUTF8StringEncoding
                                                  freeWhenDone: NO ];

    NSDateFormatter* ansiFormatter_ = [ ESLocaleFactory posixDateFormatter ];
    ansiFormatter_.dateFormat = @"yyyy-MM-dd";

    NSDate* date_ = [ ansiFormatter_ dateFromString: strDate_ ];
    NSLocale* locale_ = [ [ NSLocale alloc ] initWithLocaleIdentifier: localeIdentifier_ ];

    
    NSDateFormatter* targetFormatter_ = [ ESLocaleFactory gregorianDateFormatterWithLocale: locale_ ];
    targetFormatter_.dateFormat = format_;


    NSString* result_ = [ targetFormatter_ stringFromDate: date_ ];
    sqlite3_result_text
    ( 
        ctx_, 
        (const char*)[ result_ cStringUsingEncoding      : NSUTF8StringEncoding ], 
        (int        )[ result_ lengthOfBytesUsingEncoding: NSUTF8StringEncoding ], 
        SQLITE_TRANSIENT 
    );
}
