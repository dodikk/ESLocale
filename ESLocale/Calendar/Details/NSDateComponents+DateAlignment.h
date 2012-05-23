#import <Foundation/Foundation.h>

@interface NSDateComponents (DateAlignment)

-(void)weekAlignToFuture:( BOOL )toFuture_
                calendar:( NSCalendar* )calendar_;

-(void)monthAlignToFuture:( BOOL )toFuture_
                 calendar:( NSCalendar* )calendar_;

-(void)halfYearAlignToFuture:( BOOL )toFuture_
                    calendar:( NSCalendar* )calendar_;

-(void)yearAlignToFuture:( BOOL )toFuture_
                calendar:( NSCalendar* )calendar_;

@end
