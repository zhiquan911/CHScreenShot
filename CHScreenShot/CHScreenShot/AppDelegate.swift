//
//  AppDelegate.swift
//  CHScreenShot
//
//  Created by apple on 2016/10/6.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var rootViewController: UINavigationController {
        let vc = self.window!.rootViewController as! UINavigationController
        return vc
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //开启监听截图工具
        CHScreenShotManager.shared.enable = true
        CHScreenShotManager.shared.didTakeScreenshot = {
            (image, vc) in
            
            if let image = image {
                //分享按钮
                let shareBtn = CHControlItem(
                    title: "分享",
                    titleColor: UIColor.white,
                    backgroundColor: UIColorFromRGB(0xE10B17),
                    cornerRadius: 5,
                    action: {
                        (screenShotView) in
                        
                        //把image转为分享的图片样式
                        let newImage = screenShotView.screenshotImage.ch_addShareInfo(
                            appLogo: UIImage(named: "swift")!,
                            qrCode: "www.chbtc.com",
                            shareText: "扫描图片右侧二维码\n随时随地掌握大行情")
                        
                        //展示效果图
                        let sharevc = ShareViewController()
                        sharevc.shareImage = newImage
                        vc?.present(sharevc, animated: true)
                })
                
                //取消按钮
                let cancelBtn = CHControlItem(
                    title: "取消",
                    titleColor: UIColor.white,
                    backgroundColor: UIColorFromRGB(0x999999),
                    cornerRadius: 5,
                    action: {
                        (screenShotView) in
                        screenShotView.dismissView()
                })
                
                vc?.ch_showScreenShotView(screenshotImage: image,
                                          items: [shareBtn, cancelBtn])
            }
            
        }
        
        return true
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
}

