//
//  Message.m
//  ssq
//
//  Created by steven on 13-4-30.
//  Copyright (c) 2013年 letoke. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (NSString *) getErrorMessageFromErrorCode:(NSString *) errorCode {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSDictionary *messages = [NSDictionary dictionaryWithContentsOfFile:plistPath] ;
    NSString *errorMessage = (NSString *)([messages objectForKey:errorCode]) ;
    if(errorMessage == nil){
        errorMessage = @"服务器未知错误" ;
    }
    return errorMessage ;
}

@end
