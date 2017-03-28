//
//  ViewController.swift
//  LoggingKitClient
//
//  Created by ramon.pineda on 2/16/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import LoggingKit

class ViewController: UIViewController {

    @IBOutlet weak var shakeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake
        {
            let navController = UINavigationController(rootViewController: LoggingKitDetailViewController())
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchLogs(_ sender: Any) {
        let navController = UINavigationController(rootViewController: LoggingKitDetailViewController())
        self.present(navController, animated: true, completion: nil)
    }

    @IBAction func randomLog(_ sender: Any) {

        let requestMO = RequestMO()
        requestMO.deviceID = "0123456789012345678901234567890123456789"
        requestMO.message = "i am debugging"
        requestMO.headerString = "test ramon error"
        requestMO.loggingLevel = LoggingLevel.DEBUG
        requestMO.requestBodyString = "test debug string"
        requestMO.responseBodyString = "Any resources that your views need, such as images, styles, and scripts, should be placed in the Public folder at the root of your application."
        requestMO.serviceURL = "http://amazon.com"
        requestMO.save();

    }

}
