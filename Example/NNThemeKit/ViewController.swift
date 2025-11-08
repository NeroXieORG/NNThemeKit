//
//  ViewController.swift
//  NNThemeKit
//
//  Created by 17306472 on 11/03/2025.
//  Copyright (c) 2025 17306472. All rights reserved.
//

import UIKit
import NNThemeKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 父视图
        self.view.backgroundColor = Theme.BG2
        
        // 子视图
        let label = UILabel(frame: CGRectMake(Theme.P1, 100, 20, Theme.T1.h));
        label.font = UIFont.systemFont(ofSize: Theme.T1.f);
        label.textColor = Theme.BG2.A3 // 字体颜色根据父视图确定
        self.view.addSubview(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

