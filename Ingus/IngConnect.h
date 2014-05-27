//
//  IngConnect.h
//  Ingus
//
//  Created by brambut on 5/22/14.
//  Copyright (c) 2014 Oleafs Integrasi Mandiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNIRest.h"
#import "IngTodoItem.h"

@interface IngConnect : NSObject

@property NSString *token;
@property NSString *appid;
@property NSString *project;
@property NSString *collection;
@property NSMutableDictionary *param;

- (void)insertToCloud:(NSString *)name;

- (void)setStatus:(NSString *)itemId stat:(NSString *)stat;

- (NSArray *)fetchAll;

- (id) initConfig;

- (id) init;

@end
