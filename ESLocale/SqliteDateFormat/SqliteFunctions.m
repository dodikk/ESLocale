#import "SqliteFunctions.h"


#import "SqlLocalizedDateFormatter.h"
#include <assert.h>

void ObjcFormatAnsiDateUsingLocale( sqlite3_context* ctx_, int argc_, sqlite3_value** argv_ )
{
    assert( ctx_ );
    
    @autoreleasepool 
    {
        if ( argc_ != 3 )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - too few parameters", 1 );
            return;
        }
        else if ( NULL == argv_ )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - invalid argv", 2 );
            return;
        }

        const unsigned char* rawFormat_ = sqlite3_value_text( argv_[0] );
        const unsigned char* rawDate_   = sqlite3_value_text( argv_[1] );
        const unsigned char* rawLocaleIdentifier_ = sqlite3_value_text( argv_[2] );

        if ( NULL == rawFormat_ || NULL == rawDate_ || NULL == rawLocaleIdentifier_ )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - NULL argument passed", 3 );
            return;        
        }
        

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

        SqlLocalizedDateFormatter* fmt_ = [ [ SqlLocalizedDateFormatter alloc ] initWithDate: strDate_ 
                                                                                      format: format_ 
                                                                                      locale: localeIdentifier_ ];
        
        NSString* result_ = [ fmt_ getFormattedDate ];
        
        
        if ( nil == result_ || [ result_ isEqualToString: @"" ] )
        {    
            sqlite3_result_null( ctx_ );
        }
        else 
        {
            sqlite3_result_text
            ( 
                ctx_, 
                (const char*)[ result_ cStringUsingEncoding      : NSUTF8StringEncoding ], 
                (int        )[ result_ lengthOfBytesUsingEncoding: NSUTF8StringEncoding ], 
                SQLITE_TRANSIENT 
            );
        }
    }
}
