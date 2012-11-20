#import <Foundation/Foundation.h>

@protocol ESStringLocalizer <NSObject>

@required
-(NSString*)localizedStringForKey:( NSString* )key_;

@end
