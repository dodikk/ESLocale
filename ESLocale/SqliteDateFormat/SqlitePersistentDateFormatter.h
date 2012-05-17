#import <Foundation/Foundation.h>

@interface SqlitePersistentDateFormatter : NSObject

+(SqlitePersistentDateFormatter*)instance;
+(void)freeInstance;

@property ( nonatomic, assign ) BOOL validateLocale ;
@property ( nonatomic, assign ) BOOL checkSameLocale;

-(BOOL)setFormat:( NSString* )dateFormat_
          locale:( NSString* )locale_;

-(NSString*)getFormattedDate:( NSString* )strDate_;

@end
