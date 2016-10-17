//
//  CMShareImage.swift
//  CHScreenShot
//
//  Created by 麦志泉 on 2016/10/14.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

class CMShareImageView: UIView {

    // 成员变量
    var bottomHeight: CGFloat = 90
    var padding: UIEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15)
    var logoSize: CGSize {
        return CGSize(width: bottomHeight * 0.7,
                      height: bottomHeight * 0.7)
    }
    var screenshotImage: UIImage!              //要分享的图片
    var appLogo: UIImage!                      //app的logo
    var userAvatar: UIImage?                   //用户的头像
    var userName: String = ""                  //用户名
    var shareText: String = ""                 //分享的文本
    var qrCode: String = ""             //二维码内容
    var infoBackgroundColor = UIColor.white
    var labelFont = UIFont.systemFont(ofSize: 15)
    var labelColor = UIColor.darkGray

   
    
    var image: UIImage {                        //生成截图
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return capturedImage!
    }
    
    convenience init(
        screenshotImage: UIImage,
        appLogo: UIImage,
        qrCode: String,
        userAvatar: UIImage? = nil,
        userName: String = "",
        shareText: String = "",
        infoBackgroundColor: UIColor
        ) {
        self.init()
        self.screenshotImage = screenshotImage
        self.appLogo = appLogo
        self.qrCode = qrCode
        self.userAvatar = userAvatar
        self.userName = userName
        self.shareText = shareText
        self.infoBackgroundColor = infoBackgroundColor
        self.frame = CGRect(x: 0, y: 0,
                            width: self.screenshotImage.size.width,
                            height: self.screenshotImage.size.height + bottomHeight)
        
    }
    
    override func draw(_ rect: CGRect) {
        
        var isAppLogoDraw = false
        
        //绘制白色背景
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.infoBackgroundColor.cgColor)
        context?.fill (rect)
        
        //绘制分享的图片
        self.screenshotImage.draw(at: CGPoint(x: 0, y: 0))
        
        var startX: CGFloat = rect.origin.x + self.padding.left
        let startY: CGFloat = self.screenshotImage.size.height
        
        //绘制用户头像
        if let userAvatarImage = self.userAvatar {
            userAvatarImage.draw(in: CGRect(x: startX,
                                            y: startY + (bottomHeight - logoSize.width) / 2,
                                            width: logoSize.width, height: logoSize.width))
            
            
        } else {
            //没有用户头像就绘制AppLogo替代
            self.appLogo.draw(in: CGRect(x: startX,
                                         y: startY + (bottomHeight - logoSize.height) / 2,
                                         width: logoSize.width, height: logoSize.height))
            
            isAppLogoDraw = true
            
        }
        
        startX = startX + logoSize.width + 10
        
        //绘制分享文字内容
        if !shareText.isEmpty {
            
            let fontAttributes: [String: Any] = [
                NSFontAttributeName: labelFont,
                NSForegroundColorAttributeName: labelColor
            ]
            
            let textSize = shareText.ch_sizeWithConstrained(labelFont)
            
            NSString(string: shareText).draw(
                at: CGPoint(x: startX,
                            y: startY + (bottomHeight - textSize.height) / 2), withAttributes: fontAttributes)
        }
        
        //从尾部计算
        startX = rect.origin.x + rect.size.width - self.logoSize.width - self.padding.right
        
        //未绘制AppLogo在尾部绘制
        if !isAppLogoDraw {
            
            self.appLogo.draw(in: CGRect(x: startX,
                                         y: startY + (bottomHeight - logoSize.height) / 2,
                                         width: logoSize.width, height: logoSize.height))
            
            startX = startX - logoSize.width - 10
        }
        
        //绘制二维码
        if !qrCode.isEmpty {
            let qrImage = createQRForString(qrString: qrCode)
            
            qrImage.draw(in: CGRect(x: startX,
                                         y: startY + (bottomHeight - (logoSize.width)) / 2,
                                         width: logoSize.width, height: logoSize.width))
        }

    }
}
