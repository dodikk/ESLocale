//
//  DateFormatterExample.m
//  
//
//  Created by Oleksandr Dodatko on 18/09/2012.
//  Copyright (c) 2012 Embedded Sources. All rights reserved.
//


#import "DateFormatterExample.h"
#import <Foundation/Foundation.h>

@implementation DateFormatterExample

-(NSDate*)parseDate:( NSDate* )date_
{
   NSDateFormatter* df_ = [ NSDateFormatter new ];
   result_.dateFormat = @"yyyy-MM-dd";
   
   
}

@end
