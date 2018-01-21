//
//  VideoModel.m
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import "VideoModel.h"
#import "NSString+Video.h"

@interface VideoModel ()

/** 链接的性质 */
@property (nonatomic, assign) URLState urlState;
/** 说略图 */
@property (nonatomic, strong) UIImage* thumbnail;

@end

@implementation VideoModel

- (instancetype)init {
    self = [super init];
    
    // 默认值
    if (arc4random()%2) {
        // 公司给的一个URL
        self.urlStr = @"http://ozulb30b8.bkt.clouddn.com/201801191000538471794.mp4";
    } else {
        // 这是我的 自传
        self.urlStr = @"https://image1.drugs360.cn/lmzTXqykHAyfQvN4v2x0ENfPHc_O.mp4";
    }
    
    self.name = [NSString randomString];
    
    return self;
}

#pragma mark - lazy
- (URLState)urlState {
    // _urlState 的默认值是 URLStateUnkown, 也就是 0
    if (!_urlState) {
        _urlState = self.urlStr.hg_url?URLStateEffective:URLStateInvalid;
    }
    return _urlState;
}


- (UIImage *)thumbnail {
    
    if (!_thumbnail && (self.urlState == URLStateEffective)) {
        // 设置成请求中
        self.urlState = URLStateNetWorkIng;
        // 没有值, 则要通过网络请求获取
        [self.urlStr videoPreViewImageWithBlock:^(UIImage *image) {
            // 设置返回的数据
            _thumbnail = image;
            
            // 设置成氢气结束或者无效  其实这里请求image没有值的情况, 不一定是url无效,也有可能是网络的问题
            // 当快速滚动的时候, 请求会出错, 是因为请求太多了.
//            self.urlState = image?URLStateNetWorkFinish:URLStateInvalid;
            
            // 所以这里为了防止快速滚动, 就直接在出错的时候, 赋值为 URLStateEffective 为了下一次还能有机会请求
            self.urlState = image?URLStateNetWorkFinish:URLStateEffective;
            
            
            // 要实时的刷新Cell的显示
            if (_thumbnail && self.reloadCell) {
                self.reloadCell(self);
            }
        }];
    }
    
    // 如果有值的话, 就直接返回显示出来
    return _thumbnail;
}

@end
