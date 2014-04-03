#import <Foundation/Foundation.h>

@interface ESUnknownYearModeError : NSError

-(instancetype)initWithYearMode:( NSString* )yearMode;

@property ( nonatomic, readonly ) NSString* actualYearMode;

@end
