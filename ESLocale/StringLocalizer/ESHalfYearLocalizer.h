#import <Foundation/Foundation.h>

@protocol ESHalfYearLocalizer <NSObject>


/**
 Only year should be parametrized.
 
 @"%@ 年 上半期"  --> @"2014 年 上半期"
 @"H1 ''%@"      --> @"H1 '14"
 
 
 
 Symbols should be escaped.
```
 A string constant is formed by enclosing the string in single quotes ('). A single quote within the string can be encoded by putting two single quotes in a row - as in Pascal. C-style escapes using the backslash character are not supported because they are not standard SQL.
```
 https://www.sqlite.org/lang_expr.html
 
 */
-(NSString*)formatForFirstHalfYear;


/**
 Only year should be parametrized.
 
  @"%@ 年 下半期"  --> @"2014 年 下半期"
  @"H2 ''%@"      --> @"H2 '14"
 
 
 
 Symbols should be escaped.
 ```
 A string constant is formed by enclosing the string in single quotes ('). A single quote within the string can be encoded by putting two single quotes in a row - as in Pascal. C-style escapes using the backslash character are not supported because they are not standard SQL.
 ```
 https://www.sqlite.org/lang_expr.html

 */
-(NSString*)formatForSecondHalfYear;


/**
 "short" or "long". 
 The value is case insensitive.
 */
-(NSString*)yearTruncationMode;


/**
 "YES" if [ESHalfYearLocalizer yearTruncationMode] is "short".
 "NO" if [ESHalfYearLocalizer yearTruncationMode] is "long".

 Throws an exception for anything else.
 */
-(BOOL)shouldTruncateYear;


@end
