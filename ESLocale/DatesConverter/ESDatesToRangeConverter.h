#import <Foundation/Foundation.h>
#import <ESLocale/Calendar/ESDateResolutionType.h>

@interface ESDatesToRangeConverter : NSObject

// dates must be aligned
-(id)initWithTimelineStartDate:( NSDate* )globalBegin_
               timelineEndDate:( NSDate* )globalEnd_
                        locale:( NSLocale* )locale_;

@property ( nonatomic ) NSDate* startDate;
@property ( nonatomic ) NSDate* endDate  ;
@property ( nonatomic ) ESDateResolution resolution;

-(NSRange)getTimelineRange;

@end
