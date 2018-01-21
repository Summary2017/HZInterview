//
//  VideoController.m
//  HZInterview
//
//  Created by  ZhuHong on 2018/1/20.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

#import "VideoController.h"
#import "VideoPlayerView.h"
#import "VideoModel.h"

@interface VideoController ()

@property (nonatomic, strong) VideoPlayerView *playerView;

@end

@implementation VideoController

#pragma mark - lazy
- (VideoPlayerView *)playerView
{
    if (_playerView == nil)
    {
        _playerView = [[VideoPlayerView alloc] init];
        _playerView.frame = [UIScreen mainScreen].bounds;
        _playerView.filePath = self.videoModel.urlStr?:@"http://ozulb30b8.bkt.clouddn.com/201801191000538471794.mp4";
        _playerView.thumbImage = self.videoModel.thumbnail;
        
        __weak typeof(self) weakSelf = self;
        _playerView.closeBlock = ^(){
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _playerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.playerView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
