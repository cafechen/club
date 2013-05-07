//
//  Menu.h
//  pengpengtou
//
//  Created by steven on 13-1-20.
//  Copyright (c) 2013年 steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property (nonatomic, retain) NSString *menuPic;
@property (nonatomic, retain) NSString *menuContent;
@property (nonatomic, retain) NSString *menuType;
@property (nonatomic, retain) NSString *menuName;
@property (nonatomic, retain) NSString *menuCount;
@property (nonatomic, retain) NSMutableArray *menuArray;
@property (nonatomic, retain) NSString *menuGroupId;

@end
