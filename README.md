# RecordLayoutDemo
类似搜索的历史记录字体排版
<<<<<<< HEAD
=======

*  最近项目用到了类似历史记录的字体排版那样的布局，虽然网络上有好多，自己也就写了一个练练手，比较简单，有问题请留言，不喜勿喷，直接上代码。    

   *   ![效果图.png](http://upload-images.jianshu.io/upload_images/5261964-4e1ec992aee4df06.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 一.在OC中
* 封装一个view
```
/**
 * 初始化
 * @param frame     布局的视图的frame
 * @param aTitle    标题
 * @param aArray    传入的内容（数组里面是字符串）
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)aTitle array:(NSArray *)aArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self viewLayoutWithTitle:aTitle array:aArray];
    }
    return self;
}
```

```
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
```
* 在控制器中直接调用view使用
```
//模拟数据
NSArray *recordArray = @[@"Classical",@"摇滚",@"art",@"rock",@"波普哈哈",@"pop",@"说唱", @"pop",@"rap",@"雷鬼",@"reg",@"gae",@"索尔", @"古典音",@"Pop",@"music:", @"流",@"行音乐",@"Bl", @"蓝调歌曲",@"忧郁音乐",@"Rock", @"Roll",@"electrophonic", @"music", @"电",@"音乐",@"ambient", @"情境音乐",@"trance",@"舞曲",@"classical",@"摇滚乐",@"Jazz"];
//封装的那个view
CCRecordView *recordView = [[CCRecordView alloc] initWithFrame:CGRectMake(0, 100, MAIN_SCREEN_WIDTH, 120) title:@"这里有记录" array:recordArray];
[self.view addSubview:recordView];
```

### 一.在Swift中
* 和上面的oc代码一样，先创建一个CCRecordView
```
/**
     * 初始化
     * @param aFrame     布局的视图的frame
     * @param aTitle    标题
     * @param aArray    传入的内容（数组里面是字符串）
     */
    init(aFrame: CGRect, aTitle: NSString, aArray: NSArray) {
        super.init(frame: aFrame)
        
        self.backgroundColor = UIColor.lightGray
        self.viewLayoutWith(aTitle: aTitle, aArray: aArray)
    }
```
* 计算字体布局
```
func viewLayoutWith(aTitle: NSString, aArray: NSArray) {
        
        if aArray.isKind(of: NSArray.classForCoder()) == false {
            return
        }
        self.removeAllSubviews()
        //title
        let tipLabel = UILabel.init(frame: CGRect.init(x: 12, y: 12, width: self.frame.size.width-12-12, height: 18))
        tipLabel.font = UIFont.boldSystemFont(ofSize: 15)
        tipLabel.text = aTitle as String
        self.addSubview(tipLabel)
        
        var zX = CGFloat(12) //记录按钮的X
        var zY = CGFloat(36) //记录按钮的Y
        let zH = CGFloat(30) //记录按钮的高
        for (index,value) in aArray.enumerated() {
            let valueC : String = value as! String
            var size = SizeWithFont(content: valueC as NSString, font: UIFont.systemFont(ofSize: 15), maxSize: CGSize.init(width: self.frame.size.width - 12*3, height: 18))
            size.width = size.width + 18 //每个按钮的长度
            //如果摆放的按钮大于屏幕宽 则另起一行
            if (zX+size.width+12) > self.frame.size.width {
                zY = zY + (zH+10) //10是按钮上下间的间隔
                zX = 12 //初始值
            }
            //最后一个按钮离底部距离
            if (zY+zH)>self.frame.size.height {
                //加一个上下间隔和按钮高度
                self.frame.size.height = self.frame.size.height + (10+zH)
            }
            
            let buton = UIButton.init(type: .custom)
            buton.tag = index
            buton.frame = CGRect.init(x: zX, y: zY, width: size.width, height: zH)
            buton.backgroundColor = UIColor.white
            buton.setTitle(valueC as String, for: .normal)
            buton.setTitleColor(UIColor.blue, for: .normal)
            buton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            buton.layer.cornerRadius = 9
            buton.layer.masksToBounds = true
            buton.layer.borderWidth = 1
            buton.layer.borderColor = UIColor.lightGray.cgColor
            buton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            self.addSubview(buton)
            
            zX = zX + (buton.frame.size.width+12) //12是按钮左右间的间隔
        }
    }
@objc func buttonAction(sender: UIButton) {
        print("点击第\(sender.tag)个按钮")
 }
    
```
* 扩展的方法
```
extension CCRecordView {
    //removeAllSubviews
    func removeAllSubviews() {
        while self.subviews.count > 0{
            self.subviews.last?.removeFromSuperview()
        }
    }
    //font size
    func SizeWithFont(content : NSString, font : UIFont, maxSize : CGSize) -> CGSize {
        return content.boundingRect(with: maxSize, options: (NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue)), attributes: [NSAttributedStringKey.font : font], context: nil).size
    }
}
```
* 在控制器中直接调用view使用
```
//模拟的数据
NSArray *recordArray = @[@"Classical",@"摇滚",@"art",@"rock",@"波普哈哈",@"pop",@"说唱", @"pop",@"rap",@"雷鬼",@"reg",@"gae",@"索尔", @"古典音",@"Pop",@"music:", @"流",@"行音乐",@"Bl", @"蓝调歌曲",@"忧郁音乐",@"Rock", @"Roll",@"electrophonic", @"music", @"电",@"音乐",@"ambient", @"情境音乐",@"trance",@"舞曲",@"classical",@"摇滚乐",@"Jazz"];
//封装的view
CCRecordView *recordView = [[CCRecordView alloc] initWithFrame:CGRectMake(0, 100, MAIN_SCREEN_WIDTH, 120) title:@"这里有记录" array:recordArray];
[self.view addSubview:recordView];
```
>>>>>>> 提交demo
