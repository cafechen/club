//
//  HTTPTools.h
//  ppt
//
//  Created by steven on 12-12-8.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPTools : NSObject

+ (NSDictionary *) sendRequestUri:(NSString *)uri Params:(NSDictionary *)params ;

+ (void) describeDictionary:(NSDictionary *)dict ;

@end
