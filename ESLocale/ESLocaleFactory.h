#import <Foundation/Foundation.h>

@interface ESLocaleFactory : NSObject

+(NSLocale*)posixLocale;
+(NSCalendar*)gregorianCalendar;


+(NSCalendar*)posixCalendar;
+(NSDateFormatter*)posixDateFormatter;


@end
