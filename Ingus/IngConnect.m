//
//  IngConnect.m
//  Ingus
//
//  Created by brambut on 5/22/14.
//  Copyright (c) 2014 Oleafs Integrasi Mandiri. All rights reserved.
//

#import "IngConnect.h"

@implementation IngConnect

- (void)insertToCloud:(NSString *)name
{
    NSLog(name);
    NSString *token = @"5347a1478d909e3e3429f4de";
    NSString *appid = @"537b06808d909ef43f09f015";
    NSString *application = @"ingus";
    NSString *collection = @"todolist";
    NSString *url = @"http://io.nowdb.net/operation/insert";
    
    NSString *post = [NSString
                      stringWithFormat:@"&token=%@&appid=%@&application=%@&collection=%@&collection=%@",
                      token,appid,application,collection,name,FALSE];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];

}


@end
