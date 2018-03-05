//
//  CCRecordView.h
//  RecordLayoutDemo
//
//  Created by chang on 2018/3/5.
//  Copyright © 2018年 chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRecordView : UIView

/**
 * 初始化
 * @param frame     布局的视图的frame
 * @param aTitle    标题
 * @param aArray    传入的内容（数组里面是字符串）
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)aTitle array:(NSArray *)aArray;

@end
