//
//  TrailerViewController.swift
//  assignment1
//
//  Created by OrcunTasdemir on 12/2/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    
    
    @IBOutlet weak var trailerView: WKWebView!
    
    //look up swift optionals
    var trailerUrl: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("passed version: ", trailerUrl)
        // Do any additional setup after loading the view.
        let myURL = trailerUrl
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    var webView: WKWebView!
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
