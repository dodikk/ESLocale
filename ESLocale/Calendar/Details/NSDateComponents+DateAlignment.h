#import <Foundation/Foundation.h>

@interface NSDateComponents (DateAlignment)

-(void)weekAlignToFuture:( BOOL )toFuture_;

-(void)monthAlignToFuture:( BOOL )toFuture_;

-(void)halfYearAlignToFuture:( BOOL )toFuture_;

-(void)yearAlignToFuture:( BOOL )toFuture_;

@end
