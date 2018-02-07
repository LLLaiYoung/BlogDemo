//
//  LocalPush.m
//  iBeaconDemo
//
//  Created by LaiYoung_ on 2018/2/4.
//  Copyright © 2018年 LaiYoung_. All rights reserved.
//

#import "LocalPush.h"

static NSString * const kUseDefaultSoundName = @"useDefaultSoundName";

@implementation LocalPush

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.applicationIconBadgeNumber = 0;
        self.soundName = kUseDefaultSoundName;
        self.delayTimeInterval = 0.0;
    }
    return self;
}

- (void)pushLocalNotification {
    if (!([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.alertTitle = self.title;
        localNotification.alertBody = self.body;
        localNotification.soundName = [self.soundName isEqualToString:kUseDefaultSoundName] ? UILocalNotificationDefaultSoundName : self.soundName;
        
        NSDate *trigger = [NSDate dateWithTimeIntervalSinceNow:self.delayTimeInterval];
        localNotification.fireDate = trigger;
        localNotification.timeZone = [NSTimeZone localTimeZone];
        
        if (self.applicationIconBadgeNumber > 0) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = self.applicationIconBadgeNumber;
        }
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    } else {
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = self.title;
            content.body = self.body;
            content.sound = [self.soundName isEqualToString:kUseDefaultSoundName] ? [UNNotificationSound defaultSound] : [UNNotificationSound soundNamed:self.soundName];
            if (self.applicationIconBadgeNumber > 0) {
                [UIApplication sharedApplication].applicationIconBadgeNumber = self.applicationIconBadgeNumber;
            }
            UNTimeIntervalNotificationTrigger *trigger = nil;
            if (self.delayTimeInterval > 0) {
                trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:self.delayTimeInterval repeats:NO];
            }
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:NSStringFromClass(self.class) content:content trigger:trigger];
            
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                
            }];
        } else {
            // Fallback on earlier versions
        }
    }
}

@end
