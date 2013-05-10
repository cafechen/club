//
//  HTTPTools.m
//  ppt
//
//  Created by steven on 12-12-8.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import "HTTPTools.h"
#import "JSONKit.h"
#import "CommonFunc.h"
#import <Foundation/NSProcessInfo.h>

@implementation HTTPTools

static NSString *domain = @"http://42.96.144.219/statusnetadmin/index.php/" ;

static NSString *snDomain = @"http://42.96.144.219/statusnet/index.php/" ;

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

+ (NSString *) sendSNRequestUri:(NSString *)uri Params:(NSDictionary *)params {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", snDomain, uri] ;
    
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

+ (BOOL ) sendMessageHttpUserName: (NSString *)username
                         Password: (NSString *) password
                           Status: (NSString *) status
                           UserId: (NSString *) userId{
    
    //初始化http请求
    
    NSString *post = [[NSString alloc] initWithFormat:@"status=%@&source=%@&userid=%@",status, @"StatusNet iPhone", userId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/api/statuses/update.xml", snDomain]]] ;
    
    [request setTimeoutInterval:10] ;
    
    [request setHTTPMethod:@"POST"];
    
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSString *base64Data = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@:%@", username, password]];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", base64Data];
    
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init] ;
    
    //同步返回请求，并获得返回数据
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        NSLog(@"response success: %d", [urlResponse statusCode]);
        return YES ;
    }else {
        NSLog(@"response failure: %d", [urlResponse statusCode]);
        return NO ;
    }
}

+ (BOOL ) sendMessageImageHttpUserName: (NSString *)username
                              Password: (NSString *) password
                                Status: (NSString *) status
                                UserId: (NSString *)userId
                                 Image: (UIImage *) image{
    
    //初始化http请求
    NSString *urlString = [NSString stringWithFormat:@"%@/api/statuses/update.xml", snDomain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:30] ;
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"0xKhTmLbOuNdArY-F85F345F-63FE-4FF7-AD75-8634E4FD53ED" ;
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSString *base64Data = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@:%@", username, password]];
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", base64Data];
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    //create the post body
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    //status
    [body appendData:[@"Content-Disposition: form-data; name=\"status\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"%@", status] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    //source
    [body appendData:[@"Content-Disposition: form-data; name=\"source\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"%@",@"StatusNet iPhone"] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    //userid
    [body appendData:[@"Content-Disposition: form-data; name=\"userid\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"%@", userId] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    //image
    NSData *imageData = UIImagePNGRepresentation(image);
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"media\"; filename=\"%@\"\r\n",@"1898d833.png"] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    // set the body of the post to the reqeust
    [request setHTTPBody:body];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    //同步返回请求，并获得返回数据
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        NSLog(@"response success: %d", [urlResponse statusCode]);
        return YES ;
    }else {
        NSLog(@"response failure: %d", [urlResponse statusCode]);
        return NO ;
    }
}

+ (NSString *) sendAuthHttpUrl:(NSString *)urlString
                      Method:(NSString *)methodString
                    UserName: (NSString *)username
                    Password: (NSString *) password{
    
    //初始化http请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", snDomain, urlString]]];
    
    [request setHTTPMethod:methodString];
    
    [request setTimeoutInterval:10] ;
    
    NSString *contentType = [NSString stringWithFormat:@"text/json"];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSString *base64Data = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@:%@", username, password]];
    
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", base64Data];
    
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
 
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    return result ;
}

+ (BOOL ) updateProfileImage: (NSString *) username
                    Password: (NSString *) password
                       Image: (UIImage *) image
{
    
    //初始化http请求
    NSString *urlString = [NSString stringWithFormat:@"%@api/account/update_profile_image.as", snDomain];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:30] ;
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"0xKhTmLbOuNdArY-F85F345F-63FE-4FF7-AD75-8634E4FD53ED" ;
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSString *base64Data = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@:%@", username, password]];
    NSString *authorization = [NSString stringWithFormat:@"Basic %@", base64Data];
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    //create the post body
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    //source
    [body appendData:[@"Content-Disposition: form-data; name=\"source\"\r\n\r\n" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"%@",@"StatusNet iPhone"] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    //user
    [body appendData:[@"Content-Disposition: form-data; name=\"user\"\r\n\r\n" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"%@", username] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    //image
    NSData *imageData = UIImagePNGRepresentation(image);
    NSProcessInfo *processInfo=[NSProcessInfo processInfo];
    NSString *filename = [NSString stringWithFormat:@"%@.png", [processInfo globallyUniqueString]] ;
    NSLog(@"filename %@", filename) ;
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n",@"1898d830.png"] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    // set the body of the post to the reqeust
    [request setHTTPBody:body];
    
    NSHTTPURLResponse *urlResponse = nil;
    
    NSError *error = [[NSError alloc] init] ;
    
    //同步返回请求，并获得返回数据
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        NSLog(@"response success: %d", [urlResponse statusCode]);
        return YES ;
    }else {
        NSLog(@"response failure: %d", [urlResponse statusCode]);
        return NO ;
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
