//
//  CommonMusicMainViewController.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicMainViewController.h"

@interface CommonMusicMainViewController ()

@property (nonatomic, strong) NSDictionary *data;

//@property (nonatomic, strong) MPMoviePlayerController *playController;

@property (nonatomic, assign) float screenWidth;

@property (nonatomic, strong) UIImageView *songImageView;

@property (nonatomic, strong) UIButton *preButton;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, assign) BOOL isPlay;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *currentTimeLabel;

@property (nonatomic, strong) UILabel *totalTimeLabel;

@property (nonatomic, assign) float totalTime;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) AVAudioPlayer *thePlayer;

@end

@implementation CommonMusicMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _screenWidth = COMMON_SCREEN_WIDTH;
    _isPlay = YES;
    self.view.backgroundColor = [UIColor grayColor];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_thePlayer stop];
    [_timer invalidate];
}


-(void)initUI {
    NSString *url = DEFAULT_BLANK_IN_DICTIONARY(_data, @"url");
    
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *localUrl=[bundle pathForResource:@"bigbang-sober" ofType:@"mp3"];
//    _playController = [[MPMoviePlayerController alloc] initWithContentURL:STRING_IS_BLANK(localUrl)?[NSURL URLWithString:url]:[NSURL fileURLWithPath:localUrl]];
//    _playController.view.frame = CGRectMake(0, 0,_screenWidth , 200);
//    _playController.controlStyle = MPMovieControlStyleNone;
//    _playController.shouldAutoplay = NO;
//    _playController.repeatMode = MPMovieRepeatModeOne;
//    _playController.scalingMode = MPMovieScalingModeAspectFit;
//    [_playController play];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *musicURL = [NSURL fileURLWithPath:localUrl];
    
    _thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    
    [_thePlayer prepareToPlay];
    
    [_thePlayer setVolume:1];   //设置音量大小
    
    _thePlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
    
    [_thePlayer play];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
    _songImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 80, _screenWidth - 80, _screenWidth - 80)];
    _songImageView.layer.cornerRadius = 10;
    _songImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_songImageView];
    [_songImageView setImageUrl:[_data objectForKey:@"picture"]];
    
    float x = 60;
    float space = (_screenWidth - x * 2 - 3 * 40)/2;
    
    _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _preButton.layer.cornerRadius = 20;
    _preButton.frame = CGRectMake(x, _songImageView.bottom + 30, 40, 40);
    _preButton.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_preButton];
    [_preButton setImage:[UIImage imageLoader:@"music_pre"] forState:UIControlStateNormal];

    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.layer.cornerRadius = 20;
    _playButton.frame = CGRectMake(_preButton.right + space, _songImageView.bottom + 30, 40, 40);
    [self.contentView addSubview:_playButton];
    _playButton.backgroundColor = [UIColor whiteColor];
    [_playButton setImage:[UIImage imageLoader:!_isPlay?@"music_play":@"music_pause"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.layer.cornerRadius = 20;
    _nextButton.frame = CGRectMake(_playButton.right + space, _songImageView.bottom + 30, 40, 40);
    [self.contentView addSubview:_nextButton];
    _nextButton.backgroundColor = [UIColor whiteColor];
    [_nextButton setImage:[UIImage imageLoader:@"music_next"] forState:UIControlStateNormal];
    
    float bottomTop = _nextButton.bottom + 30;
    
    _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, bottomTop - 15, 30, 30)];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font = [UIFont getHeitiSCFont:10];
    _currentTimeLabel.text = @"00:00";
    [self.contentView addSubview:_currentTimeLabel];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(_currentTimeLabel.right + 10, bottomTop, _screenWidth - 120, 10)];
    [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [_slider setThumbImage:[UIImage imageLoader:@"music_play_progress"] forState:UIControlStateNormal];
    [self.contentView addSubview:_slider];
    
    _totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_slider.right + 10, bottomTop - 15, 30, 30)];
    _totalTimeLabel.textColor = [UIColor whiteColor];
    _totalTimeLabel.font = [UIFont getHeitiSCFont:10];
    [self.contentView addSubview:_totalTimeLabel];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}



-(void)valueChange:(UISlider *)slider {
    float chooseTime = slider.value * _totalTime;
    [_thePlayer setCurrentTime:chooseTime];
    
}


-(void)updateProgress {
    
    float playTime = _thePlayer.currentTime;
    
    if(_totalTime == 0) {
        _totalTime = _thePlayer.duration;
        
        _totalTimeLabel.text = [NSString stringWithFormat:@"%zi:%zi",(int)(_totalTime / 60),((int)_totalTime) % 60];
    }
    
    if (playTime > 0){
        float percent = playTime / _totalTime;
        _currentTimeLabel.text = [NSString stringWithFormat:@"%zi:%zi",(int)(playTime / 60),((int)playTime) % 60];
        [_slider setValue:percent animated:YES];
    }
}

-(void)play {
    _isPlay = !_isPlay;
    [_playButton setImage:[UIImage imageLoader:!_isPlay?@"music_play":@"music_pause"] forState:UIControlStateNormal];
    if(!_isPlay){
        [_thePlayer pause];
        if (![_timer isValid]) {
            return ;
        }
        
        [_timer setFireDate:[NSDate distantFuture]];
    } else {
        [_thePlayer play];
        if (![_timer isValid]) {
            return ;
        }
        [_timer setFireDate:[NSDate date]];
    }
}

-(void)setPageParams:(NSDictionary *)pageParams {
    _data = pageParams;
    
}


-(void)dealloc {
    SafeRelease(_thePlayer);
    SafeRelease(_data);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
