//
//  CMWebVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/16.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class CMWebVC: CMBaseVC, WKNavigationDelegate {
    
    var webUrl: String?
    var webView: WKWebView = WKWebView()
    var progressView: UIProgressView = UIProgressView()
    var closeBtn: UIButton!
    
    override func initVC() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.navigationDelegate = self
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.navigationDelegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // webview
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        
        // progressview
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(3)
            make.top.equalToSuperview()
        }
        progressView.tintColor = UIColor.ColorBgTheme()
        progressView.isHidden = true
        
        // load url
        if webUrl != nil {
            webView.load(URLRequest(url: URL(string: webUrl!)!))
        }
        
        // shear
        self.showRightItem(image: "nav_share") {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.closeButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.closeBtn.removeFromSuperview()
    }
    
    func closeButton() {
        if self.closeBtn == nil {
            self.closeBtn = UIButton(frame: CGRect(x: 44, y: 0, width: 44, height: 44))
            self.closeBtn.setTitle("关闭", for: .normal)
            self.closeBtn.setTitleColor(UIColor.black, for: .normal)
            self.closeBtn.addAction({ (button) in
                self.navigationController!.popViewController(animated: true)
            })
            self.navigationController?.navigationBar.addSubview(self.closeBtn)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 加载进度
        if keyPath == "estimatedProgress" {
            let newprogress = change?[.newKey] as? NSNumber ?? 0.0
            let oldprogress = change?[.oldKey] as? NSNumber ?? 0.0
            
            //不要让进度条倒着走...有时候goback会出现这种情况
            if newprogress.floatValue < oldprogress.floatValue {
                return
            }
            
            if abs(newprogress.floatValue - 1) < 0.000001 {
                progressView.isHidden = true
                progressView.setProgress(0, animated: false)
            }
            else {
                progressView.isHidden = false
                progressView.setProgress(newprogress.floatValue, animated: true)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
        progressView.setProgress(0, animated: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
        progressView.setProgress(0, animated: false)
    }
    
    override func navigateBack() {
        if webView.canGoBack {
            webView.goBack()
        }
        else {
            super.navigateBack()
        }
    }
}
