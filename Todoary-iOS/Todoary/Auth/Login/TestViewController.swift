//
//  TestViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import UIKit
import WebKit

class TestViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func loadView() {
         let webConfiguration = WKWebViewConfiguration()
         webView = WKWebView(frame: .zero, configuration: webConfiguration)
         webView.uiDelegate = self
         view = webView
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         
         webView.navigationDelegate = self
         
         let url = "https://appleid.apple.com/auth/authorize?client_id=com.todoary.ms.services&redirect_uri=https://todoary.com/auth/apple/redirect&response_type=code id_token&scope=name email&response_mode=form_post"

         if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let myURL = URL(string: encoded) {
                print(myURL)

             let myRequest = URLRequest(url: myURL)
             webView.load(myRequest)
         }
         
//         self.webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
     }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("요청?")
        let res = navigationResponse.response as! HTTPURLResponse
        let header = res.allHeaderFields
        print(header)

        print(res.statusCode)
        print(res.url)
        print(res.mimeType)
        
//        if(res.url?.absoluteURL == "https://todoary.com/auth/apple/redirect"){
            let session = URLSession.shared
            
        
//        webView.
        let task = session.dataTask(with: webView.url!){ (data, response, error) in
                if(error == nil){
                    let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("뭐냐")
                    print(urlContent ?? "noooooooooo")
                }else{
                    print("error")
                }
            }
        task.resume()
//        }
        
        decisionHandler(.allow)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print("변경?")
        if keyPath == #keyPath(WKWebView.url) {
            guard let url = self.webView.url?.absoluteString else {
                return
            }

            if(url == "https://todoary.com/auth/apple/redirect"){

                
                webView.evaluateJavaScript("document.getElementsByTagName('pre')[0].innerHTML") { html, error in
                    
                    print(html)
                    
                    guard let html = html as? String else {
                        print("오류?")
                        print(error as Any)
                        return
                    }
                    print(html)
                }

                guard let jsonData = try url.data(using: .utf8) else {
                    print("error")
                    return
                }
                print(jsonData)

                guard let data = try? JSONDecoder().decode(AppleLoginModel.self, from: jsonData) else {
                    print("error2")
                    return
                }
                print(data)
                
                self.dismiss(animated: true)
            }
            
        }
    }
}
