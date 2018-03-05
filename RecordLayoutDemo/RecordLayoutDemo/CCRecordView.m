//
//  CCRecordView.m
//  RecordLayoutDemo
//
//  Created by chang on 2018/3/5.
//  Copyright © 2018年 chang. All rights reserved.
//

#import "CCRecordView.h"

@implementation CCRecordView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)aTitle array:(NSArray *)aArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self viewLayoutWithTitle:aTitle array:aArray];
    }
    return self;
}

//计算关键词按钮的位置
- (void)viewLayoutWithTitle:(NSString *)aTitle array:(NSArray *)aArray
{
    if (![aArray isKindOfClass:[NSArray class]])  {
        return;
    }
    //删除当前视图所有子视图
    [self removeAllSubviews];
    
    //title
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, self.frame.size.width-12-12, 18)];
    tipLabel.font = [UIFont boldSystemFontOfSize:15];
    tipLabel.text = aTitle?:@"";
    [self addSubview:tipLabel];
    
    float zX = 12;//记录按钮的X
    float zY = 36;//记录按钮的Y
    float zH = 30;//记录按钮的高
    for (int i=0; i<aArray.count; i++) {
        
        CGSize size = [aArray[i] boundingRectWithSize:CGSizeMake(self.frame.size.width - 12*3, 18) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        
        size.width +=18;//每个按钮的长度
        
        //如果摆放的按钮大于屏幕宽 则另起一行
        if ((zX+size.width+12) > self.frame.size.width) {
            zY += zH+10;//10是按钮上下间的间隔
            zX = 12;//初始值
        }
        //最后一个按钮离底部距离
        if ((zY+zH)>self.frame.size.height) {
            CGRect sViewRect = self.frame;
            sViewRect.size.height += (10+zH); //加一个上下间隔和按钮高度
            self.frame = sViewRect;
        }
        
        UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
        buton.backgroundColor = [UIColor whiteColor];
        buton.frame = CGRectMake(zX, zY, size.width, zH);
        buton.tag = i;
        [buton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [buton setTitle:aArray[i] forState:UIControlStateNormal];
        buton.titleLabel.font = [UIFont systemFontOfSize:15];
        buton.layer.cornerRadius = 9;
        buton.layer.masksToBounds = YES;
        buton.layer.borderWidth = 1;
        buton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [buton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buton];
        
        zX += buton.frame.size.width+12;//12是按钮左右间的间隔
    }
}

- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"点击第%ld个按钮",(long)sender.tag);
}

- (void)removeAllSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
