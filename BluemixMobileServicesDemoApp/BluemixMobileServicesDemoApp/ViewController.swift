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

class ViewController: UIViewController {
    
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
        
        self.AverageScores[MovieCharacter.RonBurgandy] = ToneScore()
        self.AverageScores[MovieCharacter.DarthVader] = ToneScore()
        self.AverageScores[MovieCharacter.JackSparrow] = ToneScore()
        self.AverageScores[MovieCharacter.JamesBond] = ToneScore()
        
        for s:String in RonB_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.addScoreToAverage(rawScore, character: MovieCharacter.RonBurgandy)
        }
        
        for s:String in DarthV_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.addScoreToAverage(rawScore, character: MovieCharacter.DarthVader)
        }
        
        for s:String in JackS_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.addScoreToAverage(rawScore, character: MovieCharacter.JackSparrow)
        }
        
        for s:String in JamesB_Quotes{
            let rawScore:JSON = []//get real tone analysis
            self.addScoreToAverage(rawScore, character: MovieCharacter.JamesBond)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ronBurgandy(sender: AnyObject) {

    }
    
    @IBAction func darthVader(sender: AnyObject) {
        
    }
    
    @IBAction func jackSparrow(sender: AnyObject) {
        
    }
    
    @IBAction func bondJamesBond(sender: AnyObject) {
        
    }
    
    @IBAction func compareUserToCharacters(sender: AnyObject) {
        
        let username = "your-username-here"
        let password = "your-password-here"
        let speechToText = SpeechToText(username: username, password: password)
        
        // define transcription settings
        var settings = TranscriptionSettings(contentType: .L16(rate: 44100, channels: 1))
        settings.continuous = true
        settings.interimResults = true
        
        // start streaming audio and print transcripts
        let failure = { (error: NSError) in print(error) }
        let stopStreaming = speechToText.transcribe(settings, failure: failure) { results in
            print(results.last?.alternatives.last?.transcript)
        }
        
        
        // Streaming will continue until either an end-of-speech event is detected by
        // the Speech to Text service or the `stopStreaming` function is executed.
        
    }
    
    private func addScoreToAverage(rawJSON:JSON, character:MovieCharacter){
        
    }
}