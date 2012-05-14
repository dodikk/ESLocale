#ifndef __SDDATABASE_SQLITE_FUNCTIONS_H__
#define __SDDATABASE_SQLITE_FUNCTIONS_H__


#ifdef __cplusplus

    #define EXTERN_BEGIN \
    extern "C" \
    {

    #define EXTERN_END }

    #define EXTERN

#else
    #define EXTERN_BEGIN extern
    #define EXTERN_END

    #define EXTERN extern
#endif


#include <sqlite3.h>




   /**
        @param argv_[0] - Date format in Objective-C style as described in http://unicode.org/reports/tr35/tr35-10.html#Date_Format_Patterns
        @param argv_[1] - Date in ANSI format "yyyy-MM-dd"
        @param argv_[2] - locale identifier "en_US"

        @return sqlite3_result_text with formatted date
   */
EXTERN_BEGIN void ObjcFormatAnsiDateUsingLocale( sqlite3_context* ctx_,int argc_,sqlite3_value** argv_ );
EXTERN_END


#endif //__SDDATABASE_SQLITE_FUNCTIONS_H__
