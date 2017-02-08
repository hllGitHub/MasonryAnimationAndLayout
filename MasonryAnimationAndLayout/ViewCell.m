//
//  ViewCell.m
//  MasonryAnimationAndLayout
//
//  Created by Jeffrey hu on 16/12/26.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "ViewCell.h"
#define MAS_SHORTHAND
#import <Masonry.h>
#import "ViewModel.h"

static CGFloat padding = 10.f;
static CGFloat infoFontSize = 15.f;
static CGFloat titleFontSize = 18.f;
@interface ViewCell ()

// 标题label
@property (nonatomic, strong)   UILabel *titleLabel;

// 说明label
@property (nonatomic, strong)   UILabel *infoLabel;

// 展开收回button
@property (nonatomic, strong)   UIButton *expandButton;

// 图片
@property (nonatomic, strong)   UIImageView *iconImageView;

// 分割线
@property (nonatomic, strong)   UIView *lineView;

@end

@implementation ViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setupCostranins];
    }
    return self;
}

- (void)initView {
    // titleLabel
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    self.titleLabel.textColor = [UIColor blueColor];
    self.titleLabel.text = @"标题";
    [self.contentView addSubview:self.titleLabel];
    
    // expandButton
    self.expandButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.expandButton setTitle:@"展开" forState:UIControlStateNormal];
    [self.expandButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.expandButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 1];
    [self.expandButton addTarget:self action:@selector(setExpandContentView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.expandButton];
    
    // infoLabel
    self.infoLabel = [UILabel new];
    self.infoLabel.font = [UIFont systemFontOfSize:infoFontSize];
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.infoLabel];
    // 这个开启的话label的高度调整时视图的显示会有变化，因为自适应
//    self.infoLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentView.bounds) - 20;
    
    // lineView
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.4 green:0.5 blue:0.6 alpha:1.0];
    [self.contentView addSubview:self.lineView];
}

- (void)setExpandContentView {
    self.model.expand = !self.model.expand;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshCellHeightWithSelectedIndex:)]) {
        [self.delegate refreshCellHeightWithSelectedIndex:self.model.index];
    }
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)setInfoStr:(NSString *)infoStr {
    _infoStr = infoStr;
    self.infoLabel.text = infoStr;
}

- (void)setModel:(ViewModel *)model {
    _model = model;
    
    self.infoLabel.text = model.info;
    self.titleLabel.text = model.title;
    
    if (model.expand) {
        self.infoLabel.numberOfLines = 0;
        [self.expandButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        self.infoLabel.numberOfLines = 4;
        [self.expandButton setTitle:@"展开全文" forState:UIControlStateNormal];
    }
    
    // 当高度不足时，隐藏button
//    [self layoutIfNeeded];
//    if (CGRectGetHeight(self.infoLabel.bounds) < (infoFontSize * 3 + 5) && self.model.expand == YES) {
//        self.expandButton.hidden = YES;
//    }
}

- (void)setupCostranins {
    // 布局
//    __weak typeof(self) weakSelf;
    
    // titleLabel
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(10);
        make.top.offset(10);
    }];
    
    // expandButton
    [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_bottom);
        make.trailing.offset(-10);
    }];
    
    // infoLabel
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.offset(-padding);
    }];
    
    // lineView
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.offset(0);
        make.top.equalTo(self.infoLabel.mas_bottom).offset(10);
        make.height.equalTo(@10);
        make.bottom.offset(0);
    }];
}

@end
