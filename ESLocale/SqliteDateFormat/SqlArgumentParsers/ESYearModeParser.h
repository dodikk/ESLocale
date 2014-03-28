#import <Foundation/Foundation.h>

typedef NS_ENUM( NSInteger, ESYearMode )
{
    ESYearModeUndefined = -1,
    ESYearModeShort     =  0,
    ESYearModeLong
};

@interface ESYearModeParser : NSObject

+(ESYearMode)parseYearModeString:( NSString* )yearMode
                           error:( NSError** )outError;

@end
