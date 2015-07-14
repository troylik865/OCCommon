//
//  CommonMusicCell.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicCell.h"

@interface CommonMusicCell ()

@property (nonatomic, strong) UIImageView *songImageView;

@property (nonatomic, strong) UILabel *songNameLable;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong) UIButton *downLoadButton;

@end

@implementation CommonMusicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)initUI {
    self.songImageView = [[UIImageView alloc] init];
    [self addSubview:self.songImageView];
    self.songNameLable = [[UILabel alloc] init];
    [self.songNameLable setTextColor:[UIColor redColor]];
    [self addSubview:self.songNameLable];
    
    _downLoadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downLoadButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _downLoadButton.titleLabel.font = [UIFont getHeitiSCFont:12];
    [self addSubview:_downLoadButton];
}

/**
 *  下载文件
 */
-(void)downLoadFile {
    NSString *url = [_data objectForKey:@"url"];
    [CoreHttpService getDataWithUURL:url params:nil method:@"get" needCache:YES block:^(NSData *data, NSError *error) {
        if(!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"文件下载成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alertView show];
                [self setNeedsLayout];
            });
        }
    }];
}


-(void)layoutSubviews {
    [super layoutSubviews];
    if(_data){
        self.songImageView.frame = CGRectMake(10, 10, 80, 80);
        [_songImageView setImageUrl:[_data objectForKey:@"picture"]];
        NSString *title = DEFAULT_BLANK_IN_DICTIONARY(_data, @"title");
        _songNameLable.text = title;
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:_songNameLable.font}];
        self.songNameLable.frame = CGRectMake(self.songImageView.right + 10, self.songImageView.top, size.width, size.height);
        _downLoadButton.frame = CGRectMake(self.songImageView.right + 10, self.songImageView.bottom - 20, 50, 20);
        
        NSString *url = [_data objectForKey:@"url"];
        
        NSString *localPath = [CoreHttpService fileExist:url];
        [_downLoadButton setTitle:!STRING_IS_BLANK(localPath) ? @"已下载":@"下载" forState:UIControlStateNormal];
        if(STRING_IS_BLANK(localPath)) {
            [_downLoadButton addTarget:self action:@selector(downLoadFile) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)renderUIWithData:(NSDictionary *)data {
    _data = data;
}

+(float)cellHeight:(NSDictionary *)data {
    return 100;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
