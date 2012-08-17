#import <Foundation/Foundation.h>

@interface NSDate (DateAlignment)

+(id)dayAlignComponentsToFuture:( BOOL )toFuture_
                           date:( NSDate* )date_
                       calendar:( NSCalendar* )calendar_;

+(id)weekAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_;

+(id)monthAlignComponentsToFuture:( BOOL )toFuture_
                             date:( NSDate* )date_
                         calendar:( NSCalendar* )calendar_;

+(id)quarterAlignComponentsToFuture:( BOOL )toFuture_
                               date:( NSDate* )date_
                           calendar:( NSCalendar* )calendar_;

+(id)halfYearAlignComponentsToFuture:( BOOL )toFuture_
                                date:( NSDate* )date_
                            calendar:( NSCalendar* )calendar_;

+(id)yearAlignComponentsToFuture:( BOOL )toFuture_
                            date:( NSDate* )date_
                        calendar:( NSCalendar* )calendar_;

@end
