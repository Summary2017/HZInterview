//
//  NSString+Video.m
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import "NSString+Video.h"
#import <AVFoundation/AVFoundation.h>

@implementation NSString (Video)

/** 返回视频的第一张图片 */
- (BOOL)videoPreViewImageWithBlock:(void (^)(UIImage *))callBlock {
    // 无效 url 返回
    if (!self.hg_url) {
        return NO;
    }
    
    // 开始异步下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // 开始
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.hg_url options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *img = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程
            if (callBlock) {
                callBlock(img);
            }
        });
    });
    
    // 链接有效, 正在下载中
    return YES;
}

// 返回一个正确的URL
- (NSURL *)hg_url
{
    //    [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"]];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}

/** 随机生成的 */
+ (NSString*)randomString
{
//    NSString* uuid = [NSString stringWithFormat:@"%f_%@_随机生成", [NSDate date].timeIntervalSince1970, [NSUUID UUID].UUIDString];
    NSString* uuid = [NSString stringWithFormat:@"随机生成_%@", [NSUUID UUID].UUIDString];
    return uuid;
}

/**
 NSString 转 UIColor
 */
- (UIColor*)rgbColor {
    
    if (self.length == 6) {
        
        NSInteger red = strtol([self substringWithRange:NSMakeRange(0, 2)].UTF8String, NULL, 16);
        NSInteger green = strtol([self substringWithRange:NSMakeRange(2, 2)].UTF8String, NULL, 16);
        NSInteger blue = strtol([self substringWithRange:NSMakeRange(4, 2)].UTF8String, NULL, 16);
        
        return [UIColor colorWithRed:(red)/255.0f green:(green)/255.0f blue:(blue)/255.0f alpha:1.0];
    }
    
    return [UIColor clearColor];
}

// 根据秒数转成分：秒
+ (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

@end
