//
//  Share.h
//  club
//
//  Created by steven on 13-5-10.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Share : NSObject

@property (nonatomic, retain) NSString *msgInboxId;
@property (nonatomic, retain) NSString *msgId;
@property (nonatomic, retain) NSString *msgTitle;
@property (nonatomic, retain) NSString *msgActor;
@property (nonatomic, retain) NSString *msgBody;
@property (nonatomic, retain) NSString *msgTime;
@property (nonatomic, retain) NSString *msgAttach;
@property (nonatomic, retain) NSString *msgUserId;

@end