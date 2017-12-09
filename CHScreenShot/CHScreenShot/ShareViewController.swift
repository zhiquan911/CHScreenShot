//
//  ShareViewController.swift
//  CHScreenShot
//
//  Created by apple on 2016/10/10.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    var shareImage: UIImage!
    
    @IBOutlet var imageViewShare: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        let GR = UITapGestureRecognizer(target: self, action: #selector(self.hiddenView(gr:)))
        self.view.addGestureRecognizer(GR)
    }
    
    
    /// 初始化VIEWS
    ///
    /// - returns:
    func initViews() {
        self.scrollView = UIScrollView(frame: self.view.bounds)
        self.scrollView.contentSize = shareImage.size
        self.view.addSubview(self.scrollView)
        
        self.imageViewShare = UIImageView(frame: CGRect(origin: CGPoint.zero, size: shareImage.size))
        self.imageViewShare.image = self.shareImage
        self.imageViewShare.contentMode = .scaleAspectFit
        self.imageViewShare.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleHeight,
            .flexibleWidth
        ]
        self.scrollView.addSubview(self.imageViewShare)
    }
    
    
    @objc func hiddenView(gr:UIGestureRecognizer) {
        self.dismiss(animated: true) { 
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
