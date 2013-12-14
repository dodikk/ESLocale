[![Build Status](https://secure.travis-ci.org/dodikk/ESLocale.png?branch=master)](http://travis-ci.org/dodikk/ESLocale)

This library contains helper classes to produce correctly formed NSLocale, NSDateFormatter and NSCalendar objects. Such objects are required to parse data that comes from web services as current locale may not match the remote service locale.
Also it contains custom SQLite functions to perform localizef calendar computations in queries.

```
Source Code License          : BSD
Supplement materials license : AFL

```

## Parsing Dates From Network

Typically in order to parse a date string one uses something like the code below :

```objective-c
NSDateFormatter* ansi = [ NSDateFormatter new ];
ansi.dateFormat = @"yyyy-MM-dd"; // ANSI date formatter

NSDate* date = [ ansi dateForString: dateStringFromNetwork ];
```

This approach works only if the locale on the device is the same one as at the back end. However, the locale on the device is subject to change by the user.
This means that locale on both the server and the parser must be set to **en_US_POSIX**.


Proper configuration of *NSDateFormatter* is not as easy as it seems and requires some attention from the programmer. 
```objective-c
NSLocale* posixLocale = [ [ NSLocale alloc ] initWithLocaleIdentifier: @"en_US_POSIX" ];

NSCalendar* gregorianCalendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier: NSGregorianCalendar ];

NSTimeZone* gmtTimezone = [ [ NSTimeZone alloc ] initWithName: @"GMT" ];
[ gregorianCalendar setTimeZone: gmtTimezone  ];
[ gregorianCalendar setLocale: posixLocale ];


NSDateFormatter* ansi = [ NSDateFormatter new ];
ansi.calendar = gregorianCalendar;
ansi.locale = posixLocale;
ansi.timeZone = gmtTimeZone;

// Only now we are ready to go
ansi.dateFormat = @"yyyy-MM-dd"; // ANSI date formatter
NSDate* date = [ ansi dateForString: dateStringFromNetwork ];
```


With ESLocale library it takes only one line.

```objective-c
NSDateFormatter* ansi = [ ESLocaleFactory ansiDateFormatter ];

// Uses en_US_POSIX locale and ANSI date format
NSDate* date = [ ansi dateForString: dateStringFromNetwork ];

```



## A More General Case

The *ESLocaleFactory* class automates creation of a date formatter for any localization requirements :

```objective-c
NSCalendar* russianCalendar = [ ESLocaleFactory gregorianCalendarWithLocaleId: @"ru_RU" ];

NSDateFormatter* russianFormatter = [ NSDateFormatter new ];

[ ESLocaleFactory setCalendar: russianCalendar 
             forDateFormatter: russianFormatter ];
             
russianFormatter.dateFormat = @"dd MM yyyy";
// You are ready to use it
```


