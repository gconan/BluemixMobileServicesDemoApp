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
    
    private let blueLogger: Logger = Logger.logger(forName: "DemoAppViewController")
    
    @IBOutlet weak var sendTextButton: UIButton!
    
    @IBOutlet weak var textField: UITextView!
    
    private var customUserCount: Int = 0
    
    private let jsonString: String = "{\"_id\": \"personality3\",\"Person\":\"JamesBond\",\"document_tone\": {\"tone_categories\": [{\"tones\": [{\"score\": 0.328916,\"tone_id\": \"anger\",\"tone_name\": \"Anger\"},{\"score\": 0.781419,\"tone_id\": \"disgust\",\"tone_name\": \"Disgust\"},{\"score\": 0.100935,\"tone_id\": \"fear\",\"tone_name\": \"Fear\"},{\"score\": 0.022298,\"tone_id\": \"joy\",\"tone_name\": \"Joy\"},{\"score\": 0.306449,\"tone_id\": \"sadness\",\"tone_name\": \"Sadness\"}],\"category_id\": \"emotion_tone\",\"category_name\": \"Emotion Tone\"},{\"tones\": [{\"score\": 0,\"tone_id\": \"analytical\",\"tone_name\": \"Analytical\"},{\"score\": 0,\"tone_id\": \"confident\",\"tone_name\": \"Confident\"},{\"score\": 0.831,\"tone_id\": \"tentative\",\"tone_name\": \"Tentative\"}],\"category_id\": \"language_tone\",\"category_name\": \"Language Tone\"},{\"tones\": [{\"score\": 0.071,\"tone_id\": \"openness_big5\",\"tone_name\": \"Openness\"},{\"score\": 0.017,\"tone_id\": \"conscientiousness_big5\",\"tone_name\": \"Conscientiousness\"},{\"score\": 0.966,\"tone_id\": \"extraversion_big5\",\"tone_name\": \"Extraversion\"},{\"score\": 0.558,\"tone_id\": \"agreeableness_big5\",\"tone_name\": \"Agreeableness\"},{\"score\": 0.62,\"tone_id\": \"emotional_range_big5\",\"tone_name\": \"Emotional Range\"}],\"category_id\": \"social_tone\",\"category_name\": \"Social Tone\"}]}}"
    
    var AverageScores: [MovieCharacter: ToneScore] = [:]
    
    //JSON parsing helpers
    let Score = "score"
    let Document = "document_tone"
    let ToneCategories = "tone_categories"
    let Tones = "tones"
    
    //Characters
    enum MovieCharacter{
        case RonBurgandy
        case DarthVader
        case JackSparrow
        case JamesBond
    }
    
    
    //quotes
    let RonB_Quotes: [String] = ["What? You pooped in the refrigerator? And you ate the whole wheel of cheese? How’d you do that? Heck, I’m not even mad; that’s amazing.","I don't know how to put this but I'm kind of a big deal. People know me. I'm very important. I have many leather-bound books and my apartment smells of rich mahogany.", "Mmm. I look good. I mean, really good. Hey, everyone! Come and see how good I look!", "You know how to cut to the core of me, Baxter. You're so wise. You're like a miniature Buddha covered in hair.", "Guess what, I do. I know that one day Veronica and I are gonna to get married on top of a mountain, and there’s going to be flutes playing and trombones and flowers and garlands of fresh herbs. And we will dance till the sun rises. And then our children will form a family band. And we will tour the countryside and you won’t be invited."]
    
    let DarthV_Quotes: [String] = ["No, I am your father.","Don’t be too proud of this technological terror you’ve constructed. The ability to destroy a planet is insignificant next to the power of the Force. I find your lack of faith disturbing.","I am altering the deal. Pray I don’t alter it any further.","I see through the lies of the Jedi. I do not fear the dark side as you do. I have brought peace, freedom, justice, and security to my new empire.","Luke, you can destroy the Emperor. He has foreseen this. It is your destiny. Join me, and together we can rule the galaxy as father and son."]
    
    let JackS_Quotes: [String] = ["Why is the rum always gone?", "Why fight when you can negotiate?", "This is the day you will always remember as the day you almost caught me.", "The seas may be rough, but I am the captain! No matter how difficult, I will always prevail.", "Me? I'm dishonest, and a dishonest man you can always trust to be dishonest. Honestly. It's the honest ones you want to watch out for.", "You're the one in need of resucing and I'm not sure if I'm in the mood.", "Why should I sail with any of you? Four of you tried to kill me in the past, one of you succeeded."]
    
    let JamesB_Quotes: [String] = ["I don't stop when I'm tired, I stop when I'm done","It takes a certain kind of woman to wear a backless dress and a gun strapped to her thigh", "A Martini. Shaken, not stirred", "Be polite, be courteous, show professionalism, and have a plan to kill everyone in the room", "Killing and dying, it's all a matter of perspective", "My name is Bond, James Bond", "I don’t know, I’ve never lost.", "My dear girl, there are some things that just aren’t done. Such as, drinking Dom Perignon ’53 above the temperature of 38 degrees Fahrenheit. That’s just as bad as listening to the Beatles without earmuffs."]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            //print(json["Person"])
            //print(json["document_tone"]["tone_categories"])
        
        
        let categories = json["document_tone"]["tone_categories"]
        
                for (index,tone):(String, JSON) in categories{
                    let id = tone["category_id"]
                    print("ID: \(id)")
                    print("Index: \(index)")
                    print("Tone: \(tone)")
//                    if id == Emotions.tone.rawValue{
//        
//                    }
                }
        
        }
        
        customUserCount = 0
        
        BMSClient.sharedInstance.initializeWithBluemixAppRoute(nil, bluemixAppGUID: nil, bluemixRegion:".stage1.ng.bluemix.net") //You can change the region
        Analytics.initializeWithAppName("BluemixMovileServicesDemoApp", apiKey: "2baf6285-258a-48dc-9009-92036ee4a89c", deviceEvents: DeviceEvent.LIFECYCLE)

        
        sendTextButton.hidden = true
        textField.hidden = true
        
        let username = "ef9ec932-f667-4c95-ad59-abee1c31b7cb"
        let password = "UeT1J8F2oN3N"
        let version = "2016-05-10" // use today's date for the most recent version
        let toneAnalyzer = ToneAnalyzer(username: username, password: password, version: version)
        
        let text = "I don't stop when I'm tired, I stop when I'm done"
        let failure = { (error: NSError) in print("SOME ERROR: \(error)") }
        toneAnalyzer.getTone(text, failure: failure) { tones in
            print(tones)
        }
        
        self.AverageScores[MovieCharacter.RonBurgandy] = ToneScore()
        self.AverageScores[MovieCharacter.DarthVader] = ToneScore()
        self.AverageScores[MovieCharacter.JackSparrow] = ToneScore()
        self.AverageScores[MovieCharacter.JamesBond] = ToneScore()
        
        for s:String in RonB_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.AverageScores[MovieCharacter.RonBurgandy]?.addToAverage(rawScore)
        }
        
        for s:String in DarthV_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.AverageScores[MovieCharacter.DarthVader]?.addToAverage(rawScore)
        }
        
        for s:String in JackS_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.AverageScores[MovieCharacter.JackSparrow]?.addToAverage(rawScore)
        }
        
        for s:String in JamesB_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.AverageScores[MovieCharacter.JamesBond]?.addToAverage(rawScore)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        

        Analytics.enabled = true
        Logger.logStoreEnabled = true
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ronBurgandy(sender: AnyObject) {
        //upload to cloudant
        //https://$USERNAME.cloudant.com/$DATABASE
        blueLogger.info("Ron Burgandy")
        
    }
    
    @IBAction func darthVader(sender: AnyObject) {
        //upload to cloudant
        blueLogger.info("Darth Vader")
         
    }
    
    @IBAction func jackSparrow(sender: AnyObject) {
        //upload to cloudant
        blueLogger.info("Jack Sparrow")
        
    }
    
    @IBAction func bondJamesBond(sender: AnyObject) {
        //upload to cloudant
        let logger = Logger.logger(forName: "BondLogger")
        logger.info("James Bond")
        
    }
    
    @IBAction func compareUserToCharacters(sender: AnyObject) {
        
        let username = "3e93abac-f01d-44e2-81a4-04bc2fbcbc23"
        let password = "ngmjfHMNKPEW"
        let speechToText = SpeechToText(username: username, password: password)
        
        // define transcription settings
        var settings = TranscriptionSettings(contentType: .L16(rate: 44100, channels: 1))
        settings.continuous = false
        settings.interimResults = false
        
        // start streaming audio and print transcripts
        let failure = { (error: NSError) in print(error) }
        let stopStreaming = speechToText.transcribe(settings, failure: failure) { results in
            //if results.last?.final == true {
                print(results.last?.alternatives.last?.transcript)
            //}
        }
        
        customUserCount = customUserCount + 1
        
    }
    @IBAction func doneSpeaking(sender: AnyObject) {
        Logger.send()
        Analytics.send()
    }
    @IBAction func typeManualMessage(sender: AnyObject) {
        
        textField.hidden = !textField.hidden
        sendTextButton.hidden = !sendTextButton.hidden
    }
    @IBAction func analyzeToneOfText(sender: AnyObject) {
        
        let username = "ef9ec932-f667-4c95-ad59-abee1c31b7cb"
        let password = "UeT1J8F2oN3N"
        let version = "2016-07-14" // use today's date for the most recent version
        let toneAnalyzer = ToneAnalyzer(username: username, password: password, version: version)
        
        let text = textField.text
        let failure = { (error: NSError) in print(error) }
        toneAnalyzer.getTone(text, failure: failure) { tones in
            print(tones)
        }
        customUserCount = customUserCount + 1
    }
}