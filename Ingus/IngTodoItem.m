//
//  IngTodoItem.m
//  Ingus
//
//  Created by brambut on 5/20/14.
//  Copyright (c) 2014 Oleafs Integrasi Mandiri. All rights reserved.
//

#import "IngTodoItem.h"

@implementation IngTodoItem

- (NSString *)getCurrentDate
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    formatter.timeZone = destinationTimeZone;
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mma"];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
