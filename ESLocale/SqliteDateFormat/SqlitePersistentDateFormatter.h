#import <Foundation/Foundation.h>

@interface SqlitePersistentDateFormatter : NSObject

+(SqlitePersistentDateFormatter*)instance;
+(void)freeInstance;

@property ( nonatomic, assign ) BOOL validateLocale ;
@property ( nonatomic, assign ) BOOL checkSameLocale;

-(BOOL)setFormat:( NSString* )dateFormat_
          locale:( NSString* )locale_;

-(NSString*)getFormattedDate:( NSString* )strDate_;   //throw()
-(NSString*)getYearAndQuarter:( NSString* )strDate_;  //throw()
-(NSString*)getYearAndHalfYear:( NSString* )strDate_; //throw()

+(NSInteger)halfYearForDate:( NSDate* )date_
              usingCalendar:( NSCalendar* )calendar_; //throw()

@end
