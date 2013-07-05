#import "NSDateComponents+Constants.h"

@implementation NSDateComponents (Constants)

+(NSDateComponents*)getAddOneDayComponents
{
    static NSDateComponents* addOneDay_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        addOneDay_ = [ NSDateComponents new ];
        addOneDay_.day = 1;
    } );

    return addOneDay_;
}

+(NSDateComponents*)getAddOneMonthComponents
{
    static NSDateComponents* addOneMonth_;
    
    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
                  {
                      addOneMonth_ = [ NSDateComponents new ];
                      addOneMonth_.month = 1;
                  } );
    
    return addOneMonth_;
}

+(NSDateComponents*)getAddOneYearComponents
{
    static NSDateComponents* addOneYear_;
    
    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
                  {
                      addOneYear_ = [ NSDateComponents new ];
                      addOneYear_.year = 1;
                  } );
    
    return addOneYear_;
}

+(NSDateComponents*)getSubtractOneDayComponents
{
    static NSDateComponents* subtractOneDay_;

    static dispatch_once_t onceToken_;
    dispatch_once( &onceToken_, ^
    {
        subtractOneDay_ = [ NSDateComponents new ];
        subtractOneDay_.day = -1;
    } );

    return subtractOneDay_;
}

@end
