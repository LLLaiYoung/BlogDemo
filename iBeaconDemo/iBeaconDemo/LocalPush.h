//
//  LocalPush.h
//  iBeaconDemo
//
//  Created by LaiYoung_ on 2018/2/4.
//  Copyright © 2018年 LaiYoung_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface LocalPush : NSObject

/** badge 数量, 默认0 */
@property (nonatomic, assign) NSInteger applicationIconBadgeNumber;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *body;
/** 默认系统声音 */
@property (nonatomic, copy) NSString *soundName;
/** 延时多久执行 */
@property (nonatomic, assign) NSTimeInterval delayTimeInterval;

- (void)pushLocalNotification;

@end
