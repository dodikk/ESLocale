#import <Foundation/Foundation.h>

#import <ESLocale/SqliteDateFormat/ESDateComponents.h>


/**
A core class for ObjcFormatAnsiDateUsingLocale_v2() function.
Caches an instance of NSDateFormatter and updates its settings if params change since the previous call.

Implemented as a singleton to be custom SQLite function friendly.
Still, you can instantiate it directly.

Warning: The methods are **not thread safe** unless explicitly documented.
*/
@interface SqlitePersistentDateFormatter : NSObject

/**
A preferred initializer to use in SQL functions.
The method is thread-safe.

@return A shared instance of the SqlitePersistentDateFormatter singleton.
*/
+(SqlitePersistentDateFormatter*)instance;

/**
Deallocates a shared instance of the SqlitePersistentDateFormatter singleton.
The method is thread-safe.
*/
+(void)freeInstance;



/**
A boolean flag to enable/disable locale identifier validation in the  [SqlitePersistentDateFormatter setFormat:locale:] method.

YES - safe but slow.
NO  - fast but requires correct input.
*/
@property ( nonatomic ) BOOL validateLocale ;


/**
A boolean flag to enable/disable the locale identifier **change** check in the  [SqlitePersistentDateFormatter setFormat:locale:] method.

YES - locale identifier validation is performed only on locale change.
NO  - locale identifier validation is performed at each locale object assignment.
*/
@property ( nonatomic ) BOOL checkSameLocale;




/**
An instance of the ANSI date formatter. See [ESLocaleFactory ansiDateFormatter] for details.
*/
@property ( nonatomic, readonly ) NSDateFormatter* ansiFormatter  ;

/**
An instance of the target formatter configured by the [SqlitePersistentDateFormatter setFormat:locale:] method. 
*/
@property ( nonatomic, readonly ) NSDateFormatter* targetFormatter;

/**
Configures the [SqlitePersistentDateFormatter targetFormatter] object.
Performs locale validation as specified by the flags below :

* [SqlitePersistentDateFormatter validateLocale]
* [SqlitePersistentDateFormatter checkSameLocale]

@param dateFormat_ Format string for the [SqlitePersistentDateFormatter targetFormatter] object. It should follow the same rules as [NSDateFormatter dateFormat] property.

@param locale_ A locale identifier for the [SqlitePersistentDateFormatter targetFormatter] object.


@return YES for successfull NSDateFormatter initialization.
NO in case locale identifier validation failed.
*/
-(BOOL)setFormat:( NSString* )dateFormat_
          locale:( NSString* )locale_;

/**
Applies the specified date format to a given ANSI date string.

@param strDate_ A date in ANSI format.

@return A date in the target format specified in the [SqlitePersistentDateFormatter setFormat:locale:] method.
*/
-(NSString*)getFormattedDate:( NSString* )strDate_;   //throw()


/**
Applies quarter and short year formatting.
For example, "Q4 '14"

Warning : the format is **hard coded**

@param strDate_ A date in ANSI format.

@return A formatted date.
*/
-(NSString*)getYearAndQuarter:( NSString* )strDate_;  //throw()


/**
Applies half year and **short year** formatting.
For example, "H2 '14"

Warning : the format is **hard coded**

@param strDate_ A date in ANSI format.

@return A formatted date.
*/
-(NSString*)getYearAndHalfYear:( NSString* )strDate_; //throw()


/**
Applies quarter and **short year** formatting.
For example, "Q4 '14"

Warning : the format is **hard coded**

@param strDate_ A date in ANSI format.

@return A formatted date.
*/
-(NSString*)getYearAndQuarter:( NSString* )strDate_;  //throw()


/**
Applies half year and **long year** formatting.
For example, "H2 '2014"

Warning : the format is **hard coded**

@param strDate_ A date in ANSI format.

@return A formatted date.
*/
-(NSString*)getHalfYearAndFullYearFromDate:( NSDate* )date_; //throw()


/**
An utility function to get a half year from a given date.
This method does not throw any exceptions.

@param date_ A date to retrieve the half year.
@param calendar_ A properly configured calendar for splitting the date into components.

@return "1" or "2" for valid input.
-1 - for nil date_ object
-2 - for nil calendar_ object
*/
+(NSInteger)halfYearForDate:( NSDate* )date_
              usingCalendar:( NSCalendar* )calendar_; //throw()


/**
Applies quarter and **long year** formatting.
For example, "Q4 '2014"

Warning : the format is **hard coded**

@param strDate_ An NSDate object.

@return A formatted date.
*/
-(NSString*)getQuarterAndFullYearFromDate:( NSDate* )date_;  //throw()


/**
Applies quarter and **long year** formatting.
For example, "Q4 '2014"

Warning : the format is **hard coded**

@param strDate_ A date in ANSI format.

@return A formatted date.
*/
-(NSString*)getQuarterAndFullYear:( NSString* )strDate_;  //throw()

/**
A sorting friendly representation of the half year information.
For example : "2014-2"  (For "H2 '2014")

@param strDate_ A date in ANSI format.

@return A formatted date.
*/
-(NSString*)getFullYearAndHalfYear:( NSString* )strDate_; //throw()


/**
Parses year and quarter information into a C structure that can be formatted in any format supported by this class.

@param date_ An NSDate object to format.

@return A POD structure with parsed info.
*/
-(ESYearAndQuarterPOD)getYearAndQuarterPOD:( NSDate* )date_;


/**
Parses year and half year information into a C structure that can be formatted in any format supported by this class.

@param date_ An NSDate object to format.

@return A POD structure with parsed info.
*/
-(ESYearAndHalfYearPOD)getYearAndHalfYearPOD:( NSDate* )date_;

@end


