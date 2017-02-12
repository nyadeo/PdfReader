//
//  ViewController.swift
//  AssProject
//
//  Created by DEO NYAMPETA on 2/8/17.
//  Copyright © 2017 DEO NYAMPETA. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.bounces = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoadFile(_ sender: UIBarButtonItem) {
        let pdfPath = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Book", ofType: "pdf")!)
        webView?.loadRequest(NSURLRequest(url: pdfPath as URL) as URLRequest)
        

        view.addSubview(webView)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
    }
}

