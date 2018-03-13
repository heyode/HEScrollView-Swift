//
//  ViewController.swift
//  HEScrollView-Swift
//
//  Created by Mac on 2018/3/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let  scrollView = HEScrollView.init(frame: view.bounds)
        view.addSubview(scrollView)
        var images = [UIImage]()
        var pageImgs = [UIImage]()
        var pageCurrentImgs = [UIImage]()
        for i in 0...8 {
            let image = UIImage.init(named:String.init(format: "image-%d", i))
            let pageImg = UIImage.init(named:String.init(format:  "%d",i))
            let pageCurrntImg = UIImage.init(named: String.init(format: "%d_filled", i))
            images.append(image!)
            pageImgs.append(pageImg!)
            pageCurrentImgs.append(pageCurrntImg!)
        }
       
        
        // 设置图片
        scrollView.images = images
//        scrollView.isVertical = true
//        // 设置页码高亮背景图
//        scrollView.pageLightImgs = pageCurrentImgs
//        // 设置页码普通背景图
//        scrollView.pageImgs = pageImgs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

