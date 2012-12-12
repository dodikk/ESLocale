#import <Foundation/Foundation.h>
#import <ESLocale/Calendar/ESDateResolutionType.h>

@interface ESRangeToDatesConverter : NSObject

// dates must be aligned
-(id)initWithTimelineStartDate:( NSDate* )globalBegin_
               timelineEndDate:( NSDate* )globalEnd_
                    resolution:( ESDateResolution )resolution_
                        locale:( NSLocale* )locale_;

@property ( nonatomic ) NSRange timelineRange;

-(NSDate*)getStartDate;
-(NSDate*)getEndDate;

@end
