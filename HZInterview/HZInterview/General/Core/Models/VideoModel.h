//
//  VideoModel.h
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef WeakSelf
#define WeakSelf __weak typeof(self) weakSelf = self;
#endif

#ifndef StrongSelf
#define StrongSelf __typeof__(weakSelf) self = weakSelf;
#endif

// 记录URL是否有效
typedef NS_ENUM(NSInteger, URLState) {
    /** 未知 */
    URLStateUnkown,
    /** 无效 */
    URLStateInvalid,
    /** 有效 */
    URLStateEffective,
    /** 请求中 */
    URLStateNetWorkIng,
    /** 请求结束 */
    URLStateNetWorkFinish
};

@interface VideoModel : NSObject

/** 视频链接 */
@property (nonatomic, copy) NSString* urlStr;

/** 视频标题 */
@property (nonatomic, copy) NSString* name;


/**
 在正常开发中, 上面都是网络的数据. 但是往往在处理一些逻辑的时候, 需要我们自定义一些辅助的自定义属性
 */
#pragma mark -
#pragma mark - 自定义属性
/** 链接的性质 */
@property (nonatomic, assign, readonly) URLState urlState;
/** 说略图 */
@property (nonatomic, strong, readonly) UIImage* thumbnail;
/** 需要网络请求的时候, 在网络请求返回的时候, 需要实时的显示出来 */
@property (nonatomic, copy) void (^reloadCell)(VideoModel* reloadModel);

@end
