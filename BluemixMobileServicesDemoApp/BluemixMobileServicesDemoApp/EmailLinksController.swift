//
//  EmailLinksController.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/5/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import UIKit
import MessageUI

class EmailLinksController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    private let body:String = "hello world"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendEmail(sender: AnyObject) {
        
        var picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("Bluemix Tone Analysis Demo App Code")
        picker.setMessageBody(body, isHTML: true)
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}