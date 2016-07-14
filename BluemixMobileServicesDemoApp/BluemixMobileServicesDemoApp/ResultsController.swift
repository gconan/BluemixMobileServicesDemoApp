//
//  ResultsController.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/13/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import UIKit
import SwiftyJSON

public class ResultsController: UIViewController{
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var angerText: UITextField!
    
    @IBOutlet weak var disgustText: UITextField!
    
    @IBOutlet weak var fearText: UITextField!
    
    @IBOutlet weak var joyText: UITextField!
    
    @IBOutlet weak var sadText: UITextField!
    
    @IBOutlet weak var agreeText: UITextField!
    
    @IBOutlet weak var conText: UITextField!
    
    @IBOutlet weak var extraText: UITextField!
    
    @IBOutlet weak var openText: UITextField!
    
    @IBOutlet weak var neuroText: UITextField!
    
    @IBOutlet weak var analyticalText: UITextField!
    
    @IBOutlet weak var confidentText: UITextField!
    
    @IBOutlet weak var tentText: UITextField!
    
    public static var character:String?
    
    public var scores:[String:Double] = [:]
    
    override public func viewDidLoad() {
        nameText.text = "User \(Int(scores["Person"]!))"
        angerText.text = "\(scores["Anger"]!)"
        disgustText.text = "\(scores["Disgust"]!)"
        fearText.text = "\(scores["Fear"]!)"
        joyText.text = "\(scores["Joy"]!)"
        sadText.text = "\(scores["Sadness"]!)"
        agreeText.text = "\(scores["Agreeableness"]!)"
        conText.text = "\(scores["Conscientiousness"]!)"
        extraText.text = "\(scores["Extraversion"]!)"
        openText.text = "\(scores["Openness"]!)"
        neuroText.text = "\(scores["Emotional Range"]!)"
        analyticalText.text = "\(scores["Analytical"]!)"
        confidentText.text = "\(scores["Confident"]!)"
        tentText.text = "\(scores["Tentative"]!)"
        
        
        let alert = UIAlertController(title: "Results!", message: "Your tone most relates to \(ResultsController.character!)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cool!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override public func viewDidAppear(bool:Bool){
        let alert = UIAlertController(title: "Results!", message: "Your tone most relates to \(ResultsController.character!)", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cool!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
