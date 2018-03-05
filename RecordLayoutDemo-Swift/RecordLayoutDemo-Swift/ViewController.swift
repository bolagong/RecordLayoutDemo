//
//  ViewController.swift
//  RecordLayoutDemo-Swift
//
//  Created by chang on 2018/3/5.
//  Copyright © 2018年 chang. All rights reserved.
//

import UIKit

let  MAIN_SCREEN_WIDTH = UIScreen.main.bounds.width
let  MAIN_SCREEN_HEIGHT = UIScreen.main.bounds.height

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //模拟的数据
        let recordArray = ["Classical","摇滚","art","rock","波普哈哈","pop","说唱", "pop","rap","雷鬼","reg","gae","索尔", "古典音","Pop","music:", "流","行音乐","Bl", "蓝调歌曲","忧郁音乐","Rock", "Roll","electrophonic", "music", "电","音乐","ambient", "情境音乐","trance","舞曲","classical","摇滚乐","Jazz"]
        //封装的view
        let recordView = CCRecordView.init(aFrame: CGRect.init(x: 0, y: 100, width: MAIN_SCREEN_WIDTH, height: 120), aTitle: "这里有记录", aArray: recordArray as NSArray)
        self.view.addSubview(recordView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

