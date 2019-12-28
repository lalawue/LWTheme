//
//  ViewController.m
//  LWTheme
//
//  Created by lalawue on 2019/12/8.
//  Copyright © 2019 lalawue. All rights reserved.
//

#import "ViewController.h"
#import <LWThemeObjC/LWThemeObjC-umbrella.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageNamed;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *imageButton;

@property (nonatomic, strong) UILabel *attrLabel;
@property (nonatomic, strong) UISwitch *switchButton;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIButton *actionButton;
@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadThemeWithMode:LWThemeMode_Light];
    
    // title label
    self.titleLabel.lw_textColor = @"TitleLabel";
    [self.navigationController.navigationBar addSubview:self.titleLabel];

    self.navigationController.navigationBar.lw_barTintColor = @"NavBarTintColor";
    self.view.lw_backgroundColor = @"#909090"; ///< #RGBA, fixed color
    
    [self.view addSubview:self.tableView];
    
    // sub views
    UIImage *image = [UIImage imageNamed:@"wifi_icon"];
    
    // image view
    self.imageNamed.lw_imageName = @"sign_icon";
    
    // image view
    [self.imageView lw_setImage:image withTintColor:@"ImageTintColor"];
    
    // UIImage button
    self.imageButton.titleLabel.lw_font = @"ImageButtonFont";
    [self.imageButton lw_setTitleColor:@"TitleLabel" forState:UIControlStateNormal];
    [self.imageButton lw_setBackgroundImage:image withTintColor:@"ImageButtonTint" forState:UIControlStateNormal];
    self.imageButton.layer.lw_borderColor = @"ImageButtonBorder";
    
    // attr label
    self.attrLabel.lw_font = @"AttrStringFont";
    [self.attrLabel lw_setAttributes:@{ NSForegroundColorAttributeName : @"LabelAttrString",
                                        NSBackgroundColorAttributeName : @"LabelAttrBackground"}
                               range:NSMakeRange(0, 11)];
    [self.attrLabel lw_setAttributes:@{ NSForegroundColorAttributeName : @"LabelAttrBackground",
                                        NSBackgroundColorAttributeName : @"LabelAttrString"}
                               range:NSMakeRange(11, self.attrLabel.attributedText.length - 11)];
    
    // switch
    self.switchButton.lw_onTintColor = @"SwitchOnTint";
    self.switchButton.lw_tintColor = @"SwitchThumb";
    self.switchButton.lw_thumbTintColor = @"SwitchThumb";
    
    // gradient layer
    self.gradientLayer.lw_colors = @[@"GradientLayerStart", @"GradientLayerEnd"];
    
    // button
    [self.actionButton lw_setTitleColor:@"ActionButtonTitle" forState:UIControlStateNormal];
    self.actionButton.lw_backgroundColor = @"ActionButtonBackground"; ///< color from map
    [self.view addSubview:self.actionButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChangeTheme)
                                                 name:kLWThemeModeUpdateNotification
                                               object:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    CGSize navBarSize = self.navigationController.navigationBar.bounds.size;
    self.titleLabel.center = CGPointMake(navBarSize.width/2, navBarSize.height/2);
    
    CGSize viewSize = self.view.frame.size;
    self.actionButton.center = CGPointMake(viewSize.width/2, viewSize.height - 80);
    self.tableView.frame = self.view.bounds;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if ([LWThemeManager sharedInstance].isDarkMode) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0: height = self.imageNamed.frame.size.height; break;
        case 1: height = self.imageView.frame.size.height; break;
        case 2: height = self.imageButton.frame.size.height; break;
        case 3: height = self.attrLabel.frame.size.height; break;
        case 4: height = self.switchButton.frame.size.height; break;
        case 5: height = self.gradientLayer.frame.size.height; break;
        default:
            break;
    }
    return height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"UIImage\nimageNamed";
            cell.textLabel.numberOfLines = 2;
            [cell.contentView addSubview:self.imageNamed];
            break;
            
        case 1:
            cell.textLabel.text = @"UIImageView\ntint image";
            cell.textLabel.numberOfLines = 2;
            [cell.contentView addSubview:self.imageView];
            break;
            
        case 2:
            cell.textLabel.text = @"UIButton\ntitle color\nfont family:size\nborder color\ntint background image";
            cell.textLabel.numberOfLines = 5;
            [cell.contentView addSubview:self.imageButton];
            break;
            
        case 3:
            cell.textLabel.text = @"UILabel\ntext color\nattributed string color\nfont family:size";
            cell.textLabel.numberOfLines = 4;
            [cell.contentView addSubview:self.attrLabel];
            break;
            
        case 4:
            cell.textLabel.text = @"UISwitch";
            [cell.contentView addSubview:self.switchButton];
            break;
            
        case 5:
            cell.textLabel.text = @"CAGradientLayer";
            [cell.contentView.layer addSublayer:self.gradientLayer];
            break;
            
        default:
            break;
    }
    return cell;
}



#pragma mark -

- (void)onChangeTheme
{
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)onAction:(id)sender
{
    if ([LWThemeManager sharedInstance].isDarkMode) {
        [self loadThemeWithMode:LWThemeMode_Light];
    } else {
        [self loadThemeWithMode:LWThemeMode_Dark];
    }
}

#pragma mark -

- (void)loadThemeWithMode:(LWThemeMode)themMode
{
    NSDictionary *dict = @{ @(LWThemeMode_Light) : @"LightMap",
                            @(LWThemeMode_Dark) : @"DarkMap"};
    NSString *fileName = dict[@(themMode)];
    if (fileName.length) {
        [[LWThemeManager sharedInstance] useThemeMode:themMode
                                         withThemeMap:[self themeMapWithName:fileName]];
    }
}

- (NSDictionary *)themeMapWithName:(NSString *)name
{
    if (name.length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
        return [NSDictionary dictionaryWithContentsOfFile:path];
    } else {
        return nil;
    }
}

#pragma mark -

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 35)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Title Label Color";
    }
    return _titleLabel;
}

- (UIImageView *)imageNamed
{
    if (!_imageNamed) {
        _imageNamed = [[UIImageView alloc] initWithFrame:CGRectMake(24, 10, 100, 100)];
    }
    return _imageNamed;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 10, 100, 100)];
    }
    return _imageView;
}

- (UIButton *)imageButton
{
    if (!_imageButton) {
        _imageButton = [[UIButton alloc] initWithFrame:CGRectMake(24, 10, 100, 100)];
        [_imageButton setTitle:@"Button" forState:UIControlStateNormal];
        _imageButton.layer.cornerRadius = 50;
        _imageButton.layer.masksToBounds = YES;
        _imageButton.layer.cornerRadius = 4;
        _imageButton.layer.borderWidth = 1;
    }
    return _imageButton;
}

- (UILabel *)attrLabel
{
    if (!_attrLabel) {
        _attrLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 10, 300, 80)];
        _attrLabel.font = [UIFont boldSystemFontOfSize:22];
        _attrLabel.textAlignment = NSTextAlignmentLeft;
        _attrLabel.attributedText = [[NSAttributedString alloc] initWithString:@"Attributed  String"];
    }
    return _attrLabel;
}

- (UISwitch *)switchButton
{
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(24, 10, 70, 40)];
        _switchButton.on = YES;
    }
    return _switchButton;
}

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(24, 10, 100, 100);
        _gradientLayer.cornerRadius = 50;
        _gradientLayer.masksToBounds = YES;
    }
    return _gradientLayer;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180, 35)];
        _actionButton.layer.cornerRadius = 4;
        _actionButton.layer.masksToBounds = YES;
        [_actionButton setTitle:@"Change Theme" forState:UIControlStateNormal];
        [_actionButton addTarget:self action:@selector(onAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
