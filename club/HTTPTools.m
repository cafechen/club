//
//  HTTPTools.m
//  ppt
//
//  Created by steven on 12-12-8.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import "HTTPTools.h"
#import "JSONKit.h"
#import <Foundation/NSProcessInfo.h>

@implementation HTTPTools

static NSString *domain = @"http://42.96.144.219/statusnetadmin/index.php/" ;

+ (NSString *) sendRequestUri:(NSString *)uri Params:(NSDictionary *)params {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", domain, uri] ;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    [request setTimeoutInterval:5] ;
    
    [request setHTTPMethod:@"POST"];
    
    //根据传入的参数拼请求体
    NSString *post = @"";
    
    NSArray *keys;
    int i, count;
    id key, value;
    keys = [params allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [params objectForKey: key];
        if(i == 0){
            post = [[NSString alloc] initWithFormat:@"%@=%@", key, value] ;
        }else{
            post = [[NSString alloc] initWithFormat:@"%@&%@=%@", post, key, value] ;
        }
    }
    
    NSLog(@"Send Request %@?%@", urlString, post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        //NSLog(@"response success: %d %@", [urlResponse statusCode], result);
        return result ;
    }else {
        NSLog(@"response failure: %d", [urlResponse statusCode]);
        return result ;
    }
    
}

+ (void) describeDictionary: (NSDictionary *)dict
{
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}

@end
