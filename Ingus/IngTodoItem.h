//
//  IngTodoItem.h
//  Ingus
//
//  Created by brambut on 5/20/14.
//  Copyright (c) 2014 Oleafs Integrasi Mandiri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IngTodoItem : NSObject

@property NSString *dataId;
@property NSString *itemName;
@property BOOL completed;
@property NSDate *creationDate;
@property NSDate *completedDate;

- (NSString *)getCurrentDate;

@end
