//
//  ViewController.swift
//  BluemixMobileServicesDemoApp
//
//  Created by Conan Gammel on 7/5/16.
//  Copyright © 2016 Conan Gammel. All rights reserved.
//

import UIKit
import ToneAnalyzerV3
import SpeechToTextV1
import SwiftyJSON
import BMSCore
import BMSAnalytics

class ViewController: UIViewController {
    @IBOutlet weak var sendTextButton: UIButton!
    @IBOutlet weak var textField: UITextView!
    
    //Bluemix info
    private let cloudantURL:String = "https://756b57dd-f7bb-4721-adeb-9e7f45c99497-bluemix.cloudant.com/personality_insights/"
    private let blueLogger: Logger = Logger.logger(forName: "DemoAppViewController")
    private let toneAnalyzer = ToneAnalyzer(username: "ef9ec932-f667-4c95-ad59-abee1c31b7cb", password: "UeT1J8F2oN3N", version: "2016-05-10", serviceURL: "https://gateway.watsonplatform.net/tone-analyzer/api")
    
    var AverageScores: [MovieCharacter: ToneScore] = [:]
    private var customUserCount: Int = 0
    
    //Characters
    enum MovieCharacter:String{
        case RonBurgandy = "Ron Burgandy"
        case DarthVader = "Darth Vader"
        case JackSparrow = "Jack Sparrow"
        case JamesBond = "James Bond"
        case Dory = "Dory"
    }
    
    
    //quotes
    let RonB_Quotes: [String] = ["What? You pooped in the refrigerator? And you ate the whole wheel of cheese? How’d you do that? Heck, I’m not even mad; that’s amazing.","I don't know how to put this but I'm kind of a big deal. People know me. I'm very important. I have many leather-bound books and my apartment smells of rich mahogany.", "Mmm. I look good. I mean, really good. Hey, everyone! Come and see how good I look!", "You know how to cut to the core of me, Baxter. You're so wise. You're like a miniature Buddha covered in hair.", "Guess what, I do. I know that one day Veronica and I are gonna to get married on top of a mountain, and there’s going to be flutes playing and trombones and flowers and garlands of fresh herbs. And we will dance till the sun rises. And then our children will form a family band. And we will tour the countryside and you won’t be invited."]
    
    let DarthV_Quotes: [String] = ["No, I am your father.","Don’t be too proud of this technological terror you’ve constructed. The ability to destroy a planet is insignificant next to the power of the Force. I find your lack of faith disturbing.","I am altering the deal. Pray I don’t alter it any further.","I see through the lies of the Jedi. I do not fear the dark side as you do. I have brought peace, freedom, justice, and security to my new empire.","Luke, you can destroy the Emperor. He has foreseen this. It is your destiny. Join me, and together we can rule the galaxy as father and son."]
    
    let JackS_Quotes: [String] = ["Why is the rum always gone?", "Why fight when you can negotiate?", "This is the day you will always remember as the day you almost caught me.", "The seas may be rough, but I am the captain! No matter how difficult, I will always prevail.", "Me? I'm dishonest, and a dishonest man you can always trust to be dishonest. Honestly. It's the honest ones you want to watch out for.", "You're the one in need of resucing and I'm not sure if I'm in the mood.", "Why should I sail with any of you? Four of you tried to kill me in the past, one of you succeeded."]
    
    let JamesB_Quotes: [String] = ["I don't stop when I'm tired, I stop when I'm done","It takes a certain kind of woman to wear a backless dress and a gun strapped to her thigh", "A Martini. Shaken, not stirred", "Be polite, be courteous, show professionalism, and have a plan to kill everyone in the room", "Killing and dying, it's all a matter of perspective", "My name is Bond, James Bond", "I don’t know, I’ve never lost.", "My dear girl, there are some things that just aren’t done. Such as, drinking Dom Perignon ’53 above the temperature of 38 degrees Fahrenheit. That’s just as bad as listening to the Beatles without earmuffs."]
    
    let Dory_Quotes: [String] = ["Trust, it's what friends do!","The sea monkeys have my money...Yes, I'm a natural blue", "I shall call him squishy and he will be mine and he shall be my squishy", "Wow, I wish I could speak whale", "Hey there, Mr. Grumpy Gills. When life gets you down, just keep swimming, just keep swimming, swimming, swimming.", "Yeah, be careful I don't make you cry when I win!", "Would you quit it? What, the ocean isn't big enough for you or something like that? You got a problem? Huh? Do ya, do ya, do ya? You wanna piece of me? Yeah, yeah! Ooh, I'm scared now! What?", "This is the Ocean, silly, we're not the only two in here. ","Hey, look, balloons. It is a party.","I don't know. But who cares! Ha ha! I remembered!"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customUserCount = 0
        
        //initialization of Analytics
        BMSClient.sharedInstance.initializeWithBluemixAppRoute(nil, bluemixAppGUID: nil, bluemixRegion:".stage1.ng.bluemix.net")//region set for stage1, experimental
        Analytics.initializeWithAppName("BluemixMovileServicesDemoApp", apiKey: "2baf6285-258a-48dc-9009-92036ee4a89c", deviceEvents: DeviceEvent.LIFECYCLE)
        Analytics.enabled = true
        Logger.logStoreEnabled = true
        
        
        //hide optional text input
        sendTextButton.hidden = true
        textField.hidden = true
        
        //initialize the Average scores for each character
        self.AverageScores[MovieCharacter.RonBurgandy] = ToneScore()
        self.AverageScores[MovieCharacter.DarthVader] = ToneScore()
        self.AverageScores[MovieCharacter.JackSparrow] = ToneScore()
        self.AverageScores[MovieCharacter.JamesBond] = ToneScore()
        self.AverageScores[MovieCharacter.Dory] = ToneScore()
        
        //get tone score for all Ron quotes
        for s:String in RonB_Quotes{
            let failure = { (error: NSError) in print("SOME ERROR: \(error)") }
            toneAnalyzer.getTone(s, failure: failure) { tones in
                self.AverageScores[MovieCharacter.RonBurgandy]?.addToAverage(tones.convertToSwiftyJSON())
            }
        }
        
        //get tone score for all Darth quotes
        for s:String in DarthV_Quotes{
            let failure = { (error: NSError) in print("SOME ERROR: \(error)") }
            toneAnalyzer.getTone(s, failure: failure) { tones in
                self.AverageScores[MovieCharacter.DarthVader]?.addToAverage(tones.convertToSwiftyJSON())
            }
        }
        
        //get tone score for all Jack quotes
        for s:String in JackS_Quotes{
            let failure = { (error: NSError) in print("SOME ERROR: \(error)") }
            toneAnalyzer.getTone(s, failure: failure) { tones in
                self.AverageScores[MovieCharacter.JackSparrow]?.addToAverage(tones.convertToSwiftyJSON())
            }
        }
        
        //get tone score for all James quotes
        for s:String in JamesB_Quotes{
            let failure = { (error: NSError) in print("SOME ERROR: \(error)") }
            toneAnalyzer.getTone(s, failure: failure) { tones in
                self.AverageScores[MovieCharacter.JamesBond]?.addToAverage(tones.convertToSwiftyJSON())
            }
        }
        
        //get tone score for all Dory quotes
        for s:String in Dory_Quotes{
            let failure = { (error: NSError) in print("SOME ERROR: \(error)") }
            toneAnalyzer.getTone(s, failure: failure) { tones in
                self.AverageScores[MovieCharacter.Dory]?.addToAverage(tones.convertToSwiftyJSON())
            }
        }
        
        //allow tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ronBurgandy(sender: AnyObject) {
        //log to analytics, can use to count number of times the button is clicked
        blueLogger.info("Ron Burgandy")
        
        //build a request with BMSCore
        let request = Request(url: cloudantURL, method: HttpMethod.POST)
        request.headers = ["Content-Type":"application/json"]
        
        //get the average as a JSON object and add character name
        var ronJSON = AverageScores[MovieCharacter.RonBurgandy]!.toJSON()
        ronJSON["Person"] = JSON(MovieCharacter.RonBurgandy.rawValue)
        
        //get string to pass as body to request then send
        if let ronJSONstring = ronJSON.rawString(){
            request.sendString(ronJSONstring, completionHandler:nil)//send to cloudant
            blueLogger.info("Successfully sent Ron's ToneScore to Cloudant")
        }else{
            blueLogger.warn("Unable to convert Ron's ToneScore into a String")
        }
        
        //send info to analytics
        Logger.send()
        Analytics.send()
    }
    
    @IBAction func darthVader(sender: AnyObject) {
        //log to analytics, can use to count number of times the button is clicked
        blueLogger.info("Darth Vader")
        
        //build a request with BMSCore
        let request = Request(url: cloudantURL, method: HttpMethod.POST)
        request.headers = ["Content-Type":"application/json"]
        
        //get the average as a JSON object and add character name
        var darthJSON = AverageScores[MovieCharacter.DarthVader]!.toJSON()
        darthJSON["Person"] = JSON(MovieCharacter.DarthVader.rawValue)
        
        //get string to pass as body to request then send
        if let darthJSONstring = darthJSON.rawString(){
            request.sendString(darthJSONstring, completionHandler:nil)//send to cloudant
            blueLogger.info("Successfully sent Darth's ToneScore to Cloudant")
        }else{
            blueLogger.warn("Unable to convert Darth's ToneScore into a String")
        }
        
        Logger.send()
        Analytics.send()
    }
    
    @IBAction func jackSparrow(sender: AnyObject) {
        //log to analytics, can use to count number of times the button is clicked
        blueLogger.info("Jack Sparrow")
        
        //build a request with BMSCore
        let request = Request(url: cloudantURL, method: HttpMethod.POST)
        request.headers = ["Content-Type":"application/json"]
        
        //get the average as a JSON object and add character name
        var jackJSON = AverageScores[MovieCharacter.JackSparrow]!.toJSON()
        jackJSON["Person"] = JSON(MovieCharacter.JackSparrow.rawValue)
        
        //get string to pass as body to request then send
        if let jackJSONstring = jackJSON.rawString(){
            request.sendString(jackJSONstring, completionHandler:nil)//send to cloudant
            blueLogger.info("Successfully sent Jack's ToneScore to Cloudant")
        }else{
            blueLogger.warn("Unable to convert Jack's ToneScore into a String")
        }
        
        Logger.send()
        Analytics.send()
    }
    
    @IBAction func bondJamesBond(sender: AnyObject) {
        //log to analytics, can use to count number of times the button is clicked
        blueLogger.info("James Bond")
        
        //build a request with BMSCore
        let request = Request(url: cloudantURL, method: HttpMethod.POST)
        request.headers = ["Content-Type":"application/json"]
        
        //get the average as a JSON object and add character name
        var jamesJSON = AverageScores[MovieCharacter.JamesBond]!.toJSON()
        jamesJSON["Person"] = JSON(MovieCharacter.JamesBond.rawValue)
        
        //get string to pass as body to request then send
        if let jamesJSONstring = jamesJSON.rawString(){
            request.sendString(jamesJSONstring, completionHandler:nil)//send to cloudant
            blueLogger.info("Successfully sent James' ToneScore to Cloudant")
        }else{
            blueLogger.warn("Unable to convert James' ToneScore into a String")
        }

        Logger.send()
        Analytics.send()
    }
    
    @IBAction func dory(sender: AnyObject) {
        //log to analytics, can use to count number of times the button is clicked
        blueLogger.info("Dory Fish")
        
        //build a request with BMSCore
        let request = Request(url: cloudantURL, method: HttpMethod.POST)
        request.headers = ["Content-Type":"application/json"]
        
        //get the average as a JSON object and add character name
        var doryJSON = AverageScores[MovieCharacter.Dory]!.toJSON()
        doryJSON["Person"] = JSON(MovieCharacter.Dory.rawValue)
        
        //get string to pass as body to request then send
        if let doryJSONstring = doryJSON.rawString(){
            request.sendString(doryJSONstring, completionHandler:nil)//send to cloudant
            blueLogger.info("Successfully sent Dory's ToneScore to Cloudant")
        }else{
            blueLogger.warn("Unable to convert Dory's ToneScore into a String")
        }
        
        Logger.send()
        Analytics.send()
    }
    
    @IBAction func compareUserToCharacters(sender: AnyObject) {
        
        //initialize speech to text with SDK
        let username = "3e93abac-f01d-44e2-81a4-04bc2fbcbc23"
        let password = "ngmjfHMNKPEW"
        let speechToText = SpeechToText(username: username, password: password)
        
        // define transcription settings
        var settings = TranscriptionSettings(contentType: .L16(rate: 44100, channels: 1))
        settings.continuous = false //stops recording when there is a long pause in speech
        settings.interimResults = false //only returns the final result
        
        // start streaming audio
        let failure = { (error: NSError) in print(error) }
        let stopStreaming = speechToText.transcribe(settings, failure: failure) { results in
            let failure = { (error: NSError) in print("\(error)") }
            let speech = results.last?.alternatives.last?.transcript
            self.toneAnalyzer.getTone(speech!, failure: failure) { tones in
                //convert toneAnalysis to swiftyJSON and add Person
                var payload:JSON = tones.convertToSwiftyJSON()
                payload["Person"] = JSON("User\(self.customUserCount)")
                
                //form request
                let request = Request(url: self.cloudantURL, method: HttpMethod.POST)
                request.headers = ["Content-Type":"application/json"]
                
                if let userString = payload.rawString(){
                    request.sendString(userString, completionHandler:nil)//send to cloudant
                    self.blueLogger.info("Successfully sent User\(self.customUserCount) ToneScore to Cloudant")
                }else{
                    self.blueLogger.warn("Unable to convert User\(self.customUserCount) ToneScore into a String")
                }
                
                Logger.send()
                Analytics.send()
            }
        }
        
        customUserCount = customUserCount + 1
        
    }
    
    @IBAction func typeManualMessage(sender: AnyObject) {
        //show text field for manually entering text to be analyzed
        textField.hidden = !textField.hidden
        sendTextButton.hidden = !sendTextButton.hidden
    }
    @IBAction func analyzeToneOfText(sender: AnyObject) {
        
        let text = textField.text
        let failure = { (error: NSError) in print(error) }
        self.toneAnalyzer.getTone(text!, failure: failure) { tones in
            //convert toneAnalysis to swiftyJSON and add Person
            var payload:JSON = tones.convertToSwiftyJSON()
            payload["Person"] = JSON("User\(self.customUserCount)")
            
            //form request
            let request = Request(url: self.cloudantURL, method: HttpMethod.POST)
            request.headers = ["Content-Type":"application/json"]
            
            if let userString = payload.rawString(){
                request.sendString(userString, completionHandler:nil)//send to cloudant
                self.blueLogger.info("Successfully sent User\(self.customUserCount) ToneScore to Cloudant")
            }else{
                self.blueLogger.warn("Unable to convert User\(self.customUserCount) ToneScore into a String")
            }
            
            Logger.send()
            Analytics.send()
        }
        customUserCount = customUserCount + 1
    }
}