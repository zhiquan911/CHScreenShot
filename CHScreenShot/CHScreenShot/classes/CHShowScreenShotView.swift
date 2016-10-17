//
//  ShowImageViewController.swift
//  CHScreenShot
//
//  Created by apple on 2016/10/6.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit


/// 视图上的控制按钮
open class CHControlItem: NSObject {
    
    
    /// 成员变量
    open var action:((CHShowScreenShotView) -> Void)?
    open var backgroundImage: UIImage?
    open var backgroundColor: UIColor!
    open var titleColor: UIColor?
    open var title: String = ""
    open var image: UIImage?
    open var isPress: Bool = true
    open var cornerRadius: CGFloat = 0
    
    public convenience init(
        title: String,
        titleColor: UIColor = UIColor.white,
        backgroundColor: UIColor = UIColor.clear,
        image: UIImage? = nil,
        backgroundImage: UIImage? = nil,
        cornerRadius: CGFloat = 0,
        isPress: Bool = true,
        action: ((CHShowScreenShotView) -> Void)? = nil) {
        self.init()
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.image = image
        self.backgroundImage = backgroundImage
        self.isPress = isPress
        self.action = action
        self.cornerRadius = cornerRadius
    }
}


/// 截图展示视图
open class CHShowScreenShotView: UIViewController {
    
    // 成员变量
    open var paddingExt: CGFloat = 0.8
    open var itemHeight: CGFloat = 40
    open var itemLayout: UILayoutConstraintAxis = UILayoutConstraintAxis.horizontal
    open var items = [CHControlItem]()
    open var screenshotImage: UIImage!
    
    var containerView: UIView!
    var backgroundControl: UIControl!
//    var stackViewItems: UIStackView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /// 初始化要建立的View
    ///
    /// - returns:
    func initView() {
        
        self.view.backgroundColor = UIColor.clear
        
        var totalHeight: CGFloat = itemHeight
        if self.itemLayout == .vertical {
            totalHeight = CGFloat(self.items.count) * itemHeight
        }
        
        //创建背景的ControlView
        self.backgroundControl = UIControl()
        self.backgroundControl.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.backgroundControl.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundControl.addTarget(self, action: #selector(self.dismissView),
                      for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.backgroundControl)
        
        //创建容器的View
        self.containerView = UIView()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.layer.cornerRadius = 8
        self.containerView.layer.masksToBounds = true
        self.view.addSubview(self.containerView)
        
        //添加背景截图
        //合成图片
        let screenImageView = UIImageView(image: screenshotImage)
        screenImageView.translatesAutoresizingMaskIntoConstraints = false
        screenImageView.contentMode = .scaleToFill
        self.containerView.addSubview(screenImageView)
        
        
        /// 创建毛玻璃效果背景
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(blurView)
        
        //创建UIStackView排列按钮
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.clear
        stackView.axis = self.itemLayout
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        blurView.contentView.addSubview(stackView)
        
        //创建按钮
        for (i, item) in self.items.enumerated() {
            let btn = UIButton(type: UIButtonType.custom)
            btn.backgroundColor = item.backgroundColor
            btn.setBackgroundImage(item.backgroundImage, for: .normal)
            btn.setTitle(item.title, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.titleLabel?.minimumScaleFactor = 0.5
            btn.setTitleColor(item.titleColor, for: .normal)
            btn.setImage(item.image, for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.layer.cornerRadius = item.cornerRadius
            btn.layer.masksToBounds = true
            btn.isUserInteractionEnabled = item.isPress
            btn.tag = i
            if item.isPress {
                btn.addTarget(self, action: #selector(self.handleButtonPress(sender:)),
                              for: UIControlEvents.touchUpInside)
            }
            
            stackView.addArrangedSubview(btn)
            
        }
   
        //布局位置
        let views: [String : Any] = [
            "containerView": self.containerView,
            "screenImageView": screenImageView,
            "blurView": blurView,
            "stackView": stackView,
            "backgroundControl": self.backgroundControl
        ]
        
        let containerSize = CGSize(width: self.view.bounds.width * paddingExt,
                                   height: self.view.bounds.height * paddingExt)
        
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[backgroundControl]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[backgroundControl]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        //居中
        self.view.addConstraint(NSLayoutConstraint(
            item: self.containerView,
            attribute: NSLayoutAttribute.centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.centerY,
            multiplier: 1,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: self.containerView,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0))
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:[containerView(\(containerSize.width))]",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[containerView(\(containerSize.height))]",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        self.containerView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[screenImageView]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        self.containerView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[screenImageView]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        self.containerView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[blurView]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        self.containerView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[blurView(>=0)]-0-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        
        blurView.contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-10-[stackView]-10-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        blurView.contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-10-[stackView(\(totalHeight))]-10-|",
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views:views))
        
        
    }
    
    
    /// 消失
    func dismissView() {
        self.dismiss(animated: true)
    }
    
    
    /// 确认按钮
    func handleButtonPress(sender: UIButton) {
        self.dismiss(animated: false) {
            let item = self.items[sender.tag]
            item.action?(self)
        }
    }
 
    
}
