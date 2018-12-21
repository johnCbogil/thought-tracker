//
//  FeedbackVC.swift
//  ThoughtTracker
//
//  Created by John Bogil on 12/20/18.
//  Copyright © 2018 John Bogil. All rights reserved.
//

import Foundation
import WebKit
import UIKit
import Anchors

class FeedbackVC: UIViewController, WKNavigationDelegate {

    // MARK: - VIEWS
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    private lazy var webView: WKWebView = {
        let webview = WKWebView()
        webview.navigationDelegate = self
        let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdsQJBIDdaajVuxVo0YIWD1sDrzXg8aP_OnVtaN1pngw-CNFg/viewform")
        webview.load(URLRequest(url: url!))
        return webview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.webView)
        self.view.addSubview(activityIndicator)
        activate(self.webView.anchor.edges,
                 activityIndicator.anchor.center,
                 activityIndicator.anchor.size.equal.to(50)
        )
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }

}
