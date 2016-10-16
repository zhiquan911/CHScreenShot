//
//  CHScreenShotExtension.swift
//  CHScreenShot
//
//  Created by 麦志泉 on 2016/10/16.
//  Copyright © 2016年 bitbank. All rights reserved.
//

import UIKit

public extension String {
    
    /**
     计算文字的宽度
     
     - parameter width:
     - parameter font:
     
     - returns:
     */
    public func ch_sizeWithConstrained(_ font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.size
    }
    
}

public extension UIImage {
    
    
    /// 添加分享信息
    ///
    /// - parameter appLogo:             应用logo
    /// - parameter userAvatar:          用户头像
    /// - parameter userName:            用户名
    /// - parameter shareText:           分享信息内容
    /// - parameter infoBackgroundColor: 信息背景颜色
    ///
    /// - returns: 合成后的图片
    public func ch_addShareInfo(
        appLogo: UIImage,
        qrCode: String,
        userAvatar: UIImage? = nil,
        userName: String = "",
        shareText: String = "",
        infoBackgroundColor: UIColor = UIColor.white
        ) -> UIImage {
        let newImage = CMShareImageView(
            screenshotImage: self,
            appLogo: appLogo,
            qrCode: qrCode,
            userAvatar: userAvatar,
            userName: userName,
            shareText: shareText,
            infoBackgroundColor: infoBackgroundColor)
        
        return newImage.image
    }
}

public extension UIView {
    
    /// 截屏
    ///
    /// - returns:
    public func ch_screenShot() -> UIImage? {
        //截屏
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}

public extension UIViewController {
    
    // 截屏+弹出视图
    public func ch_showScreenShotView(
        screenshotImage: UIImage,
        items: [CHControlItem] = [CHControlItem](),
        itemLayout: UILayoutConstraintAxis = UILayoutConstraintAxis.horizontal) {
        
        //弹出截图显示的view
        let vc = CHShowScreenShotView()
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.items = items
        vc.screenshotImage = screenshotImage
        vc.itemLayout = itemLayout
        
        self.present(vc, animated: true)
        
    }
}

public extension UIApplication {
    
    
    /// 截屏
    ///
    /// - returns:
    public func ch_takeScreenshot() -> UIImage? {
        let vc = self.keyWindow?.rootViewController
        //截屏
        let img = vc?.view.ch_screenShot()
        return img
    }
    
}
