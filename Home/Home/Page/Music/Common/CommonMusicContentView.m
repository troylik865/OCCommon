//
//  CommonMusicContentView.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicContentView.h"
#import "CommonMusicPlayListTableView.h"

@interface CommonMusicContentView ()

@property (nonatomic, strong) NSArray *channelsArray;

@property (nonatomic, strong) NSMutableArray *playListArray;

@property (nonatomic, assign) float screenWidth;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation CommonMusicContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _playListArray = [NSMutableArray array];
        self.pagingEnabled = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trigger:) name:HOME_NOTIFICATION_TRIGGER object:nil];
    }
    return self;
}

- (void)trigger:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    if (!userInfo) {
        return;
    }
    NSInteger index = [[userInfo objectForKey:@"index"] integerValue];
    CommonMusicPlayListTableView *tableView = [_playListArray objectAtIndex:index];
    [self setContentOffset:CGPointMake(index * _screenWidth, 0) animated:YES];
    [tableView loadMusicData];
}

- (void)renderUIWithData:(NSDictionary *)data {
    _channelsArray = [data objectForKey:@"channels"];
    if (ARRAY_IS_EMPTY(_channelsArray)) {
        if (ARRAY_IS_EMPTY(_playListArray)) {
            return;
        }
        for (CommonMusicPlayListTableView *tableView in _playListArray) {
            [tableView removeFromSuperview];
        }
        [_playListArray removeAllObjects];
    }
    else {
        NSInteger count = _channelsArray.count;
        _screenWidth = COMMON_SCREEN_WIDTH;
        float height = self.height;
        float x = 0;
        for (int i = 0; i < count; i++) {
            CommonMusicPlayListTableView *tableView = [[CommonMusicPlayListTableView alloc] initWithFrame:CGRectMake(x, 0, _screenWidth, height)];
            [tableView renderUIWithData:[_channelsArray objectAtIndex:i]];
            [_playListArray addObject:tableView];
            [self addSubview:tableView];
            x += _screenWidth;
        }
        self.contentSize = CGSizeMake(_screenWidth * count, height);
        [self loadData:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    NSInteger index = x / _screenWidth;
    if(index == _currentIndex) {
        return;
    }
    _currentIndex = index;
    [[NSNotificationCenter defaultCenter] postNotificationName:HOME_NOTIFICATION_CHANNEL_CHANGE object:nil userInfo:@{ @"index":[NSNumber numberWithInteger:index]}];
    CommonMusicPlayListTableView *tableView = [_playListArray objectAtIndex:index];
    [tableView loadMusicData];
}

- (void)loadData:(NSInteger)index {
    if (ARRAY_IS_EMPTY(_playListArray)) {
        return;
    }
    CommonMusicPlayListTableView *tableView = [_playListArray objectAtIndex:index];
    [tableView loadMusicData];
}

- (void)refreshData:(NSInteger)index {
    if (ARRAY_IS_EMPTY(_playListArray)) {
        return;
    }
    CommonMusicPlayListTableView *tableView = [_playListArray objectAtIndex:index];
    [tableView refreshData];
}

- (void)dealloc {
    SafeRelease(_playListArray);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
