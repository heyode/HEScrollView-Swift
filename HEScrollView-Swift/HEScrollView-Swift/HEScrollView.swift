//
//  HEScrollView.swift
//  WaterShop
//
//  Created by Mac on 2017/6/19.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class HEScrollView: UIView {

    var images = [UIImage](){
        didSet{
            pageControl?.numberOfPages = images.count
            pageControl?.currentPage = 0
            
            refreshViewContent()
        }
    }
    var pageImgs = [UIImage](){
        didSet{
            self.pageControl?.setValue(pageImgs, forKey: "_pageImages")
        }
    }
    
    var pageLightImgs = [UIImage](){
        didSet{
            self.pageControl?.setValue(pageLightImgs, forKey: "_currentPageImages")
        }
    }
    
//    var urls = [URL](){
//        didSet{
//            self.pageControl?.numberOfPages = urls.count
//            self.pageControl?.currentPage = 0;
//           self.refreshViewContent()
//        }
//    }
    let tagBase = 700
    let  COMMONMARGIN = 10
    let  imageViewCount = 3
    let  ANIMATIONTIME = 5.0
    // 是否垂直滚动
    var isVertical = false
    var currentPageNum = -1
    // 是否隐藏页码
    var isHidePagControl = false
    var  scrollView : UIScrollView?
    var timer : Timer?
    var pageControl : UIPageControl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView?.frame = self.bounds
        
        
        let verticalSize =  CGSize.init(width: (scrollView?.frame.width)!, height: CGFloat(imageViewCount) * (scrollView?.frame.height)!)
        let horizontalSize = CGSize.init(width: (scrollView?.frame.width)! * CGFloat(imageViewCount), height:  (scrollView?.frame.height)!)
        self.scrollView?.contentSize = isVertical ? verticalSize : horizontalSize
        for i in 0..<imageViewCount {
            let imageV = scrollView?.subviews[i]
            let imageVerticalFrame =  CGRect.init(x: 0, y: CGFloat(i) * (scrollView?.frame.height)!, width: (scrollView?.frame.size.width)!, height: (self.scrollView?.frame.size.height)!)
            let imageHorizontalSize =  CGRect.init(x:  CGFloat(i) * (scrollView?.frame.width)!, y:0, width: (scrollView?.frame.size.width)!, height: (self.scrollView?.frame.size.height)!)
            imageV?.frame = isVertical ? imageVerticalFrame : imageHorizontalSize
        }
        let  pageControlH : CGFloat = 20;
        let  pageControlW : CGFloat = self.scrollView!.frame.size.width - 20;
        let  pageControlX : CGFloat = (self.scrollView!.frame.size.width - pageControlW)/2;
        let  pageControlY : CGFloat = self.scrollView!.frame.size.height - pageControlH - 10;
        
        self.pageControl?.frame = CGRect.init(x: pageControlX, y: pageControlY, width: pageControlW, height: pageControlH);
        
//        self.pageControl?.pageIndicatorTintColor = UIColor.white
//        self.pageControl?.currentPageIndicatorTintColor = UIColor.gray
        self.refreshViewContent()

    }
    
    func initSubViews()  {
        scrollView = UIScrollView.init()
//        scrollView?.backgroundColor = UIColor.red
        scrollView?.isPagingEnabled = true
        scrollView?.bounces = false
        scrollView?.delegate = self
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView!)
        
        for _ in 1...imageViewCount {
            let imageV = UIImageView.init()
           imageV.contentMode = .scaleToFill
            scrollView?.addSubview(imageV)
            
        }
        
        
        pageControl = UIPageControl.init()
        self.addSubview(pageControl!)
        pageControl?.isHidden = isHidePagControl
        self.addTimer()
    }
    func refreshViewContent() {
        pageControl?.currentPage =  currentPageNum
        for i in 0..<imageViewCount {
            var index = pageControl?.currentPage
            guard index != nil else {
                return
            }
            if i == 0 {
                index! -= 1
            }else if(i == 2){
                index! += 1
            }
            if index! < 0 {
                index = (pageControl?.numberOfPages)! - 1
            }else if (index! >= (pageControl?.numberOfPages)! ){
                index = 0
            }
          
            let imgV = scrollView?.subviews[i] as! UIImageView
            guard images.count > index! else {
                return
            }
          
            if index! < 0 {
                return
            }
//            imgV.titleLab.text = titles[index!]
            imgV.image = images[index!]
//            imgV.kf.setImage(with: urls[index!])
            
            imgV.tag = index! + tagBase
          
        }
        let verticalPointOffset = CGPoint.init(x: 0, y: (scrollView?.frame.size.height)!)
        let horizontalContentOffset =  CGPoint.init(x: (scrollView?.frame.size.width)!, y: 0)
        self.scrollView?.contentOffset = isVertical ? verticalPointOffset : horizontalContentOffset
    }
    
   
    
    func addTimer()  {
        timer = Timer.init(timeInterval: ANIMATIONTIME, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    @objc func nextPage() {
        let verticalPointOffset = CGPoint.init(x: 0, y:CGFloat(2) * (scrollView?.frame.height)!)
        let horizontalContentOffset =  CGPoint.init(x: CGFloat(2) * (scrollView?.frame.size.width)!, y: 0)
        scrollView?.setContentOffset(isVertical ? verticalPointOffset : horizontalContentOffset, animated: true)
    }
    
    
}

extension HEScrollView : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var  minDistance  = CGFloat(MAXFLOAT);
         currentPageNum = 0
        for i in 0..<imageViewCount {
        let view = scrollView.subviews[i]
            let verticalDistance = abs(view.frame.origin.y - (self.scrollView?.contentOffset.y)!)
            let horizontalDistance = abs(view.frame.origin.x - (self.scrollView?.contentOffset.x)!)
            if (isVertical ? verticalDistance : horizontalDistance) < minDistance {
                minDistance = isVertical ? verticalDistance : horizontalDistance
                currentPageNum = view.tag - tagBase
            }
        }
      
       
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let timer = self.timer {
            timer.invalidate()
            
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.addTimer()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.refreshViewContent()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.refreshViewContent()
    }
}
