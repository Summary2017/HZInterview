//
//  NSString+Video.h
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Video)

/**
 返回视频的第一张图片

 @param callBlock 网络请求之后, 回传
 @return 链接是否有效
 */
- (BOOL)videoPreViewImageWithBlock:(void (^)(UIImage* image))callBlock;

/** 返回一个正确的URL */ 
- (NSURL *)hg_url;

/** 随机生成的 */ 
+ (NSString*)randomString;

/**
 NSString 转 UIColor
 */
- (UIColor*)rgbColor;

/** 根据秒数转成分：秒 */
+ (NSString *)timeFormatted:(int)totalSeconds;

@end
