//
//  ListController.m
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import "ListController.h"
#import "VideoCell.h"
#import "VideoModel.h"
#import "VideoController.h"

@interface ListController ()

// 数据
@property (nonatomic, strong) NSMutableArray* datas;

@end

@implementation ListController

#pragma mark - lazy
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        
        for (NSInteger i=0; i<50; i++) {
            VideoModel* videoModel = [VideoModel new];
            [_datas addObject:videoModel];
        }
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取Cell（重用在方法内部实现）
    VideoCell* cell = [VideoCell xibCell:tableView];
    // 赋值
    cell.videoModel = self.datas[indexPath.row];
    // 返回
    return cell;
    
    // 说明: 再复杂的Cell, 都应该只有上面上个步骤:获取, 赋值, 返回
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 创建播放控制器
    VideoController* videoVC = [[VideoController alloc] init];
    
    // 传值
    VideoCell* cell = (VideoCell*)[tableView cellForRowAtIndexPath:indexPath];
    videoVC.videoModel = cell.videoModel;
    [self.navigationController pushViewController:videoVC animated:YES];
}

@end
