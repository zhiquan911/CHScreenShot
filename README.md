# CHScreenShot

>Swift3编写的截屏分享组件

![test1.jpg](https://github.com/zhiquan911/CHScreenShot/blob/master/test1.jpg)
![test2.jpg](https://github.com/zhiquan911/CHScreenShot/blob/master/test2.jpg)
![test3.jpg](https://github.com/zhiquan911/CHScreenShot/blob/master/test3.jpg)

## Features

- 完美支持Swift3.0编译
- 支持设备快捷键截屏和手动截屏
- 支持扩展预览窗口的按钮样式和执行事件
- 集成使用简单，二次开发扩展强大


## Requirements

- iOS 9+
- Xcode 8+
- Swift 3.0+
- iPhone/iPad

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects.

You can install it with the following command:

```java
$ gem install cocoapods
```

To integrate Log into your Xcode project using CocoaPods, specify it in your Podfile:

```java
use_frameworks!

pod 'CHScreenShot'
```

## Example

在AppDelegate类中监听设备的快捷键截图

```swift
    
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
                        screenShotView.dismiss()
                })
                
                vc?.ch_showScreenShotView(screenshotImage: image,
                                          items: [shareBtn, cancelBtn])
            }
            
        }
        
        return true
    }

```

通过运行代码执行截屏

```swift

    /// 分享回调
    var shareAction: ((CHShowScreenShotView) -> Void)!

    /// 样式2
    func shareStyle2() {

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
```

更详细集成方法，根据实际的例子请查看源代码中的demo

## Donations

为了让开发者更积极分享技术，开源程序代码，我们发起数字货币捐助计划，捐款只接收以下货币。

- **BTC Address**:  3G4NdQQyCJK1RS5URb4h5KogWEyR4Mk16A

## License

Released under [MIT License.](https://github.com/zhiquan911/CHScreenShot/blob/master/LICENSE) 
