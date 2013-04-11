#import <Foundation/Foundation.h>

@interface ESNowDateMock : NSObject

-(id)initWithAnsiDateString:( NSString* )dateStr_;
-(id)initWithAnsiDate:( NSDate* )date_;

-(void)enableMock;
-(void)disableMock;

@end
