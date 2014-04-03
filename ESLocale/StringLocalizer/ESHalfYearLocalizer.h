#import <Foundation/Foundation.h>


/**
A protocol to configure half year localization workflow.
*/
@protocol ESHalfYearLocalizer <NSObject>


/**
Format for the first half of the year.
Only year should be parametrized.
 
 @"%@ 年 上半期"  --> @"2014 年 上半期"
 @"H1 '%@"      --> @"H1 '14"
 
 
 
 Symbols are not escaped. 
 They should be escaped manually prior to using in sqlite queries.
 
 ```
 A string constant is formed by enclosing the string in single quotes ('). A single quote within the string can be encoded by putting two single quotes in a row - as in Pascal. C-style escapes using the backslash character are not supported because they are not standard SQL.
```
 https://www.sqlite.org/lang_expr.html
 
 */
-(NSString*)formatForFirstHalfYear;


/**
Format for the second half of the year.
 Only year should be parametrized.
 
  @"%@ 年 下半期"  --> @"2014 年 下半期"
  @"H2 '%@"      --> @"H2 '14"
 
 
 
 Symbols are not escaped.
 They should be escaped manually prior to using in sqlite queries.

 ```
 A string constant is formed by enclosing the string in single quotes ('). A single quote within the string can be encoded by putting two single quotes in a row - as in Pascal. C-style escapes using the backslash character are not supported because they are not standard SQL.
 ```
 https://www.sqlite.org/lang_expr.html

 */
-(NSString*)formatForSecondHalfYear;


/**
Year truncation mode to use in SQL functions.
The value is case insensitive.

@return "short" or "long".
 */
-(NSString*)yearTruncationMode;


/**
A boolean value for [ESHalfYearLocalizer yearTruncationMode]

@return
 "YES" if [ESHalfYearLocalizer yearTruncationMode] is "short".
 "NO" if [ESHalfYearLocalizer yearTruncationMode] is "long".

 Throws an exception for anything else.
 */
-(BOOL)shouldTruncateYear;


@end




