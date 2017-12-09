//
//  CHScreenShotManager.swift
//  CHScreenShot
//
//  Created by 麦志泉 on 2016/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

open class CHScreenShotManager: NSObject {
    
    
    /// 成员变量
    open var didTakeScreenshot: ((UIImage?, UIViewController?) -> Void)?           //回调方法
    
    /// 全局唯一实例
    open static let shared: CHScreenShotManager = {
        let instance = CHScreenShotManager()
        return instance
    }()
    
    
    /// 监听截图事件开关
    open var enable = false {
        
        didSet {
            //If not enable, enable it.
            if enable == true &&
                oldValue == false {
                //添加监听时间
                NotificationCenter.default.addObserver(self, selector: #selector(self.userDidTakeScreenshot(notification:)), name: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil)
            } else if enable == false {
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
    
    
    /// 当前显示viewController
    open var visibleViewController: UIViewController? {
        let window = UIApplication.shared.keyWindow
        let vc = window?.rootViewController
        return vc
    }
    
    
    //截屏响应
    @objc func userDidTakeScreenshot(notification: Notification) {
        let app = notification.object as? UIApplication
        let vc = app?.keyWindow?.rootViewController
        
        //截屏
        let img = app?.ch_takeScreenshot()
        self.didTakeScreenshot?(img, vc)

    }
    
}

//// MARK: - 全局方法

/// 16进制值转为颜色对象
///
/// - parameter rgbValue:
///
/// - returns:
func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


/// 创建二维码图片
///
/// - parameter qrString: 字符串
///
/// - returns:
func createQRForString(qrString: String) -> UIImage {
    let stringData = qrString.data(using: String.Encoding.utf8, allowLossyConversion: false)
    // 创建一个二维码的滤镜
    let qrFilter = CIFilter(name: "CIQRCodeGenerator")
    qrFilter?.setValue(stringData, forKey: "inputMessage")
    qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
    let qrCIImage = qrFilter?.outputImage
    // 创建一个颜色滤镜,黑白色
    let colorFilter = CIFilter(name: "CIFalseColor")
    colorFilter?.setDefaults()
    colorFilter?.setValue(qrCIImage, forKey: "inputImage")
    colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
    colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
    // 返回二维码image
    let codeImage = UIImage(ciImage: (colorFilter?.outputImage?.transformed(by: CGAffineTransform(scaleX: 5, y: 5)))!)
    return codeImage
}
