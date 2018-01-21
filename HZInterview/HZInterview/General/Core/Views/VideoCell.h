//
//  VideoCell.h
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;

@interface VideoCell : UITableViewCell

// 数据
@property (nonatomic, strong) VideoModel* videoModel;


#pragma mark -
#pragma mark - 以下方法, 在实际项目中是专门有基类的.封装了很多的方法,比如UIButton, UIView....常用的视图, 都有.
/**
 返回一个Cell实例, 通常用于XIB
 
 @param tableView 当前表视图视图
 @return 返回Cell
 */
+ (instancetype)xibCell:(UITableView*)tableView;

@end
