//
//  VideoPlayerView.h
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CloseBlock)(void);

@interface VideoPlayerView : UIView

/** 视频文件路径 */
@property (nonatomic, copy) NSString *filePath;
/** 第一帧图片 */
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, copy) CloseBlock closeBlock;

// 销毁播放器方法
- (void)destroyPlayer;

@end
