//
//  HTTPTools.h
//  ppt
//
//  Created by steven on 12-12-8.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPTools : NSObject

+ (NSString *) sendRequestUri:(NSString *)uri Params:(NSDictionary *)params ;
+ (NSString *) sendSNRequestUri:(NSString *)uri Params:(NSDictionary *)params ;

+ (void) describeDictionary:(NSDictionary *)dict ;

+ (BOOL ) sendMessageHttpUserName: (NSString *)username
                         Password: (NSString *) password
                           Status: (NSString *) status
                           UserId: (NSString *)userId;

+ (BOOL ) sendMessageImageHttpUserName: (NSString *)username
                              Password: (NSString *) password
                                Status: (NSString *) status
                                UserId: (NSString *)userId
                                 Image: (UIImage *) image;

@end
