#ifndef ESLocale_ESDateComponents_h
#define ESLocale_ESDateComponents_h

#import <Foundation/Foundation.h>


/**
A pure C "Plain Old Data" structure for year and quarter.
*/
typedef struct ESYearAndQuarterPOD
{
    NSInteger year;
    NSInteger quarter;
} ESYearAndQuarterPOD;


/**
A pure C "Plain Old Data" structure for year and half year.
*/
typedef struct ESYearAndHalfYearPOD
{
    NSInteger year;
    NSInteger halfYear;
} ESYearAndHalfYearPOD;

#endif


