//
//  ViewCell.h
//  MasonryAnimationAndLayout
//
//  Created by Jeffrey hu on 16/12/26.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewModel;
@protocol ViewCellHeightDelegate <NSObject>

- (void)refreshCellHeightWithSelectedIndex:(NSInteger)selectedIndex;

@end

@interface ViewCell : UITableViewCell

@property (nonatomic, copy)     NSString *infoStr;
@property (nonatomic, weak)     id <ViewCellHeightDelegate> delegate;
@property (nonatomic, strong)   ViewModel *model;

@end
