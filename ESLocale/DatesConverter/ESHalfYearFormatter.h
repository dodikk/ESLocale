#import <ESLocale/SqliteDateFormat/ESDateComponents.h>
#import <Foundation/Foundation.h>


@interface ESHalfYearFormatter : NSObject

-(instancetype)initWithFirstHalfFormat:( NSString* )firstHalfFormat
                      secondHalfFormat:( NSString* )secondHalfFormat
                    shouldTruncateYear:( BOOL )isShortYear;
// NS_DESIGNATED_INITIALIZER
//__attribute__((objc_designated_initializer));


@property ( nonatomic, readonly ) NSString* firstHalfFormat ;
@property ( nonatomic, readonly ) NSString* secondHalfFormat;
@property ( nonatomic, readonly ) BOOL      isShortYear     ;

-(NSString*)stringFromYearAndHalfYear:( ESYearAndHalfYearPOD )dateInfo;

@end

