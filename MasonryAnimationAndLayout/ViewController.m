//
//  ViewController.m
//  MasonryAnimationAndLayout
//
//  Created by Jeffrey hu on 16/12/26.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import "ViewController.h"
#import "ViewCell.h"
#define MAS_SHORTHAND
#import <Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "ViewModel.h"

static NSString *kCellId = @"kCellId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ViewCellHeightDelegate>

@property (nonatomic, strong)   NSMutableArray<ViewModel *> *dataArray;
@property (nonatomic, strong)   NSMutableArray *titleArray;
@property (nonatomic, strong)   NSMutableArray *infoArray;
@property (nonatomic, strong)   UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupSubViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化
- (void)initData {
    self.infoArray = [@[@"hello world", @"hfhakdshfkhfkjadhfkjhfjhjk", @"但如果需要兼容iOS 8之前版本的话，就要回到老路子上了，主要是用systemLayoutSizeFittingSize来取高。步骤是先在数据model中添加一个height的属性用来缓存高，然后在table view的heightForRowAtIndexPath代理里static一个只初始化一次的Cell实例，然后根据model内容填充数据，最后根据cell的contentView的systemLayoutSizeFittingSize的方法获取到cell的高。具体代码如下。", @"因为布局约束就是要脱离frame这种表达方式的，可是动画是需要根据这个来执行，这里面就会有些矛盾，不过根据前面说到的布局约束的原理，在某个时刻约束也是会被还原成frame使视图显示，这个时刻可以通过layoutIfNeeded这个方法来进行控制。具体代码如下"] mutableCopy];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:self.infoArray.count];
    
    for (NSInteger i = 0; i < self.infoArray.count; i ++) {
        NSString *title = [NSString stringWithFormat:@"第%ld个标题", i + 1];
        
        ViewModel *model = [ViewModel new];
        model.title = title;
        model.index = i;
        model.info = self.infoArray[i];
        [self.dataArray addObject:model];
    }
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    self.tableView.fd_debugLogEnabled = YES;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHue:0.3 saturation:0.3 brightness:0.5 alpha:1.0];
        [_tableView registerClass:[ViewCell class] forCellReuseIdentifier:kCellId];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 80;
    }
    return _tableView;
}

#pragma mark - ViewCellHeightDelegate
- (void)refreshCellHeightWithSelectedIndex:(NSInteger)selectedIndex {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 这个自动布局
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kCellId cacheByIndexPath:indexPath configuration:^(ViewCell *cell) {
        cell.model = self.dataArray[indexPath.row];
    }];
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

@end
