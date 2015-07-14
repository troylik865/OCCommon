//
//  CommonMusicPlayListTableView.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicPlayListTableView.h"
#import "CommonMusicCell.h"

@interface CommonMusicPlayListTableView ()

@property (nonatomic, strong) NSDictionary *channel;

@property (nonatomic, strong) NSMutableArray *playList;

@end

@implementation CommonMusicPlayListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _playList = [NSMutableArray array];
    }
    return self;
}

#pragma -mark
#pragma -mark implements of UITableViewDatasource UITableViewDelegate
#pragma -mark
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"common_music_cell";
    CommonMusicCell *cell = [[CommonMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if(!cell) {
        cell = [[CommonMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(!ARRAY_IS_EMPTY(_playList)) {
        [cell renderUIWithData:[_playList objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(ARRAY_IS_EMPTY(_playList)) {
        return 50;
    }
    return [CommonMusicCell cellHeight:[_playList objectAtIndex:indexPath.row]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _playList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [_playList objectAtIndex:indexPath.row];
    [self gotoPage:@"CommonMusicMainViewController" params:data];
}


#pragma -mark
#pragma -mark 加载数据
#pragma -mark
-(void)loadMusicData {
    CommonMessage *message = [[CommonMessage alloc] initWithHttpUrl:[NSString stringWithFormat:@"%@%@",HOME_MUSIC_PLAYLIST,DEFAULT_BLANK_IN_DICTIONARY(_channel, @"seq_id")] params:nil];
    [self sendMessage:message];
}


-(void)messageSuccess:(CommonMessage *)message {
    NSDictionary *data = [message getDictionaryData];
    _playList = [data objectForKey:@"song"];
    [self reloadData];
}

-(void)messageFailed:(CommonMessage *)message {
    NSLog(@"服务调用异常");
}

-(void)refreshData {
    
}

- (void)renderUIWithData:(NSDictionary *)channel {
    _channel = channel;
}


-(void)dealloc {
    SafeRelease(self.dataSource);
    SafeRelease(self.delegate);
}

@end