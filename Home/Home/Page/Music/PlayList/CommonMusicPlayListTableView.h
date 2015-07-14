//
//  CommonMusicPlayListTableView.h
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonMusicPlayListTableView : UITableView <UITableViewDataSource,UITableViewDelegate>


/**
 *  加载数据
 *
 */
-(void)loadMusicData;

/**
 *  刷新数据
 *
 */
-(void)refreshData;

/**
 *  根据数据进行UI的渲染
 *
 *  @param channel 频道信息
 */
- (void)renderUIWithData:(NSDictionary *)channel;

@end
