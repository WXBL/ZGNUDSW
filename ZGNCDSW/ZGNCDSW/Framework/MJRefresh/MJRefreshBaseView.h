//
//  MJRefreshBaseView.h
//  weibo
//  
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

// 如果定义了NeedAudio这个宏，说明需要音频
// 依赖于AVFoundation.framework 和 AudioToolbox.framework
#define NeedAudio

// view的高度
#define kViewHeight 65.0

typedef enum {
	RefreshStatePulling = 1,
	RefreshStateNormal = 2,
	RefreshStateRefreshing = 3
} RefreshState;

typedef enum {
    RefreshViewTypeHeader = -1,
    RefreshViewTypeFooter = 1
} RefreshViewType;

@class MJRefreshBaseView;

typedef void (^BeginRefreshingBlock)(MJRefreshBaseView *refreshView);

@protocol MJRefreshBaseViewDelegate <NSObject>
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView;
@end

@interface MJRefreshBaseView : UIView
{
    // 父控件
    __unsafe_unretained UIScrollView *_scrollView;
    // 代理
    __unsafe_unretained id<MJRefreshBaseViewDelegate> _delegate;
    // 回调
    BeginRefreshingBlock _beginRefreshingBlock;
    
    // 子控件
    __unsafe_unretained UILabel *_lastUpdateTimeLabel;
	__unsafe_unretained UILabel *_statusLabel;
    __unsafe_unretained UIImageView *_arrowImage;
	__unsafe_unretained UIActivityIndicatorView *_activityView;
    
    // 状态
    RefreshState _state;

#ifdef NeedAudio
    // 音效
//    SystemSoundID _normalId;
//    SystemSoundID _pullId;
//    SystemSoundID _refreshingId;
//    SystemSoundID _endRefreshId;
#endif
}

// 构造方法
- (id)initWithScrollView:(UIScrollView *)scrollView;

// 内部的控件
@property (nonatomic, unsafe_unretained, readonly) UILabel *lastUpdateTimeLabel;
@property (nonatomic, unsafe_unretained, readonly) UILabel *statusLabel;
@property (nonatomic, unsafe_unretained, readonly) UIImageView *arrowImage;

// 回调
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;
// 代理
@property (nonatomic, unsafe_unretained) id<MJRefreshBaseViewDelegate> delegate;
// 设置要显示的父控件
@property (nonatomic, unsafe_unretained) IBOutlet UIScrollView *scrollView;

// 是否正在刷新
@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;
// 开始刷新
- (void)beginRefreshing;
// 结束刷新
- (void)endRefreshing;
// 结束使用、释放资源
- (void)free;

// 交给子类去实现
- (void)setState:(RefreshState)state;
@end