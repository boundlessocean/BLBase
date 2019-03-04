//
//  BLViewController.m
//  BLBase
//
//  Created by boundlessocean on 2018/10/29.
//

#import "BLViewController.h"
#import <Masonry/Masonry.h>
#import "UIBarButtonItem+Block.h"
@interface BLViewController ()
@end

@implementation BLViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    [self bs_configViewDataSourse];
    [self bs_initializeSubviews];
    [self bs_configActions];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.bs_needSwitchStatuBarStyle) {
        UIApplication.sharedApplication.statusBarStyle = !UIApplication.sharedApplication.statusBarStyle;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.bs_needSwitchStatuBarStyle) {
        UIApplication.sharedApplication.statusBarStyle = !UIApplication.sharedApplication.statusBarStyle;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - - Public
- (void)bs_initializeSubviews{
    if (self.bs_loadingView.bs_isNeedLoading) {
        [self.view addSubview:self.bs_loadingView];
        [_bs_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
}

- (void)bs_configViewDataSourse{
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    self.bs_loadingView.bs_isNeedLoading = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)bs_configActions{
    __weak typeof(self) weakself = self;
    self.bs_loadingView.bs_reloadData = ^{
        [weakself.bs_loadingView bs_showLoading];
        [weakself nt_requestData];
    };
}
- (void)nt_requestData{};
- (void)bs_configNavItem:(BLNavItemType)type
                   image:(UIImage *)image
                   title:(NSString *)title
              titleColor:(UIColor *)titleColor
                  action:(void(^)(void))itemAction{
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil
                                   action:nil];
    fixedSpace.width = 5;

    if (type) {
        self.navigationItem.leftBarButtonItems = @[fixedSpace,
                                                       [self p_configImage:image
                                                                     title:title
                                                                titleColor:titleColor
                                                                    action:itemAction]];
        
    } else{
        self.navigationItem.rightBarButtonItems = @[[self p_configImage:image
                                                                  title:title
                                                             titleColor:titleColor
                                                                 action:itemAction],
                                                    fixedSpace];
    }
}


#pragma mark - - Private
- (UIBarButtonItem *)p_configImage:(UIImage *)image
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                            action:(void(^)(void))itemAction{
        UIBarButtonItem *item;
    if (image != nil) {
        item = [UIBarButtonItem initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                        style:UIBarButtonItemStylePlain
                                  blockAction:itemAction];
    }else{
        item = [UIBarButtonItem initWithTitle:title
                                        style:UIBarButtonItemStylePlain
                                  blockAction:itemAction];
        
        NSMutableDictionary * textNormalAttr = [NSMutableDictionary dictionary];
        textNormalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        textNormalAttr[NSForegroundColorAttributeName] = titleColor;
        [item setTitleTextAttributes:textNormalAttr forState:UIControlStateNormal];
        textNormalAttr[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:0.7];
        [item setTitleTextAttributes:textNormalAttr forState:UIControlStateHighlighted];
        [item setTitleTextAttributes:textNormalAttr forState:UIControlStateSelected];
    }
    
    return item;
}


- (BLLoadingView *)bs_loadingView{
    if (!_bs_loadingView) {
        _bs_loadingView = [BLLoadingView new];
    }
    return _bs_loadingView;
}

@end






@interface BLLoadingView()
@property (nonatomic, strong) UIView *boxView;
@property (nonatomic, strong) UILabel *loadLabel;
@property (nonatomic, strong) UIImageView *failedView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) BLLoadingViewState bs_lodingState;
@end

@implementation BLLoadingView{
    dispatch_source_t _timer;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self p_initianize];
    }
    return self;
}

- (void)dealloc{
    [self bs_dismissLoading];
}

#pragma mark - - Public

- (void)bs_loadFailed:(NSString *)message
                  IMG:(UIImage *)failedIMG{
    [self bs_dismissLoading];
    _messageLabel.text = message;
    _failedView.image = failedIMG;
    _bs_lodingState = BLLoadingViewStateFailed;
    self.hidden = NO;
}

- (void)bs_dismissLoading{
    self.hidden = YES;
    self.boxView.hidden = YES;
    self.loadLabel.hidden = YES;
    _messageLabel.hidden = NO;
    _failedView.hidden = NO;
    self.userInteractionEnabled = YES;
    _bs_lodingState = BLLoadingViewStateNormol;
    [self.boxView.layer removeAnimationForKey:@"rotation"];
    if (_timer) {
        dispatch_cancel(_timer);
    }
}

- (void)bs_showLoading{
    self.hidden = NO;
    _boxView.hidden = NO;
    _loadLabel.hidden = NO;
    _messageLabel.hidden = YES;
    _failedView.hidden = YES;
    self.userInteractionEnabled = NO;
    CABasicAnimation *animation =   [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat: M_PI *2];
    animation.duration = 1.5;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    [self.boxView.layer addAnimation:animation forKey:@"rotation"];
    
    
    __block NSInteger i = 0;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        self.bs_lodingState = BLLoadingViewStateLoding;
        if (i%3 == 0) {
            self->_loadLabel.text = @"加载中.";
        }else if (i%3 == 1){
            self->_loadLabel.text = @"加载中..";
        }else if (i%3 == 2){
            self->_loadLabel.text = @"加载中...";
        }
        i++;
    });
    if (_timer) {
        dispatch_resume(_timer);
    }
}

#pragma mark - - Private
- (void)p_initianize{
    self.backgroundColor = [UIColor whiteColor];
    
    _bs_lodingState = BLLoadingViewStateNormol;
    [self addSubview:self.boxView];
    [self addSubview:self.loadLabel];
    [self addSubview:self.failedView];
    [self addSubview:self.messageLabel];
    [_boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [_loadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_boxView.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.boxView.mas_left).offset(-15);
    }];
    
    [_failedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self->_failedView.mas_bottom).offset(15);
    }];
}

#pragma mark - - Setter
- (void)setBs_isNeedLoading:(BOOL)bs_isNeedLoading{
    _bs_isNeedLoading = bs_isNeedLoading;
    if (_bs_isNeedLoading) {
        [self bs_showLoading];
    } else {
        [self bs_dismissLoading];
    }
}


#pragma mark - - Getter
- (UIView *)boxView{
    if (!_boxView) {
        _boxView = [UIView new];
        _boxView.layer.cornerRadius = 5;
        _boxView.layer.masksToBounds = YES;
        _boxView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor;
        _boxView.layer.borderWidth = 1;
    }
    return _boxView;
}

- (UILabel *)loadLabel{
    if (!_loadLabel) {
        _loadLabel = [UILabel new];
        _loadLabel.text = @"加载中";
        _loadLabel.font = [UIFont boldSystemFontOfSize:13];
        _loadLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }
    return _loadLabel;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = [UIColor darkGrayColor];
    }
    return _messageLabel;
}

- (UIImageView *)failedView{
    if (!_failedView) {
        _failedView = [UIImageView new];
        _failedView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _failedView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_bs_lodingState == BLLoadingViewStateFailed) {
        !_bs_reloadData ? : _bs_reloadData();
    }
}

@end
