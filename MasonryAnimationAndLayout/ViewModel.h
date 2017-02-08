//
//  ViewModel.h
//  MasonryAnimationAndLayout
//
//  Created by Jeffrey hu on 16/12/26.
//  Copyright © 2016年 Jeffrey hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

// 是否展开
@property (nonatomic, assign, getter = isExpand)   BOOL expand;

// 内容
@property (nonatomic, copy)     NSString *info;
// 标题
@property (nonatomic, copy)     NSString *title;
// 下标
@property (nonatomic, assign)   NSInteger index;

@end
