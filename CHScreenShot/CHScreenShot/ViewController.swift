//
//  ViewController.swift
//  CHScreenShot
//
//  Created by apple on 2016/10/6.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// 分享回调
    var shareAction: ((CHShowScreenShotView) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home+Power键截屏"
        
        let button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        button1.setTitle("截屏1", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.addTarget(self, action: #selector(self.leftButton(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button1)
        
        let button2 = UIButton(type: .system)
        button2.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        button2.setTitle("截屏2", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.addTarget(self, action: #selector(self.rightButton(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button2)
        
        self.shareAction = {
            (screenShotView) in
            
            //把image转为分享的图片样式
            let newImage = screenShotView.screenshotImage.ch_addShareInfo(
                appLogo: UIImage(named: "swift")!,
                qrCode: "www.chbtc.com",
                shareText: "扫描图片右侧二维码\n随时随地掌握大行情")
            
            //展示效果图
            let sharevc = ShareViewController()
            sharevc.shareImage = newImage
            self.present(sharevc, animated: true)
        }
        
//        self.showAlertView()
    }
    
    
    //弹出alertView
    func showAlertView() {
        let alertController = UIAlertController(title: "提示",
                                                message: "尝试快捷键截屏",
                                                preferredStyle: .alert)
        

        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func leftButton(sender: UIButton) {
        
        self.shareStyle1()
    }
    
    func rightButton(sender: UIButton) {
        
        self.shareStyle2()
    }

    
    /// 样式1
    func shareStyle1() {
        
        if let image = UIApplication.shared.ch_takeScreenshot() {
            //分享按钮
            let shareBtn = CHControlItem(
                title: "分享",
                titleColor: UIColor.white,
                backgroundColor: UIColorFromRGB(0xE10B17),
                cornerRadius: 5,
                action: self.shareAction)
            
            //取消按钮
            let cancelBtn = CHControlItem(
                title: "取消",
                titleColor: UIColor.white,
                backgroundColor: UIColorFromRGB(0x999999),
                cornerRadius: 5,
                action: {
                    (screenShotView) in
                    screenShotView.dismiss()
            })
            
            self.ch_showScreenShotView(screenshotImage: image,
                                       items: [shareBtn, cancelBtn],
                                       itemLayout: .vertical)
        }
        
    }
    
    /// 样式2
    func shareStyle2() {
        
        if let image = UIApplication.shared.ch_takeScreenshot() {
            //分享按钮
            
            let shareText = CHControlItem(
                title: "分享",
                titleColor: UIColor.darkGray,
                isPress: false)
            
            let weixin = CHControlItem(
                title: "",
                titleColor: UIColor.clear,
                image: UIImage(named: "post_type_bubble_weixin")!,
                action: self.shareAction)
            
            let quan = CHControlItem(
                title: "",
                titleColor: UIColor.clear,
                image: UIImage(named: "post_type_bubble_weixinquan")!,
                action: self.shareAction)
            
            let qq = CHControlItem(
                title: "",
                titleColor: UIColor.clear,
                image: UIImage(named: "post_type_bubble_qq")!,
                action: self.shareAction)
            
            let sina = CHControlItem(
                title: "",
                titleColor: UIColor.clear,
                image: UIImage(named: "post_type_bubble_sina")!,
                action: self.shareAction)
            
            
            self.ch_showScreenShotView(screenshotImage: image,
                                       items: [shareText, weixin, quan, qq, sina])
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

