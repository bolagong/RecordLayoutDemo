//
//  CCRecordView.swift
//  RecordLayoutDemo-Swift
//
//  Created by chang on 2018/3/5.
//  Copyright © 2018年 chang. All rights reserved.
//

import UIKit

class CCRecordView: UIView {

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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //计算字体布局
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
}

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
