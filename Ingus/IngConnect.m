//
//  IngConnect.m
//  Ingus
//
//  Created by brambut on 5/22/14.
//  Copyright (c) 2014 Oleafs Integrasi Mandiri. All rights reserved.
//

#import "IngConnect.h"
#import "IngTodoItem.h"


@implementation IngConnect

- (id) initConfig
{
    self = [super init];
    self.token = @"5347a1478d909e3e3429f4de";
    self.appid = @"537b06808d909ef43f09f015";
    self.project = @"ingus";
    self.collection = @"todo";
    return self;
}

- (id)init
{
    return [self initConfig];
}


- (void)insertToCloud:(NSString *)name
{
    IngTodoItem *item = [[IngTodoItem alloc]init];
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* param = @{@"token" : self.token,
                            @"appid" : self.appid,
                            @"project" : self.project,
                            @"collection" : self.collection,
                            @"name" : name,
                            @"completed" : @"false",
                            @"created_date" : [item getCurrentDate]
                         };

    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:@"http://io.nowdb.net/operation/insert"];
        [request setHeaders:headers];
        [request setParameters:param];
    }] asJson];
    NSDictionary *result = response.body.JSONObject;
    
}

- (NSArray *)fetchAll
{
    NSDictionary* param = @{@"token" : self.token,
                            @"appid" : self.appid,
                            @"project" : self.project,
                            @"collection" : self.collection
                            };
    
    
    UNIHTTPStringResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:@"http://io.nowdb.net/operation/select_all"];
        [request setParameters:param];
    }] asString];
    NSError *err = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response rawBody]
                                                         options: NSJSONReadingMutableContainers
                                                           error: &err];
    return jsonArray;
}

- (void)setStatus:(NSString *)itemId stat:(NSString *)stat
{
    IngTodoItem *item = [[IngTodoItem alloc]init];
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* param = @{@"token" : self.token,
                            @"appid" : self.appid,
                            @"project" : self.project,
                            @"collection" : self.collection,
                            @"id" : itemId,
                            @"completed" : stat,
                            @"completed_date" : [item getCurrentDate]
                            };
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:@"http://io.nowdb.net/operation/update_id"];
        [request setHeaders:headers];
        [request setParameters:param];
    }] asJson];

}
@end
