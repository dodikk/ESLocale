#import "SqliteFunctions.h"


#import "SqlLocalizedDateFormatter.h"
#import "SqlitePersistentDateFormatter.h"


#import "ESHalfYearFormatter.h"
#import "ESDateComponents.h"
#import "ESYearModeParser.h"



void ObjcFormatAnsiDateUsingLocale( sqlite3_context* ctx_, int argc_, sqlite3_value** argv_ )
{
    NSCAssert( ctx_, @"invalid SQLite context" );

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


void ObjcFormatAnsiDateUsingLocale_v2( sqlite3_context* ctx_,int argc_,sqlite3_value** argv_ )
{
    NSCAssert( ctx_, @"invalid SQLite context" );
    
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

        
        SqlitePersistentDateFormatter* fmt_ = [ SqlitePersistentDateFormatter instance ];
        NSString* result_ = nil;
        @synchronized( fmt_ )
        {
            [ fmt_ setFormat: format_
                      locale: localeIdentifier_ ];

            result_ = [ fmt_ getFormattedDate: strDate_ ];
        }
        
        
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



#pragma mark -
#pragma mark manual NSCalendar computations
void ObjcTransformDateUsingLocaleAndSelector( sqlite3_context* ctx_,int argc_,sqlite3_value** argv_, 
                                              SEL transformSelector_ )
{
    NSCAssert( ctx_, @"invalid SQLite context" );
    
    @autoreleasepool 
    {
        if ( argc_ != 2 )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - too few parameters", 1 );
            return;
        }
        else if ( NULL == argv_ )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - invalid argv", 2 );
            return;
        }
        
        const unsigned char* rawDate_             = sqlite3_value_text( argv_[0] );
        const unsigned char* rawLocaleIdentifier_ = sqlite3_value_text( argv_[1] );
        
        if ( NULL == rawDate_ || NULL == rawLocaleIdentifier_ )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - NULL argument passed", 3 );
            return;        
        }

        NSString* strDate_ = [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawDate_
                                                               length: strlen( (const char*)rawDate_ )
                                                             encoding: NSUTF8StringEncoding
                                                         freeWhenDone: NO ];

        NSString* localeIdentifier_ = [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawLocaleIdentifier_
                                                                        length: strlen( (const char*)rawLocaleIdentifier_ )
                                                                      encoding: NSUTF8StringEncoding
                                                                  freeWhenDone: NO ];
        SqlitePersistentDateFormatter* fmt_ = [ SqlitePersistentDateFormatter instance ];
        if ( ![ fmt_ respondsToSelector: transformSelector_ ] )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - bad date transform selector", 4 );
            return;
        }
        
        
        NSString* result_ = nil;
        @synchronized( fmt_ )
        {
            BOOL setupOk_ = [ fmt_ setFormat: nil
                                      locale: localeIdentifier_ ];
            if ( !setupOk_ )
            {
                sqlite3_result_error( ctx_, "Invalid locale error", 5 );
                return;
            }

            typedef NSString* (*TransformMsgSendFunction)( id, SEL, NSString* );
            static const TransformMsgSendFunction transform = (TransformMsgSendFunction)objc_msgSend;
            
            result_ = transform( fmt_, transformSelector_, strDate_ );
        }

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

void ObjcGetYearAndQuarterUsingLocale( sqlite3_context* ctx_,int argc_,sqlite3_value** argv_ )
{
    ObjcTransformDateUsingLocaleAndSelector(ctx_, argc_, argv_, @selector(getYearAndQuarter:) );
}


void ObjcGetYearAndHalfYearUsingLocale( sqlite3_context* ctx_,int argc_,sqlite3_value** argv_ )
{
    NSCAssert( ctx_, @"invalid SQLite context" );
    
    @autoreleasepool
    {
        if ( argc_ != 5 )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - too few parameters", 1 );
            return;
        }
        else if ( NULL == argv_ )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - invalid argv", 2 );
            return;
        }
        
        const unsigned char* rawDate_             = sqlite3_value_text( argv_[0] );
        const unsigned char* rawLocaleIdentifier_ = sqlite3_value_text( argv_[1] );
        const unsigned char* rawFirstHalfFormat_  = sqlite3_value_text( argv_[2] );
        const unsigned char* rawSecondHalfFormat_ = sqlite3_value_text( argv_[3] );
        const unsigned char* rawYearModeString_   = sqlite3_value_text( argv_[4] );
        
        
        BOOL isOneOfArgumentsNull_ =
            NULL == rawDate_             ||
            NULL == rawLocaleIdentifier_ ||
            NULL == rawFirstHalfFormat_  ||
            NULL == rawSecondHalfFormat_ ||
            NULL == rawYearModeString_   ;
        
        if ( isOneOfArgumentsNull_ )
        {
            sqlite3_result_error( ctx_, "ObjcFormatAnsiDate - NULL argument passed", 3 );
            return;
        }
        
        NSString* strDate_ =
        [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawDate_
                                          length: strlen( (const char*)rawDate_ )
                                        encoding: NSUTF8StringEncoding
                                    freeWhenDone: NO ];
        
        NSString* localeIdentifier_ =
        [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawLocaleIdentifier_
                                          length: strlen( (const char*)rawLocaleIdentifier_ )
                                        encoding: NSUTF8StringEncoding
                                    freeWhenDone: NO ];

        NSString* firstHalfFormat_ =
        [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawFirstHalfFormat_
                                          length: strlen( (const char*)rawFirstHalfFormat_ )
                                        encoding: NSUTF8StringEncoding
                                    freeWhenDone: NO ];

        NSString* secondHalfFormat_ =
        [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawSecondHalfFormat_
                                          length: strlen( (const char*)rawSecondHalfFormat_ )
                                        encoding: NSUTF8StringEncoding
                                    freeWhenDone: NO ];
        
        
        NSString* yearModeString_ =
        [ [ NSString alloc ] initWithBytesNoCopy: (void*)rawYearModeString_
                                          length: strlen( (const char*)rawYearModeString_ )
                                        encoding: NSUTF8StringEncoding
                                    freeWhenDone: NO ];
        
        
        NSError* yearModeError = nil;
        ESYearMode yearMode = [ ESYearModeParser parseYearModeString: yearModeString_
                                                               error: &yearModeError ];
        if ( ESYearModeUndefined == yearMode )
        {
            sqlite3_result_error( ctx_, [ yearModeError.localizedDescription cStringUsingEncoding: NSUTF8StringEncoding ], static_cast<int>( yearModeError.code ) );
            return;
        }
        
        
        
        SqlitePersistentDateFormatter* persistentFormatter = [ SqlitePersistentDateFormatter instance ];
        
        BOOL isShortYearMode = ( ESYearModeShort == yearMode );
        ESHalfYearFormatter* halfYearFormatter =
        [ [ ESHalfYearFormatter alloc ] initWithFirstHalfFormat: firstHalfFormat_
                                               secondHalfFormat: secondHalfFormat_
                                             shouldTruncateYear: isShortYearMode ];
        ESYearAndHalfYearPOD dateInfo;
        
        NSString* result_ = nil;
        @synchronized( persistentFormatter )
        {
            BOOL setupOk_ = [ persistentFormatter setFormat: nil
                                                     locale: localeIdentifier_ ];
            if ( !setupOk_ )
            {
                sqlite3_result_error( ctx_, "Invalid locale error", 5 );
                return;
            }

            NSDateFormatter* ansi = persistentFormatter.ansiFormatter;
            NSDate* date = [ ansi dateFromString: strDate_ ];
            if ( nil == date )
            {
                sqlite3_result_null( ctx_ );
                return;
            }

            dateInfo = [ persistentFormatter getYearAndHalfYearPOD: date ];
        }
        
        result_ = [ halfYearFormatter stringFromYearAndHalfYear: dateInfo ];
        
        
        
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
