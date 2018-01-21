//
//  VideoCell.m
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"

@interface VideoCell ()

// 缩略图
@property (weak, nonatomic) IBOutlet UIImageView *thuImageView;
// 标题
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation VideoCell

- (void)setVideoModel:(VideoModel *)videoModel {
    _videoModel = videoModel;
    // 标题
    _nameLabel.text = videoModel.name;
    
    // 先赋值 reloadCell
    WeakSelf
    _videoModel.reloadCell = ^(VideoModel *reloadModel) {
        StrongSelf
        // 这个判断不能少, 因为重用+子线程获取图片
        if (self.videoModel == reloadModel) {
            self.thuImageView.image = reloadModel.thumbnail;
        }
    };
    
    if (_videoModel.thumbnail) {
        // 直接赋值
        _thuImageView.image = _videoModel.thumbnail;
    } else {
        // 占位图
        _thuImageView.image = [UIImage imageNamed:@"placeholder"];
    }
}


#pragma mark -
#pragma mark - 以下方法, 在实际项目中是专门有基类的.封装了很多的方法,比如UIButton, UIView....常用的视图, 都有.
/** 快速获取cell */
+ (instancetype)xibCell:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    VideoCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

@end
